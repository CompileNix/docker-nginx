#!/bin/sh
# vim: sw=2 et

# Remove default sites if the user supplied one or more site configs via /config/sites/*.conf

set -e

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

count=0
if [ -d "/config/sites" ]; then
  files=$(find /config/sites -type f -name "*.conf" -exec echo -n "{} " \;)
  for file in $files; do
    count=$(( $count + 1 ))
  done
  unset files
fi

if [ $count -gt 0 ]; then
  echo "There are ${count} .conf files in /config/sites, we are going to remove any default conf files from the container." 2>&1 | prepend
  rm $VERBOSE_FLAG /etc/nginx/sites/*.conf 2>&1 | prepend
else
  echo "No user supplied nginx site .conf files found, we are keeping the default ones" 2>&1 | prepend
fi

