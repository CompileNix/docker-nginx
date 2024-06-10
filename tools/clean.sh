#!/bin/bash
# vim: sw=2 et

# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# u: Treat unset variables and parameters other than the special parameters
#    ‘@’ or ‘*’, or array variables subscripted with ‘@’ or ‘*’, as an error
#    when performing parameter expansion. An error message will be written to
#    the standard error, and a non-interactive shell will exit.
set -u

rm -rv log
exit 0

