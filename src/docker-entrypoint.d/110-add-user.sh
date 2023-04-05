#!/bin/sh
# vim: sw=2 et

# Detect and configure custom nginx USER_ID and GROUP_ID.

set -e

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

if [ -f "/var/run/nginx/user-add-done" ]; then
  USER_EXISTS="true"
else
  USER_EXISTS="false"
fi

if [[ "$USER_ID" != "" ]] && [[ "$USER_ID" != "101" ]]; then
  echo "Change nginx user id from 101 to $USER_ID" 2>&1 | prepend
else
  USER_ID="101"
fi

if [[ "$GROUP_ID" != "" ]] && [[ "$GROUP_ID" != "101" ]]; then
  echo "Change nginx group id from 101 to $USER_ID" 2>&1 | prepend
else
  GROUP_ID="101"
fi

if [[ "$USER_EXISTS" = "false" ]]; then
  echo "Create nginx user and group" 2>&1 | prepend
  echo "nginx:x:$USER_ID:$GROUP_ID:nginx user,,,:/nonexistent:/bin/false" >>/etc/passwd
  echo "nginx:x:$GROUP_ID:" >>/etc/group
else
  echo "Nginx user and group already exist" 2>&1 | prepend
fi
echo >"/var/run/nginx/user-add-done"

# set required permissions
chown "$VERBOSE_FLAG" nginx:nginx \
  /var/cache/nginx \
  /var/log/nginx \
  /var/run/nginx \
  2>&1 | prepend

unset USER_ID
unset GROUP_ID

