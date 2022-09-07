#!/bin/sh
# vim: sw=2 et

set -e

ME=$(basename $0)

auto_envsubst() {
  local templates="/etc/nginx/nginx.conf /etc/nginx/sites/ /etc/nginx/cfg/ /etc/nginx/include-nginx.conf/ /etc/nginx/include-http/ /etc/nginx/include-stream/ ${NGINX_ENVSUBST_TEMPLATES:-}"
  local suffix=".conf"

  local template template_location defined_envs relative_path output_path subdir dir_name
  defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
  echo >&3 "$ME: Copy nginx config files to temp dir..."
  for template_location in $templates; do
    if [ -d "$template_location" ] && [ ! -z "$(ls -A $template_location)" ]; then
      mkdir -pv "/tmp/nginx-envsubst/conf/${template_location#/etc/nginx/}"
      cp -rv $template_location/* "/tmp/nginx-envsubst/conf/${template_location#/etc/nginx/}/"
    fi
    if [ -f "$template_location" ]; then
      dir_name="$(dirname $template_location)"
      mkdir -pv "/tmp/nginx-envsubst/conf${dir_name#/etc/nginx}/"
      cp -v "$template_location" "/tmp/nginx-envsubst/conf${dir_name#/etc/nginx}/"
    fi
  done

  for template_file in $(find "/tmp/nginx-envsubst/conf/" -follow -type f -name "*$suffix" -print); do
    echo $template_file | while read -r template; do
      echo >&3 "$ME: Running envsubst for /etc/nginx/${template_file#/tmp/nginx-envsubst/conf/}"
      envsubst "$defined_envs" <"$template" >"/etc/nginx/${template_file#/tmp/nginx-envsubst/conf/}"
    done
  done

  echo >&3 "$ME: Cleanup nginx config files in temp dir..."
  rm -rf "/tmp/nginx-envsubst"
}

auto_envsubst

