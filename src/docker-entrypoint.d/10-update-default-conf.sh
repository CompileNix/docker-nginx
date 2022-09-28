#!/bin/sh
# vim: sw=2 et

set -e

ME=$(basename $0)

# Remove default site nginx config if the required enviroment variables are not set.

if [[ -z "$NGINX_HOST" ]]; then
  echo >&3 "$ME: Env variable NGINX_HOST is undefined, removing \"sites/default.conf\""
  rm -v /etc/nginx/sites/default.conf
elif [[ "$NGINX_HOST" = "localhost" ]]; then
  echo >&3 "$ME: Env variable NGINX_HOST is set to \"localhost\", removing existing \"sites/localhost.conf\""
  rm -v /etc/nginx/sites/localhost.conf
elif [[ -z "$NGINX_HOST_CERT_PATH" ]]; then
  echo >&3 "$ME: Env variable NGINX_HOST_CERT_PATH is undefined, removing \"sites/default.conf\""
  rm -v /etc/nginx/sites/default.conf
elif [[ -z "$NGINX_HTTP_REDIRECT_LOCATION" ]]; then
  echo >&3 "$ME: Env variable NGINX_HTTP_REDIRECT_LOCATION is undefined, removing \"sites/default.conf\""
  rm -v /etc/nginx/sites/default.conf
fi

