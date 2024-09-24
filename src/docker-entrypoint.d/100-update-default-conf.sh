#!/bin/sh
# vim: sw=2 et

# Remove default site nginx config if the required enviroment variables are not set.

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

if [ ! -f "/etc/nginx/sites/default.conf" ]; then
  echo "\"sites/default.conf\" not present, we are done here." 2>&1 | prepend
  exit 0
fi

if [[ -z "$NGINX_HOST" ]]; then
  echo "Env variable NGINX_HOST is undefined, removing \"sites/default.conf\"" 2>&1 | prepend
  rm $VERBOSE_FLAG /etc/nginx/sites/default.conf 2>&1 | prepend
elif [[ "$NGINX_HOST" = "localhost" ]]; then
  echo "Env variable NGINX_HOST is set to \"localhost\", removing existing \"sites/localhost.conf\"" 2>&1 | prepend
  rm $VERBOSE_FLAG /etc/nginx/sites/localhost.conf 2>&1 | prepend
elif [[ -z "$NGINX_HOST_CERT_PATH" ]]; then
  echo "Env variable NGINX_HOST_CERT_PATH is undefined, removing \"sites/default.conf\"" 2>&1 | prepend
  rm $VERBOSE_FLAG /etc/nginx/sites/default.conf 2>&1 | prepend
elif [[ -z "$NGINX_HTTP_REDIRECT_LOCATION" ]]; then
  echo "Env variable NGINX_HTTP_REDIRECT_LOCATION is undefined, removing \"sites/default.conf\"" 2>&1 | prepend
  rm $VERBOSE_FLAG /etc/nginx/sites/default.conf 2>&1 | prepend
fi

