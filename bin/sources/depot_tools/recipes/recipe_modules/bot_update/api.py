# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.


"""Recipe module to ensure a checkout is consistent on a bot."""

from recipe_engine import recipe_api


class BotUpdateApi(recipe_api.RecipeApi):

  def __init__(self, issue, patch_issue, patchset, patch_set, patch_project,
               repository, patch_repository_url, gerrit_ref, patch_ref,
               patch_gerrit_url, rietveld, revision, parent_got_revision,
               deps_revision_overrides, fail_patch, *args, **kwargs):
    self._issue = issue or patch_issue
    self._patchset = patchset or patch_set
    self._repository = repository or patch_repository_url
    self._gerrit_ref = gerrit_ref or patch_ref
    self._gerrit = patch_gerrit_url
    self._rietveld = rietveld
    self._revision = revision
    self._parent_got_revision = parent_got_revision
    self._deps_revision_overrides = deps_revision_overrides
    self._fail_patch = fail_patch

    self._last_returned_properties = {}
    super(BotUpdateApi, self).__init__(*args, **kwargs)

  def __call__(self, name, cmd, **kwargs):
    """Wrapper for easy calling of bot_update."""
    assert isinstance(cmd, (list, tuple))
    bot_update_path = self.resource('bot_update.py')
    kwargs.setdefault('infra_step', True)
    env = self.m.context.env
    env.setdefault('PATH', '%(PATH)s')
    env['PATH'] = self.m.path.pathsep.join([
        env['PATH'], str(self._module.PACKAGE_REPO_ROOT)])
    # These are to prevent git from hanging.  If the git connection is slower
    # than 1KB/s for more than 5 minutes then git will kill the connection
    # and die with an error "error: RPC failed; curl 28 Operation too slow"
    env['GIT_HTTP_LOW_SPEED_LIMIT'] = 1000
    env['GIT_HTTP_LOW_SPEED_TIME'] = 300
    with self.m.context(env=env):
      return self.m.python(name, bot_update_path, cmd, **kwargs)

  @property
  def last_returned_properties(self):
      return self._last_returned_properties

  # DO NOT USE.
  # TODO(tandrii): refactor this into tryserver.maybe_apply_patch
  def apply_gerrit_ref(self, root, gerrit_no_reset=False,
                       gerrit_no_rebase_patch_ref=False, **kwargs):
    apply_gerrit_path = self.resource('apply_gerrit.py')
    kwargs.setdefault('infra_step', True)
    env = self.m.context.env
    env.setdefault('PATH', '%(PATH)s')
    env['PATH'] = self.m.path.pathsep.join([
        env['PATH'], str(self._module.PACKAGE_REPO_ROOT)])
    cmd = [
        '--gerrit_repo', self._repository,
        '--gerrit_ref', self._gerrit_ref or '',
        '--root', str(root),
    ]
    if gerrit_no_reset:
      cmd.append('--gerrit_no_reset')
    if gerrit_no_rebase_patch_ref:
      cmd.append('--gerrit_no_rebase_patch_ref')
    with self.m.context(env=env):
      return self.m.python('apply_gerrit', apply_gerrit_path, cmd, **kwargs)

  def ensure_checkout(self, gclient_config=None, suffix=None,
                      patch=True, update_presentation=True,
                      patch_root=None, no_shallow=False,
                      with_branch_heads=False, with_tags=False, refs=None,
                      patch_oauth2=False, oauth2_json=False,
                      use_site_config_creds=True, clobber=False,
                      root_solution_revision=None, rietveld=None, issue=None,
                      patchset=None, gerrit_no_reset=False,
                      gerrit_no_rebase_patch_ref=False,
                      disable_syntax_validation=False, **kwargs):
    """
    Args:
      use_site_config_creds: If the oauth2 credentials are in the buildbot
        site_config. See crbug.com/624212 for more information.
      gclient_config: The gclient configuration to use when running bot_update.
        If omitted, the current gclient configuration is used.
      rietveld: The rietveld server to use. If omitted, will infer from
        the 'rietveld' property.
      issue: The rietveld issue number to use. If omitted, will infer from
        the 'issue' property.
      patchset: The rietveld issue patchset to use. If omitted, will infer from
        the 'patchset' property.
      disable_syntax_validation: (legacy) Disables syntax validation for DEPS.
        Needed as migration paths for recipes dealing with older revisions,
        such as bisect.
    """
    refs = refs or []
    # We can re-use the gclient spec from the gclient module, since all the
    # data bot_update needs is already configured into the gclient spec.
    cfg = gclient_config or self.m.gclient.c
    assert cfg is not None, (
        'missing gclient_config or forgot api.gclient.set_config(...) before?')

    # Only one of these should exist.
    assert not (oauth2_json and patch_oauth2)

    # Construct our bot_update command.  This basically be inclusive of
    # everything required for bot_update to know:
    root = patch_root
    if root is None:
      root = self.m.gclient.calculate_patch_root(
          self.m.properties.get('patch_project'), cfg)

    if patch:
      issue = issue or self._issue
      patchset = patchset or self._patchset
      gerrit_repo = self._repository
      gerrit_ref = self._gerrit_ref
    else:
      # The trybot recipe sometimes wants to de-apply the patch. In which case
      # we pretend the issue/patchset never existed.
      issue = patchset = email_file = key_file = None
      gerrit_repo = gerrit_ref = None

    # Issue and patchset must come together.
    if issue:
      assert patchset
    if patchset:
      assert issue

    # The gerrit_ref and gerrit_repo must be together or not at all.  If one is
    # missing, clear both of them.
    if not gerrit_ref or not gerrit_repo:
      gerrit_repo = gerrit_ref = None
    assert (gerrit_ref != None) == (gerrit_repo != None)
    if gerrit_ref:
      # Gerrit patches have historically not specified issue and patchset.
      # resourece/bot_update has as a result implicit assumption that set issue
      # implies Rietveld patch.
      # TODO(tandrii): fix this madness.
      issue = patchset = None

    # Point to the oauth2 auth files if specified.
    # These paths are where the bots put their credential files.
    oauth2_json_file = email_file = key_file = None
    if oauth2_json:
      if self.m.platform.is_win:
        oauth2_json_file = 'C:\\creds\\refresh_tokens\\internal-try'
      else:
        oauth2_json_file = '/creds/refresh_tokens/internal-try'
    elif patch_oauth2:
      # TODO(martiniss): remove this hack :(. crbug.com/624212
      if use_site_config_creds:
        try:
          build_path = self.m.path['build']
        except KeyError:
          raise self.m.step.StepFailure(
              'build path is not defined. This is normal for LUCI builds. '
              'In LUCI, use_site_config_creds parameter of '
              'bot_update.ensure_checkout is not supported')
        email_file = build_path.join('site_config', '.rietveld_client_email')
        key_file = build_path.join('site_config', '.rietveld_secret_key')
      else: #pragma: no cover
        #TODO(martiniss): make this use path.join, so it works on windows
        email_file = '/creds/rietveld/client_email'
        key_file = '/creds/rietveld/secret_key'

    # Allow patch_project's revision if necessary.
    # This is important for projects which are checked out as DEPS of the
    # gclient solution.
    self.m.gclient.set_patch_project_revision(
        self.m.properties.get('patch_project'), cfg)

    reverse_rev_map = self.m.gclient.got_revision_reverse_mapping(cfg)

    flags = [
        # What do we want to check out (spec/root/rev/reverse_rev_map).
        ['--spec', self.m.gclient.config_to_pythonish(cfg)],
        ['--patch_root', root],
        ['--revision_mapping_file', self.m.json.input(reverse_rev_map)],
        ['--git-cache-dir', cfg.cache_dir],

        # How to find the patch, if any (issue/patchset).
        ['--issue', issue],
        ['--patchset', patchset],
        ['--rietveld_server', rietveld or self._rietveld],
        ['--gerrit_repo', gerrit_repo],
        ['--gerrit_ref', gerrit_ref],
        ['--apply_issue_email_file', email_file],
        ['--apply_issue_key_file', key_file],
        ['--apply_issue_oauth2_file', oauth2_json_file],

        # Hookups to JSON output back into recipes.
        ['--output_json', self.m.json.output()],]


    # Collect all fixed revisions to simulate them in the json output.
    # Fixed revision are the explicit input revisions of bot_update.py, i.e.
    # every command line parameter "--revision name@value".
    fixed_revisions = {}

    revisions = {}
    for solution in cfg.solutions:
      if solution.revision:
        revisions[solution.name] = solution.revision
      elif solution == cfg.solutions[0]:
        revisions[solution.name] = (
            self._parent_got_revision or
            self._revision or
            'HEAD')
    if self.m.gclient.c and self.m.gclient.c.revisions:
      revisions.update(self.m.gclient.c.revisions)
    if cfg.solutions and root_solution_revision:
      revisions[cfg.solutions[0].name] = root_solution_revision
    # Allow for overrides required to bisect into rolls.
    revisions.update(self._deps_revision_overrides)
    for name, revision in sorted(revisions.items()):
      fixed_revision = self.m.gclient.resolve_revision(revision)
      if fixed_revision:
        fixed_revisions[name] = fixed_revision
        flags.append(['--revision', '%s@%s' % (name, fixed_revision)])

    # Add extra fetch refspecs.
    for ref in refs:
      flags.append(['--refs', ref])

    # Filter out flags that are None.
    cmd = [item for flag_set in flags
           for item in flag_set if flag_set[1] is not None]

    if clobber:
      cmd.append('--clobber')
    if no_shallow:
      cmd.append('--no_shallow')
    if with_branch_heads or cfg.with_branch_heads:
      cmd.append('--with_branch_heads')
    if with_tags:
      cmd.append('--with_tags')
    if gerrit_no_reset:
      cmd.append('--gerrit_no_reset')
    if gerrit_no_rebase_patch_ref:
      cmd.append('--gerrit_no_rebase_patch_ref')
    if disable_syntax_validation or cfg.disable_syntax_validation:
      cmd.append('--disable-syntax-validation')

    # Inject Json output for testing.
    first_sln = cfg.solutions[0].name
    step_test_data = lambda: self.test_api.output_json(
        root, first_sln, reverse_rev_map, self._fail_patch,
        fixed_revisions=fixed_revisions)

    # Add suffixes to the step name, if specified.
    name = 'bot_update'
    if not patch:
      name += ' (without patch)'
    if suffix:
      name += ' - %s' % suffix

    # Ah hah! Now that everything is in place, lets run bot_update!
    step_result = None
    try:
      # 87 and 88 are the 'patch failure' codes for patch download and patch
      # apply, respectively. We don't actually use the error codes, and instead
      # rely on emitted json to determine cause of failure.
      step_result = self(name, cmd, step_test_data=step_test_data,
           ok_ret=(0, 87, 88), **kwargs)
    except self.m.step.StepFailure as f:
      step_result = f.result
      raise
    finally:
      if step_result:
        result = step_result.json.output
        self._last_returned_properties = step_result.json.output.get(
            'properties', {})

        if update_presentation:
          # Set properties such as got_revision.
          for prop_name, prop_value in (
              self.last_returned_properties.iteritems()):
            step_result.presentation.properties[prop_name] = prop_value
        # Add helpful step description in the step UI.
        if 'step_text' in result:
          step_text = result['step_text']
          step_result.presentation.step_text = step_text

        # Set the "checkout" path for the main solution.
        # This is used by the Chromium module to figure out where to look for
        # the checkout.
        # If there is a patch failure, emit another step that said things
        # failed.
        if result.get('patch_failure'):
          return_code = result.get('patch_apply_return_code')
          patch_body = result.get('failed_patch_body')
          try:
            if return_code == 3:
              # This is download failure, hence an infra failure.
              with self.m.context(infra_steps=True):
                self.m.python.failing_step(
                    'Patch failure', 'Git reported a download failure')
            else:
              # This is actual patch failure.
              self.m.tryserver.set_patch_failure_tryjob_result()
              self.m.python.failing_step(
                  'Patch failure', 'See attached log. Try rebasing?')
          except self.m.step.StepFailure as e:
            if patch_body:
              e.result.presentation.logs['patch error'] = (
                  patch_body.splitlines())
            raise e

        # bot_update actually just sets root to be the folder name of the
        # first solution.
        if result['did_run']:
          co_root = result['root']
          cwd = self.m.context.cwd or self.m.path['start_dir']
          if 'checkout' not in self.m.path:
            self.m.path['checkout'] = cwd.join(*co_root.split(self.m.path.sep))

    return step_result

  def _resolve_fixed_revisions(self, bot_update_json):
    """Set all fixed revisions from the first sync to their respective
    got_X_revision values.

    If on the first sync, a revision was requested to be HEAD, this avoids
    using HEAD potentially resolving to a different revision on the second
    sync. Instead, we sync explicitly to whatever was checked out the first
    time.

    Example (chromium trybot used with v8 patch):

    First sync was called with
    bot_update.py --revision src@abc --revision src/v8@HEAD
    Fixed revisions are: src, src/v8
    Got_revision_mapping: src->got_revision, src/v8->got_v8_revision
    got_revision = abc, got_v8_revision = deadbeef
    Second sync will be called with
    bot_update.py --revision src@abc --revision src/v8@deadbeef

    Example (chromium trybot used with chromium DEPS change, changing v8 from
    "v8_before" to "v8_after"):

    First sync was called with
    bot_update.py --revision src@abc
    Fixed revisions are: src
    Got_revision_mapping: src->got_revision, src/v8->got_v8_revision
    got_revision = abc, got_v8_revision = v8_after
    Second sync will be called with
    bot_update.py --revision src@abc
    When deapplying the patch, v8 will be synced to v8_before.
    """
    for name in bot_update_json.get('fixed_revisions', {}):
      rev_properties = self.get_project_revision_properties(name)
      if (rev_properties and
          bot_update_json['properties'].get(rev_properties[0])):
        self.m.gclient.c.revisions[name] = str(
            bot_update_json['properties'][rev_properties[0]])

  # TODO(machenbach): Replace usages of this method eventually by direct calls
  # to the manifest output.
  def get_project_revision_properties(self, project_name, gclient_config=None):
    """Returns all property names used for storing the checked-out revision of
    a given project.

    Args:
      project_name (str): The name of a checked-out project as deps path, e.g.
          src or src/v8.
      gclient_config: The gclient configuration to use. If omitted, the current
          gclient configuration is used.

    Returns (list of str): All properties that'll hold the checked-out revision
        of the given project. An empty list if no such properties exist.
    """
    cfg = gclient_config or self.m.gclient.c
    # Sort for determinism. We might have several properties for the same
    # project, e.g. got_revision and got_webrtc_revision.
    rev_reverse_map = self.m.gclient.got_revision_reverse_mapping(cfg)
    return sorted(
        prop
        for prop, project in rev_reverse_map.iteritems()
        if project == project_name
    )

  def deapply_patch(self, bot_update_step):
    """Deapplies a patch, taking care of DEPS and solution revisions properly.
    """
    bot_update_json = bot_update_step.json.output
    # We only override first solution here to make sure that we correctly revert
    # changes to DEPS file, which is particularly important for auto-rolls. It
    # is also imporant that we do not assume that corresponding revision is
    # stored in the 'got_revision' as some gclient configs change the default
    # mapping for their own purposes.
    first_solution_name = self.m.gclient.c.solutions[0].name
    rev_property = self.get_project_revision_properties(first_solution_name)[0]
    self.m.gclient.c.revisions[first_solution_name] = str(
        bot_update_json['properties'][rev_property])
    self._resolve_fixed_revisions(bot_update_json)

    self.ensure_checkout(patch=False, update_presentation=False)
