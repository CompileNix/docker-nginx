#!/bin/bash
# vim: sw=2 et

# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# e: Exit immediately if a pipeline (see Pipelines), which may consist of a
#    single simple command (see Simple Commands), a list (see Lists of
#    Commands), or a compound command (see Compound Commands) returns a
#    non-zero status.
# u: Treat unset variables and parameters other than the special parameters
#    ‘@’ or ‘*’, or array variables subscripted with ‘@’ or ‘*’, as an error
#    when performing parameter expansion. An error message will be written to
#    the standard error, and a non-interactive shell will exit.
set -eu

if [ ! -f "tmpl.env" ]; then
  cp -v "example.tmpl.env" "tmpl.env"
fi

mkdir -p "log"

while read -r line; do
  read -r nginx_version nginx_commit <<< $line
  echo "building: $line"
  cp "tmpl.env" ".env"
  sed -i "s/{{ NGINX_VERSION }}/$nginx_version/g" ".env"
  sed -i "s/{{ NGINX_COMMIT }}/$nginx_commit/g" ".env"
  build_date_start_timestamp=$(LC_TIME="en_US.UTF-8" TZ="UTC" date +"%Y-%m-%d.%H%M")
  build_logfile="${nginx_version}-${nginx_commit}-${build_date_start_timestamp}.log"
  ./build.sh 2>&1 | tee "log/$build_logfile"
  echo
  echo "Upload build log command" >>"log/build_logfile_names.log"
  echo "rsync \"log/$build_logfile\" wire:/var/www/compilenix.org/static/build-logs/nginx/$build_logfile" >>"log/build_logfile_names.log"
  echo "https://compilenix.org/static/build-logs/nginx/$build_logfile" >>"log/build_logfile_names.log"
  echo "" >>"log/build_logfile_names.log"
done <nginx-build-versions.txt

cat "log/build_logfile_names.log"
rm "log/build_logfile_names.log"

