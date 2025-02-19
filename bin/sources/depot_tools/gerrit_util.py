# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""
Utilities for requesting information for a gerrit server via https.

https://gerrit-review.googlesource.com/Documentation/rest-api.html
"""

import base64
import contextlib
import cookielib
import httplib  # Still used for its constants.
import json
import logging
import netrc
import os
import re
import socket
import stat
import sys
import tempfile
import time
import urllib
import urlparse
from cStringIO import StringIO

import gclient_utils
from third_party import httplib2

LOGGER = logging.getLogger()
TRY_LIMIT = 5


# Controls the transport protocol used to communicate with gerrit.
# This is parameterized primarily to enable GerritTestCase.
GERRIT_PROTOCOL = 'https'


class GerritError(Exception):
  """Exception class for errors commuicating with the gerrit-on-borg service."""
  def __init__(self, http_status, *args, **kwargs):
    super(GerritError, self).__init__(*args, **kwargs)
    self.http_status = http_status
    self.message = '(%d) %s' % (self.http_status, self.message)


class GerritAuthenticationError(GerritError):
  """Exception class for authentication errors during Gerrit communication."""


def _QueryString(param_dict, first_param=None):
  """Encodes query parameters in the key:val[+key:val...] format specified here:

  https://gerrit-review.googlesource.com/Documentation/rest-api-changes.html#list-changes
  """
  q = [urllib.quote(first_param)] if first_param else []
  q.extend(['%s:%s' % (key, val) for key, val in param_dict.iteritems()])
  return '+'.join(q)


def GetConnectionObject(protocol=None):
  if protocol is None:
    protocol = GERRIT_PROTOCOL
  if protocol in ('http', 'https'):
    return httplib2.Http()
  else:
    raise RuntimeError(
        "Don't know how to work with protocol '%s'" % protocol)


class Authenticator(object):
  """Base authenticator class for authenticator implementations to subclass."""

  def get_auth_header(self, host):
    raise NotImplementedError()

  @staticmethod
  def get():
    """Returns: (Authenticator) The identified Authenticator to use.

    Probes the local system and its environment and identifies the
    Authenticator instance to use.
    """
    if GceAuthenticator.is_gce():
      return GceAuthenticator()
    return CookiesAuthenticator()


class CookiesAuthenticator(Authenticator):
  """Authenticator implementation that uses ".netrc" or ".gitcookies" for token.

  Expected case for developer workstations.
  """

  def __init__(self):
    self.netrc = self._get_netrc()
    self.gitcookies = self._get_gitcookies()

  @classmethod
  def get_new_password_message(cls, host):
    assert not host.startswith('http')
    # Assume *.googlesource.com pattern.
    parts = host.split('.')
    if not parts[0].endswith('-review'):
      parts[0] += '-review'
    url = 'https://%s/new-password' % ('.'.join(parts))
    return 'You can (re)generate your credentials by visiting %s' % url

  @classmethod
  def get_netrc_path(cls):
    path = '_netrc' if sys.platform.startswith('win') else '.netrc'
    return os.path.expanduser(os.path.join('~', path))

  @classmethod
  def _get_netrc(cls):
    # Buffer the '.netrc' path. Use an empty file if it doesn't exist.
    path = cls.get_netrc_path()
    content = ''
    if os.path.exists(path):
      st = os.stat(path)
      if st.st_mode & (stat.S_IRWXG | stat.S_IRWXO):
        print >> sys.stderr, (
            'WARNING: netrc file %s cannot be used because its file '
            'permissions are insecure.  netrc file permissions should be '
            '600.' % path)
      with open(path) as fd:
        content = fd.read()

    # Load the '.netrc' file. We strip comments from it because processing them
    # can trigger a bug in Windows. See crbug.com/664664.
    content = '\n'.join(l for l in content.splitlines()
                        if l.strip() and not l.strip().startswith('#'))
    with tempdir() as tdir:
      netrc_path = os.path.join(tdir, 'netrc')
      with open(netrc_path, 'w') as fd:
        fd.write(content)
      os.chmod(netrc_path, (stat.S_IRUSR | stat.S_IWUSR))
      return cls._get_netrc_from_path(netrc_path)

  @classmethod
  def _get_netrc_from_path(cls, path):
    try:
      return netrc.netrc(path)
    except IOError:
      print >> sys.stderr, 'WARNING: Could not read netrc file %s' % path
      return netrc.netrc(os.devnull)
    except netrc.NetrcParseError as e:
      print >> sys.stderr, ('ERROR: Cannot use netrc file %s due to a '
                            'parsing error: %s' % (path, e))
      return netrc.netrc(os.devnull)

  @classmethod
  def get_gitcookies_path(cls):
    if os.getenv('GIT_COOKIES_PATH'):
      return os.getenv('GIT_COOKIES_PATH')
    return os.path.join(os.environ['HOME'], '.gitcookies')

  @classmethod
  def _get_gitcookies(cls):
    gitcookies = {}
    path = cls.get_gitcookies_path()
    if not os.path.exists(path):
      return gitcookies

    try:
      f = open(path, 'rb')
    except IOError:
      return gitcookies

    with f:
      for line in f:
        try:
          fields = line.strip().split('\t')
          if line.strip().startswith('#') or len(fields) != 7:
            continue
          domain, xpath, key, value = fields[0], fields[2], fields[5], fields[6]
          if xpath == '/' and key == 'o':
            login, secret_token = value.split('=', 1)
            gitcookies[domain] = (login, secret_token)
        except (IndexError, ValueError, TypeError) as exc:
          LOGGER.warning(exc)

    return gitcookies

  def _get_auth_for_host(self, host):
    for domain, creds in self.gitcookies.iteritems():
      if cookielib.domain_match(host, domain):
        return (creds[0], None, creds[1])
    return self.netrc.authenticators(host)

  def get_auth_header(self, host):
    auth = self._get_auth_for_host(host)
    if auth:
      return 'Basic %s' % (base64.b64encode('%s:%s' % (auth[0], auth[2])))
    return None

  def get_auth_email(self, host):
    """Best effort parsing of email to be used for auth for the given host."""
    auth = self._get_auth_for_host(host)
    if not auth:
      return None
    login = auth[0]
    # login typically looks like 'git-xxx.example.com'
    if not login.startswith('git-') or '.' not in login:
      return None
    username, domain = login[len('git-'):].split('.', 1)
    return '%s@%s' % (username, domain)


# Backwards compatibility just in case somebody imports this outside of
# depot_tools.
NetrcAuthenticator = CookiesAuthenticator


class GceAuthenticator(Authenticator):
  """Authenticator implementation that uses GCE metadata service for token.
  """

  _INFO_URL = 'http://metadata.google.internal'
  _ACQUIRE_URL = ('http://metadata/computeMetadata/v1/instance/'
                  'service-accounts/default/token')
  _ACQUIRE_HEADERS = {"Metadata-Flavor": "Google"}

  _cache_is_gce = None
  _token_cache = None
  _token_expiration = None

  @classmethod
  def is_gce(cls):
    if os.getenv('SKIP_GCE_AUTH_FOR_GIT'):
      return False
    if cls._cache_is_gce is None:
      cls._cache_is_gce = cls._test_is_gce()
    return cls._cache_is_gce

  @classmethod
  def _test_is_gce(cls):
    # Based on https://cloud.google.com/compute/docs/metadata#runninggce
    try:
      resp, _ = cls._get(cls._INFO_URL)
    except (socket.error, httplib2.ServerNotFoundError):
      # Could not resolve URL.
      return False
    return resp.get('metadata-flavor') == 'Google'

  @staticmethod
  def _get(url, **kwargs):
    next_delay_sec = 1
    for i in xrange(TRY_LIMIT):
      if i > 0:
        # Retry server error status codes.
        LOGGER.info('Encountered server error; retrying after %d second(s).',
                    next_delay_sec)
        time.sleep(next_delay_sec)
        next_delay_sec *= 2

      p = urlparse.urlparse(url)
      c = GetConnectionObject(protocol=p.scheme)
      resp, contents = c.request(url, 'GET', **kwargs)
      LOGGER.debug('GET [%s] #%d/%d (%d)', url, i+1, TRY_LIMIT, resp.status)
      if resp.status < httplib.INTERNAL_SERVER_ERROR:
        return (resp, contents)

  @classmethod
  def _get_token_dict(cls):
    if cls._token_cache:
      # If it expires within 25 seconds, refresh.
      if cls._token_expiration < time.time() - 25:
        return cls._token_cache

    resp, contents = cls._get(cls._ACQUIRE_URL, headers=cls._ACQUIRE_HEADERS)
    if resp.status != httplib.OK:
      return None
    cls._token_cache = json.loads(contents)
    cls._token_expiration = cls._token_cache['expires_in'] + time.time()
    return cls._token_cache

  def get_auth_header(self, _host):
    token_dict = self._get_token_dict()
    if not token_dict:
      return None
    return '%(token_type)s %(access_token)s' % token_dict


def CreateHttpConn(host, path, reqtype='GET', headers=None, body=None):
  """Opens an https connection to a gerrit service, and sends a request."""
  headers = headers or {}
  bare_host = host.partition(':')[0]

  auth = Authenticator.get().get_auth_header(bare_host)
  if auth:
    headers.setdefault('Authorization', auth)
  else:
    LOGGER.debug('No authorization found for %s.' % bare_host)

  url = path
  if not url.startswith('/'):
    url = '/' + url
  if 'Authorization' in headers and not url.startswith('/a/'):
    url = '/a%s' % url

  if body:
    body = json.JSONEncoder().encode(body)
    headers.setdefault('Content-Type', 'application/json')
  if LOGGER.isEnabledFor(logging.DEBUG):
    LOGGER.debug('%s %s://%s%s' % (reqtype, GERRIT_PROTOCOL, host, url))
    for key, val in headers.iteritems():
      if key == 'Authorization':
        val = 'HIDDEN'
      LOGGER.debug('%s: %s' % (key, val))
    if body:
      LOGGER.debug(body)
  conn = GetConnectionObject()
  conn.req_host = host
  conn.req_params = {
      'uri': urlparse.urljoin('%s://%s' % (GERRIT_PROTOCOL, host), url),
      'method': reqtype,
      'headers': headers,
      'body': body,
  }
  return conn


def ReadHttpResponse(conn, accept_statuses=frozenset([200])):
  """Reads an http response from a connection into a string buffer.

  Args:
    conn: An Http object created by CreateHttpConn above.
    accept_statuses: Treat any of these statuses as success. Default: [200]
                     Common additions include 204, 400, and 404.
  Returns: A string buffer containing the connection's reply.
  """
  sleep_time = 0.5
  for idx in range(TRY_LIMIT):
    response, contents = conn.request(**conn.req_params)

    # Check if this is an authentication issue.
    www_authenticate = response.get('www-authenticate')
    if (response.status in (httplib.UNAUTHORIZED, httplib.FOUND) and
        www_authenticate):
      auth_match = re.search('realm="([^"]+)"', www_authenticate, re.I)
      host = auth_match.group(1) if auth_match else conn.req_host
      reason = ('Authentication failed. Please make sure your .gitcookies file '
                'has credentials for %s' % host)
      raise GerritAuthenticationError(response.status, reason)

    # If response.status < 500 then the result is final; break retry loop.
    # If the response is 404, it might be because of replication lag, so
    # keep trying anyway.
    if response.status < 500 and response.status != 404:
      LOGGER.debug('got response %d for %s %s', response.status,
                   conn.req_params['method'], conn.req_params['uri'])
      break
    # A status >=500 is assumed to be a possible transient error; retry.
    http_version = 'HTTP/%s' % ('1.1' if response.version == 11 else '1.0')
    LOGGER.warn('A transient error occurred while querying %s:\n'
                '%s %s %s\n'
                '%s %d %s',
                conn.req_host, conn.req_params['method'],
                conn.req_params['uri'],
                http_version, http_version, response.status, response.reason)
    if TRY_LIMIT - idx > 1:
      LOGGER.warn('... will retry %d more times.', TRY_LIMIT - idx - 1)
      time.sleep(sleep_time)
      sleep_time = sleep_time * 2
  if response.status not in accept_statuses:
    if response.status in (401, 403):
      print('Your Gerrit credentials might be misconfigured. Try: \n'
            '  git cl creds-check')
    reason = '%s: %s' % (response.reason, contents)
    raise GerritError(response.status, reason)
  return StringIO(contents)


def ReadHttpJsonResponse(conn, accept_statuses=frozenset([200])):
  """Parses an https response as json."""
  fh = ReadHttpResponse(conn, accept_statuses)
  # The first line of the response should always be: )]}'
  s = fh.readline()
  if s and s.rstrip() != ")]}'":
    raise GerritError(200, 'Unexpected json output: %s' % s)
  s = fh.read()
  if not s:
    return None
  return json.loads(s)


def QueryChanges(host, param_dict, first_param=None, limit=None, o_params=None,
                 start=None):
  """
  Queries a gerrit-on-borg server for changes matching query terms.

  Args:
    param_dict: A dictionary of search parameters, as documented here:
        http://gerrit-documentation.googlecode.com/svn/Documentation/2.6/user-search.html
    first_param: A change identifier
    limit: Maximum number of results to return.
    start: how many changes to skip (starting with the most recent)
    o_params: A list of additional output specifiers, as documented here:
        https://gerrit-review.googlesource.com/Documentation/rest-api-changes.html#list-changes
  Returns:
    A list of json-decoded query results.
  """
  # Note that no attempt is made to escape special characters; YMMV.
  if not param_dict and not first_param:
    raise RuntimeError('QueryChanges requires search parameters')
  path = 'changes/?q=%s' % _QueryString(param_dict, first_param)
  if start:
    path = '%s&start=%s' % (path, start)
  if limit:
    path = '%s&n=%d' % (path, limit)
  if o_params:
    path = '%s&%s' % (path, '&'.join(['o=%s' % p for p in o_params]))
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def GenerateAllChanges(host, param_dict, first_param=None, limit=500,
                       o_params=None, start=None):
  """
  Queries a gerrit-on-borg server for all the changes matching the query terms.

  WARNING: this is unreliable if a change matching the query is modified while
    this function is being called.

  A single query to gerrit-on-borg is limited on the number of results by the
  limit parameter on the request (see QueryChanges) and the server maximum
  limit.

  Args:
    param_dict, first_param: Refer to QueryChanges().
    limit: Maximum number of requested changes per query.
    o_params: Refer to QueryChanges().
    start: Refer to QueryChanges().

  Returns:
    A generator object to the list of returned changes.
  """
  already_returned = set()
  def at_most_once(cls):
    for cl in cls:
      if cl['_number'] not in already_returned:
        already_returned.add(cl['_number'])
        yield cl

  start = start or 0
  cur_start = start
  more_changes = True

  while more_changes:
    # This will fetch changes[start..start+limit] sorted by most recently
    # updated. Since the rank of any change in this list can be changed any time
    # (say user posting comment), subsequent calls may overalp like this:
    #   > initial order ABCDEFGH
    #   query[0..3]  => ABC
    #   > E get's updated. New order: EABCDFGH
    #   query[3..6] => CDF   # C is a dup
    #   query[6..9] => GH    # E is missed.
    page = QueryChanges(host, param_dict, first_param, limit, o_params,
                        cur_start)
    for cl in at_most_once(page):
      yield cl

    more_changes = [cl for cl in page if '_more_changes' in cl]
    if len(more_changes) > 1:
      raise GerritError(
          200,
          'Received %d changes with a _more_changes attribute set but should '
          'receive at most one.' % len(more_changes))
    if more_changes:
      cur_start += len(page)

  # If we paged through, query again the first page which in most circumstances
  # will fetch all changes that were modified while this function was run.
  if start != cur_start:
    page = QueryChanges(host, param_dict, first_param, limit, o_params, start)
    for cl in at_most_once(page):
      yield cl


def MultiQueryChanges(host, param_dict, change_list, limit=None, o_params=None,
                      start=None):
  """Initiate a query composed of multiple sets of query parameters."""
  if not change_list:
    raise RuntimeError(
        "MultiQueryChanges requires a list of change numbers/id's")
  q = ['q=%s' % '+OR+'.join([urllib.quote(str(x)) for x in change_list])]
  if param_dict:
    q.append(_QueryString(param_dict))
  if limit:
    q.append('n=%d' % limit)
  if start:
    q.append('S=%s' % start)
  if o_params:
    q.extend(['o=%s' % p for p in o_params])
  path = 'changes/?%s' % '&'.join(q)
  try:
    result = ReadHttpJsonResponse(CreateHttpConn(host, path))
  except GerritError as e:
    msg = '%s:\n%s' % (e.message, path)
    raise GerritError(e.http_status, msg)
  return result


def GetGerritFetchUrl(host):
  """Given a gerrit host name returns URL of a gerrit instance to fetch from."""
  return '%s://%s/' % (GERRIT_PROTOCOL, host)


def GetChangePageUrl(host, change_number):
  """Given a gerrit host name and change number, return change page url."""
  return '%s://%s/#/c/%d/' % (GERRIT_PROTOCOL, host, change_number)


def GetChangeUrl(host, change):
  """Given a gerrit host name and change id, return an url for the change."""
  return '%s://%s/a/changes/%s' % (GERRIT_PROTOCOL, host, change)


def GetChange(host, change):
  """Query a gerrit server for information about a single change."""
  path = 'changes/%s' % change
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def GetChangeDetail(host, change, o_params=None):
  """Query a gerrit server for extended information about a single change."""
  path = 'changes/%s/detail' % change
  if o_params:
    path += '?%s' % '&'.join(['o=%s' % p for p in o_params])
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def GetChangeCommit(host, change, revision='current'):
  """Query a gerrit server for a revision associated with a change."""
  path = 'changes/%s/revisions/%s/commit?links' % (change, revision)
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def GetChangeCurrentRevision(host, change):
  """Get information about the latest revision for a given change."""
  return QueryChanges(host, {}, change, o_params=('CURRENT_REVISION',))


def GetChangeRevisions(host, change):
  """Get information about all revisions associated with a change."""
  return QueryChanges(host, {}, change, o_params=('ALL_REVISIONS',))


def GetChangeReview(host, change, revision=None):
  """Get the current review information for a change."""
  if not revision:
    jmsg = GetChangeRevisions(host, change)
    if not jmsg:
      return None
    elif len(jmsg) > 1:
      raise GerritError(200, 'Multiple changes found for ChangeId %s.' % change)
    revision = jmsg[0]['current_revision']
  path = 'changes/%s/revisions/%s/review'
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def GetChangeComments(host, change):
  """Get the line- and file-level comments on a change."""
  path = 'changes/%s/comments' % change
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def AbandonChange(host, change, msg=''):
  """Abandon a gerrit change."""
  path = 'changes/%s/abandon' % change
  body = {'message': msg} if msg else {}
  conn = CreateHttpConn(host, path, reqtype='POST', body=body)
  return ReadHttpJsonResponse(conn)


def RestoreChange(host, change, msg=''):
  """Restore a previously abandoned change."""
  path = 'changes/%s/restore' % change
  body = {'message': msg} if msg else {}
  conn = CreateHttpConn(host, path, reqtype='POST', body=body)
  return ReadHttpJsonResponse(conn)


def SubmitChange(host, change, wait_for_merge=True):
  """Submits a gerrit change via Gerrit."""
  path = 'changes/%s/submit' % change
  body = {'wait_for_merge': wait_for_merge}
  conn = CreateHttpConn(host, path, reqtype='POST', body=body)
  return ReadHttpJsonResponse(conn)


def HasPendingChangeEdit(host, change):
  conn = CreateHttpConn(host, 'changes/%s/edit' % change)
  try:
    ReadHttpResponse(conn)
  except GerritError as e:
    # 204 No Content means no pending change.
    if e.http_status == 204:
      return False
    raise
  return True


def DeletePendingChangeEdit(host, change):
  conn = CreateHttpConn(host, 'changes/%s/edit' % change, reqtype='DELETE')
  # On success, gerrit returns status 204; if the edit was already deleted it
  # returns 404.  Anything else is an error.
  ReadHttpResponse(conn, accept_statuses=[204, 404])


def SetCommitMessage(host, change, description, notify='ALL'):
  """Updates a commit message."""
  try:
    assert notify in ('ALL', 'NONE')
    # First, edit the commit message in a draft.
    path = 'changes/%s/edit:message' % change
    body = {'message': description}
    conn = CreateHttpConn(host, path, reqtype='PUT', body=body)
    try:
      ReadHttpResponse(conn, accept_statuses=[204])
    except GerritError as e:
      raise GerritError(
          e.http_status,
          'Received unexpected http status while editing message '
          'in change %s' % change)

    # And then publish it.
    path = 'changes/%s/edit:publish' % change
    conn = CreateHttpConn(host, path, reqtype='POST', body={'notify': notify})
    try:
      ReadHttpResponse(conn, accept_statuses=[204])
    except GerritError as e:
      raise GerritError(
          e.http_status,
          'Received unexpected http status while publishing message '
          'in change %s' % change)

  except (GerritError, KeyboardInterrupt) as e:
    # Something went wrong with one of the two calls, so we want to clean up
    # after ourselves before returning.
    try:
      DeletePendingChangeEdit(host, change)
    except GerritError:
      LOGGER.error('Encountered error while cleaning up after failed attempt '
                   'to set the CL description. You may have to delete the '
                   'pending change edit yourself in the web UI.')
    raise e


def GetReviewers(host, change):
  """Get information about all reviewers attached to a change."""
  path = 'changes/%s/reviewers' % change
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def GetReview(host, change, revision):
  """Get review information about a specific revision of a change."""
  path = 'changes/%s/revisions/%s/review' % (change, revision)
  return ReadHttpJsonResponse(CreateHttpConn(host, path))


def AddReviewers(host, change, reviewers=None, ccs=None, notify=True,
                 accept_statuses=frozenset([200, 400, 422])):
  """Add reviewers to a change."""
  if not reviewers and not ccs:
    return None
  if not change:
    return None
  reviewers = frozenset(reviewers or [])
  ccs = frozenset(ccs or [])
  path = 'changes/%s/revisions/current/review' % change

  body = {
    'reviewers': [],
    'notify': 'ALL' if notify else 'NONE',
  }
  for r in sorted(reviewers | ccs):
    state = 'REVIEWER' if r in reviewers else 'CC'
    body['reviewers'].append({
     'reviewer': r,
     'state': state,
     'notify': 'NONE',  # We handled `notify` argument above.
   })

  conn = CreateHttpConn(host, path, reqtype='POST', body=body)
  # Gerrit will return 400 if one or more of the requested reviewers are
  # unprocessable. We read the response object to see which were rejected,
  # warn about them, and retry with the remainder.
  resp = ReadHttpJsonResponse(conn, accept_statuses=accept_statuses)

  errored = set()
  for result in resp.get('reviewers', {}).itervalues():
    r = result.get('input')
    state = 'REVIEWER' if r in reviewers else 'CC'
    if result.get('error'):
      errored.add(r)
      LOGGER.warn('Note: "%s" not added as a %s' % (r, state.lower()))
  if errored:
    # Try again, adding only those that didn't fail, and only accepting 200.
    AddReviewers(host, change, reviewers=(reviewers-errored),
                 ccs=(ccs-errored), notify=notify, accept_statuses=[200])


def RemoveReviewers(host, change, remove=None):
  """Remove reveiewers from a change."""
  if not remove:
    return
  if isinstance(remove, basestring):
    remove = (remove,)
  for r in remove:
    path = 'changes/%s/reviewers/%s' % (change, r)
    conn = CreateHttpConn(host, path, reqtype='DELETE')
    try:
      ReadHttpResponse(conn, accept_statuses=[204])
    except GerritError as e:
      raise GerritError(
          e.http_status,
          'Received unexpected http status while deleting reviewer "%s" '
          'from change %s' % (r, change))


def SetReview(host, change, msg=None, labels=None, notify=None):
  """Set labels and/or add a message to a code review."""
  if not msg and not labels:
    return
  path = 'changes/%s/revisions/current/review' % change
  body = {}
  if msg:
    body['message'] = msg
  if labels:
    body['labels'] = labels
  if notify:
    body['notify'] = notify
  conn = CreateHttpConn(host, path, reqtype='POST', body=body)
  response = ReadHttpJsonResponse(conn)
  if labels:
    for key, val in labels.iteritems():
      if ('labels' not in response or key not in response['labels'] or
          int(response['labels'][key] != int(val))):
        raise GerritError(200, 'Unable to set "%s" label on change %s.' % (
            key, change))


def ResetReviewLabels(host, change, label, value='0', message=None,
                      notify=None):
  """Reset the value of a given label for all reviewers on a change."""
  # This is tricky, because we want to work on the "current revision", but
  # there's always the risk that "current revision" will change in between
  # API calls.  So, we check "current revision" at the beginning and end; if
  # it has changed, raise an exception.
  jmsg = GetChangeCurrentRevision(host, change)
  if not jmsg:
    raise GerritError(
        200, 'Could not get review information for change "%s"' % change)
  value = str(value)
  revision = jmsg[0]['current_revision']
  path = 'changes/%s/revisions/%s/review' % (change, revision)
  message = message or (
      '%s label set to %s programmatically.' % (label, value))
  jmsg = GetReview(host, change, revision)
  if not jmsg:
    raise GerritError(200, 'Could not get review information for revison %s '
                   'of change %s' % (revision, change))
  for review in jmsg.get('labels', {}).get(label, {}).get('all', []):
    if str(review.get('value', value)) != value:
      body = {
          'message': message,
          'labels': {label: value},
          'on_behalf_of': review['_account_id'],
      }
      if notify:
        body['notify'] = notify
      conn = CreateHttpConn(
          host, path, reqtype='POST', body=body)
      response = ReadHttpJsonResponse(conn)
      if str(response['labels'][label]) != value:
        username = review.get('email', jmsg.get('name', ''))
        raise GerritError(200, 'Unable to set %s label for user "%s"'
                       ' on change %s.' % (label, username, change))
  jmsg = GetChangeCurrentRevision(host, change)
  if not jmsg:
    raise GerritError(
        200, 'Could not get review information for change "%s"' % change)
  elif jmsg[0]['current_revision'] != revision:
    raise GerritError(200, 'While resetting labels on change "%s", '
                   'a new patchset was uploaded.' % change)


def CreateGerritBranch(host, project, branch, commit):
  """
  Create a new branch from given project and commit
  https://gerrit-review.googlesource.com/Documentation/rest-api-projects.html#create-branch

  Returns:
    A JSON with 'ref' key
  """
  path = 'projects/%s/branches/%s' % (project, branch)
  body = {'revision': commit}
  conn = CreateHttpConn(host, path, reqtype='PUT', body=body)
  response = ReadHttpJsonResponse(conn, accept_statuses=[201])
  if response:
    return response
  raise GerritError(200, 'Unable to create gerrit branch')


def GetGerritBranch(host, project, branch):
  """
  Get a branch from given project and commit
  https://gerrit-review.googlesource.com/Documentation/rest-api-projects.html#get-branch

  Returns:
    A JSON object with 'revision' key
  """
  path = 'projects/%s/branches/%s' % (project, branch)
  conn = CreateHttpConn(host, path, reqtype='GET')
  response = ReadHttpJsonResponse(conn)
  if response:
    return response
  raise GerritError(200, 'Unable to get gerrit branch')


def GetAccountDetails(host, account_id='self'):
  """Returns details of the account.

  If account_id is not given, uses magic value 'self' which corresponds to
  whichever account user is authenticating as.

  Documentation:
    https://gerrit-review.googlesource.com/Documentation/rest-api-accounts.html#get-account
  """
  if account_id != 'self':
    account_id = int(account_id)
  conn = CreateHttpConn(host, '/accounts/%s' % account_id)
  return ReadHttpJsonResponse(conn)


@contextlib.contextmanager
def tempdir():
  tdir = None
  try:
    tdir = tempfile.mkdtemp(suffix='gerrit_util')
    yield tdir
  finally:
    if tdir:
      gclient_utils.rmtree(tdir)
