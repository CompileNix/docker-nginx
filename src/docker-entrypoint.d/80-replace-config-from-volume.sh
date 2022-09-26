#!/bin/sh
# vim: sw=2 et

set -eu

ME=$(basename $0)

if [ ! -d "/config" ]; then
  exit 0
fi

echo >&3 "$ME: Copy and override nginx config files from mapped volume (/config/) to /etc/nginx/ ..."
cp -ravf /config/* /etc/nginx

