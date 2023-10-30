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
#: If set, the return value of a pipeline is the value of the last
#           (rightmost) command to exit with a non-zero status, or zero if
#           all commands in the pipeline exit successfully. This option is
#           disabled by default.
set -eu

if [ ! -f ".env" ]; then
  cp -v "example.env" ".env"
fi

mkdir -p "log"
source ".env"

build_date_start_timestamp=$(LC_TIME="en_US.UTF-8" TZ="UTC" date +"%Y-%m-%d.%H%M")
build_logfile="${NGINX_VERSION}-${NGINX_COMMIT}-${build_date_start_timestamp}.log"

./build.sh 2>&1 | tee "log/$build_logfile"

echo
echo "Upload build log command"
echo "rsync \"log/$build_logfile\" wire:/var/www/compilenix.org/static/build-logs/nginx/"
echo "https://compilenix.org/static/build-logs/nginx/$build_logfile"

