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

env | sort | prepend

if [[ "$1" = "/usr/bin/nginx" ]] || [[ "$1" = "nginx" ]]; then
  if find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
    echo "/docker-entrypoint.d/ is not empty, will attempt to perform configuration" 2>&1 | prepend

    echo "Looking for shell scripts in /docker-entrypoint.d/" 2>&1 | prepend
    find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r entrypoint_script; do
      case "$entrypoint_script" in
        *.sh)
          if [ -x "$entrypoint_script" ]; then
            echo "Launching $entrypoint_script" 2>&1 | prepend
            "$entrypoint_script"
          else
            # warn on shell scripts without exec bit
            echo "Error: can't run non-executable script: $entrypoint_script" 2>&1 | prepend
            exit 1
          fi
          ;;
        *)
          echo "Ignoring $entrypoint_script" 2>&1 | prepend
          ;;
      esac
    done

    echo "Configuration complete; ready for start up" 2>&1 | prepend
  else
    echo "No files found in /docker-entrypoint.d/, skipping configuration" 2>&1 | prepend
  fi
else
  echo "Start command override detected, skipping execution of /docker-entrypoint.d/*.sh" 2>&1 | prepend
fi

echo "exec: $@" 2>&1 | prepend
echo
exec "$@"

