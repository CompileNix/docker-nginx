#!/bin/sh
# vim: sw=2 et

set -eu

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

