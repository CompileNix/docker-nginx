#!/bin/sh
# vim: sw=2 et

set -eu

ME=$(basename $0)
if [ -t 1 ]; then
  # STDOUT is attached to TTY
  terminal_green="\033[0;32m"
  terminal_reset="\033[0m"
else
  terminal_green=""
  terminal_reset=""
fi
if [ -z "${ENTRYPOINT_QUIET:-}" ]; then
  VERBOSE_FLAG="-v"
  function prepend() { while read line; do echo -e "${terminal_green}${ME}:${terminal_reset} ${line}"; done; }
else
  VERBOSE_FLAG=""
  function prepend() { echo -n; }
fi

if [[ "$NGINX_LOG_INFO_ON_START" != "" ]] && [[ "$NGINX_LOG_INFO_ON_START" = "version" ]]; then
  nginx -v 2>&1 | prepend
fi

if [[ "$NGINX_LOG_INFO_ON_START" != "" ]] && [[ "$NGINX_LOG_INFO_ON_START" = "buildinfo" ]]; then
  nginx -V 2>&1 | prepend
fi

