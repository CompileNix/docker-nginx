#!/bin/sh
# vim: sw=2 et

set -eu

ME=$(basename $0)
if [ -t 1 ]; then
  # STDOUT is attached to TTY
  terminal_bold_green="\033[0;32m"
  terminal_reset="\033[0m"
else
  terminal_bold_green=""
  terminal_reset=""
fi
if [ -z "${ENTRYPOINT_QUIET:-}" ]; then
  VERBOSE_FLAG="-v"
  function prepend() { while read line; do echo -e "${terminal_bold_green}${ME}:${terminal_reset} ${line}"; done; }
else
  VERBOSE_FLAG=""
  function prepend() { echo -n; }
fi

if [ ! -d "/config" ]; then
  echo "Nothing found on /config/, we are done here" 2>&1 | prepend
  exit 0
fi

echo "Copy and override nginx config files from mapped volume (/config/) to /etc/nginx/ ..." 2>&1 | prepend
cp $VERBOSE_FLAG -rf /config/* /etc/nginx 2>&1 | prepend

