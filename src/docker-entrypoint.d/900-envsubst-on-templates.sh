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

if [ ! -z "${NGINX_ENVSUBST_DISABLE:-}" ]; then
  echo "NGINX_ENVSUBST_DISABLE is set, skipping envsubst on templates" 2>&1 | prepend
  exit 0
fi

# on first start: copy nginx default configs to /var/lib/nginx/default_config
# on subsequent starts: remove generated configs from /etc/nginx and restore nginx default configs
if [ ! -f "/var/run/nginx/envsubst-on-templates-done" ]; then
  echo "Copy default nginx configs to /var/lib/nginx/default_config" 2>&1 | prepend
  mkdir $VERBOSE_FLAG -p /var/lib/nginx/default_config 2>&1 | prepend
  cp $VERBOSE_FLAG -r /etc/nginx/* /var/lib/nginx/default_config/ 2>&1 | prepend
else
  echo "Copy default nginx configs from /var/lib/nginx/default_config to /etc/nginx/" 2>&1 | prepend
  rm $VERBOSE_FLAG -r /etc/nginx 2>&1 | prepend
  mkdir $VERBOSE_FLAG -p /etc/nginx 2>&1 | prepend
  cp $VERBOSE_FLAG -r /var/lib/nginx/default_config/* /etc/nginx/ 2>&1 | prepend
fi

if [ -d "/config" ]; then
  echo "Copy nginx configs from mounted volume at /config to /etc/nginx/" 2>&1 | prepend
  cp $VERBOSE_FLAG -r /config/* /etc/nginx/ 2>&1 | prepend
fi

templates="/etc/nginx ${NGINX_ENVSUBST_TEMPLATES:-}"
suffix="$NGINX_ENVSUBST_TEMPLATE_SUFFIX"

defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
echo "Copy nginx config files to temp dir..." 2>&1 | prepend
for template_location in $templates; do
  if [ -d "$template_location" ] && [ ! -z "$(ls -A $template_location)" ]; then
    mkdir $VERBOSE_FLAG -p "/tmp/nginx-envsubst/${template_location#/etc/nginx}" 2>&1 | prepend
    cp $VERBOSE_FLAG -r $template_location/* "/tmp/nginx-envsubst/${template_location#/etc/nginx}" 2>&1 | prepend
  fi
  if [ -f "$template_location" ]; then
    dir_name="$(dirname $template_location)"
    mkdir $VERBOSE_FLAG -p "/tmp/nginx-envsubst${dir_name#/etc/nginx}/" 2>&1 | prepend
    cp $VERBOSE_FLAG "$template_location" "/tmp/nginx-envsubst${dir_name#/etc/nginx}/" 2>&1 | prepend
  fi
done

for template_file in $(find "/tmp/nginx-envsubst/" -follow -type f -name "*$suffix" -print); do
  echo $template_file | while read -r template; do
    echo "Running envsubst for /etc/nginx/${template_file#/tmp/nginx-envsubst/}" 2>&1 | prepend
    envsubst "$defined_envs" <"$template" >"/etc/nginx/${template_file#/tmp/nginx-envsubst/}" 2>&1 | prepend
    # cat "/etc/nginx/${template_file#/tmp/nginx-envsubst/}"
  done
done

echo "Cleanup nginx config files in temp dir..." 2>&1 | prepend
rm $VERBOSE_FLAG -rf "/tmp/nginx-envsubst" 2>&1 | prepend

echo >"/var/run/nginx/envsubst-on-templates-done"

