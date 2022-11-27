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
# pipefail: If set, the return value of a pipeline is the value of the last
#           (rightmost) command to exit with a non-zero status, or zero if
#           all commands in the pipeline exit successfully. This option is
#           disabled by default.
set -eu pipefail

while read -r line; do
  read -r image tag <<< $line
  echo "docker image push ${image}:${tag}"
  docker image push "${image}:${tag}"
done <<< $(docker image ls compilenix/nginx | grep -vE '<none>|IMAGE ID' | awk '{ print $1,$2 }' | sort --version-sort)

echo "images were published to: https://hub.docker.com/r/compilenix/nginx/tags"

