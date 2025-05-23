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
# a: Variables defined from now will be exported automatically.
#: If set, the return value of a pipeline is the value of the last
#           (rightmost) command to exit with a non-zero status, or zero if
#           all commands in the pipeline exit successfully. This option is
#           disabled by default.
set -eu

if [ ! -f ".env" ]; then
  cp -v ".env.example" ".env"
fi

mkdir -p "log"

set -a
source ".env"
set +a

variant=${2:-default}
build_date_start_timestamp=$(LC_TIME="en_US.UTF-8" TZ="UTC" date +"%Y-%m-%d.%H%M")
build_logfile="${build_date_start_timestamp}-${NGINX_VERSION}-${NGINX_COMMIT}-${variant}.log"

./tools/build.sh $* 2>&1 | tee "log/$build_logfile"

echo
echo "# https://compilenix.org/static/build-logs/nginx/$build_logfile" > "log/upload-${variant}.sh"
echo -e "rsync \"log/$build_logfile\" wire:/var/www/compilenix.org/static/build-logs/nginx\n" >> "log/upload-${variant}.sh"
echo "$build_logfile" >"log/log-file-name-$variant.txt"
chmod +x "log/upload-${variant}.sh"
