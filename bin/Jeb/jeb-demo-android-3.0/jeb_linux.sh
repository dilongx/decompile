#!/bin/bash

# Start-up script for JEB (Linux)

# disable GTK 3 which introduce some graphical bugs
export SWT_GTK3=0

# Prefer local JRE
JAVA=bin/runtime/bin/java
if [ ! -f "$JAVA" ]; then

  # Prefer a JDK over a JRE
  if [ -z "$JAVA_HOME" ]; then
    JAVA=`which java`
  else
    JAVA=$JAVA_HOME/bin/java
  fi

  # Note: If the Java path generation does not yield a correct result, manually set
  # the JAVA variable (defined above) to a correct value
  if [ ! -f "$JAVA" ]; then
    echo "JEB requires a Java runtime environment, please install one."
    exit -1
  fi
fi

THISPATH=`realpath "$0"`
cd "`dirname "$THISPATH"`"
BASEDIR=`pwd`
cd - >/dev/null

JVMOPT=$(<"$BASEDIR/jvmopt.txt")
# Manual override for JVM options: uncomment the following line and adjust if necessary
# JVMOPT="-Xss4M -Xmx8G"

INSTALLER=$BASEDIR/bin/app/jebi.jar
"$JAVA" -jar "$INSTALLER" --di --up --timeout=0 -- "$@"
RETCODE=$?
if [ $RETCODE -lt 0 ]; then
  exit $RETCODE
fi

if [ "$1" == "-c" ]; then
  "$JAVA" $JVMOPT -jar "$BASEDIR/bin/app/jeb.jar" "$@"
  exit 0
fi

JEB=$BASEDIR/bin/jeb
if [ -f "$JEB" ]; then
  chmod +x "$JEB"
  # disabling: launcher is not working as expected on Ubuntu
  # reverting to standard Jar launch
  # echo "Starting JEB Desktop Client..."
  # "$JEB" "$@" </dev/null &>/dev/null
  #exit 0
fi
"$JAVA" $JVMOPT -jar "$BASEDIR/bin/app/jebc.jar" "$@"
exit 0
