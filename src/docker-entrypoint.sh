#!/bin/sh
# vim: sw=2 et

set -eu

ME=$(basename $0)

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

if [[ "$1" = "/usr/bin/nginx" ]]; then
  if find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
    echo >&3 "$ME: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

    echo >&3 "$ME: Looking for shell scripts in /docker-entrypoint.d/"
    find "/docker-entrypoint.d/" -follow -type f -print | sort -n | while read -r f; do
      case "$f" in
        *.sh)
          if [ -x "$f" ]; then
            echo >&3 "$ME: Launching $f";
            "$f"
          else
            # warn on shell scripts without exec bit
            echo >&3 "$ME: Ignoring $f, not executable";
          fi
          ;;
        *) echo >&3 "$ME: Ignoring $f";;
      esac
    done

    echo >&3 "$ME: Configuration complete; ready for start up"
  else
    echo >&3 "$ME: No files found in /docker-entrypoint.d/, skipping configuration"
  fi
fi

exec "$@"

