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

echo "Update nginx config permissions" 2>&1 | prepend

chown -R nginx:nginx /etc/nginx 2>&1 | prepend
chmod -R g+r /etc/nginx 2>&1 | prepend
chmod -R u+r /etc/nginx 2>&1 | prepend
chmod -R o-rwx /etc/nginx 2>&1 | prepend
chmod -R g-w /etc/nginx 2>&1 | prepend
chmod -R u-w /etc/nginx 2>&1 | prepend

