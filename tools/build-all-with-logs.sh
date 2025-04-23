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

build_date_start_timestamp=$(date +%s)
build_date_start_pretty=$(LC_TIME="en_US.UTF-8" TZ="GMT" date "+%a, %d %b %Y %T %Z")

./tools/build-with-logs.sh ./docker/latest-slim.Dockerfile slim
./tools/build-with-logs.sh ./docker/latest.Dockerfile
./tools/build-with-logs.sh ./docker/latest-extras.Dockerfile extras

build_date_end_timestamp=$(date +%s)

echo "build started at: $build_date_start_pretty"
echo "build all 3 images took $(expr $build_date_end_timestamp - $build_date_start_timestamp) seconds"

echo
echo "Upload log file with:"
cat log/upload-*.sh
