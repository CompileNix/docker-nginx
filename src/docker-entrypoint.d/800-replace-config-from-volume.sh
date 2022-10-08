#!/bin/sh
# vim: sw=2 et

set -eu

ME=$(basename $0)

if [ ! -d "/config" ]; then
  exit 0
fi

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
  VERBOSE_FLAG="-v"
else
  VERBOSE_FLAG=""
fi

echo >&3 "$ME: Copy and override nginx config files from mapped volume (/config/) to /etc/nginx/ ..."
cp $VERBOSE_FLAG -raf /config/* /etc/nginx

