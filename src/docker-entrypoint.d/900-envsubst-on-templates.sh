#!/bin/sh
# vim: sw=2 et

set -eu

ME=$(basename $0)

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
  VERBOSE_FLAG="-v"
else
  VERBOSE_FLAG=""
fi

templates="/etc/nginx ${NGINX_ENVSUBST_TEMPLATES:-}"
suffix="$NGINX_ENVSUBST_TEMPLATE_SUFFIX"

defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
echo >&3 "$ME: Copy nginx config files to temp dir..."
for template_location in $templates; do
  if [ -d "$template_location" ] && [ ! -z "$(ls -A $template_location)" ]; then
    mkdir $VERBOSE_FLAG -p "/tmp/nginx-envsubst/${template_location#/etc/nginx}"
    cp $VERBOSE_FLAG -r $template_location/* "/tmp/nginx-envsubst/${template_location#/etc/nginx}"
  fi
  if [ -f "$template_location" ]; then
    dir_name="$(dirname $template_location)"
    mkdir $VERBOSE_FLAG -p "/tmp/nginx-envsubst${dir_name#/etc/nginx}/"
    cp $VERBOSE_FLAG "$template_location" "/tmp/nginx-envsubst${dir_name#/etc/nginx}/"
  fi
done

for template_file in $(find "/tmp/nginx-envsubst/" -follow -type f -name "*$suffix" -print); do
  echo $template_file | while read -r template; do
    echo >&3 "$ME: Running envsubst for /etc/nginx/${template_file#/tmp/nginx-envsubst/}"
    envsubst "$defined_envs" <"$template" >"/etc/nginx/${template_file#/tmp/nginx-envsubst/}"
  done
done

echo >&3 "$ME: Cleanup nginx config files in temp dir..."
rm $VERBOSE_FLAG -rf "/tmp/nginx-envsubst"

