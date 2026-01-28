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

source .env

# Filter out images with <none> tag
docker image ls "$IMAGE_NAME" --format json | \
  jq -r 'select(.Tag != "<none>" and .ID != null) |
      "\(.Repository):\(.Tag)"' | \
  sort --version-sort | \
  while read -r line; do
    echo "docker image push ${line}"
    docker image push "${line}"
done

echo "images were published to: https://hub.docker.com/r/$IMAGE_NAME/tags"
