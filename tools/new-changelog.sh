#!/bin/bash
# vim: sw=2 et
set -eu

source .env

changelog_date="$(LC_TIME="en_US.UTF-8" TZ="GMT" date "+%a, %d %b %Y %T %Z")"

log_file_name_slim="$(cat "log/log-file-name-slim.txt")"
log_file_name_default="$(cat "log/log-file-name-default.txt")"
log_file_name_extras="$(cat "log/log-file-name-extras.txt")"

echo "receive version info: slim..."
version_info_slim="$(docker run --rm --env-file .env -e ENTRYPOINT_QUIET=y -v "$(pwd)/webroot:/var/www/html:ro,z" "$IMAGE_NAME:$NGINX_VERSION-slim" /usr/bin/nginx -V 2>&1)"

echo "receive version info: default..."
version_info_default="$(docker run --rm --env-file .env -e ENTRYPOINT_QUIET=y -v "$(pwd)/webroot:/var/www/html:ro,z" "$IMAGE_NAME:$NGINX_VERSION" /usr/bin/nginx -V 2>&1)"

echo "receive version info: extras..."
version_info_extras="$(docker run --rm --env-file .env -e ENTRYPOINT_QUIET=y -v "$(pwd)/webroot:/var/www/html:ro,z" "$IMAGE_NAME:$NGINX_VERSION-extras" /usr/bin/nginx -V 2>&1)"

echo
cat << EOF
## $NGINX_VERSION: $changelog_date

Build logs:
- image tag \`$NGINX_VERSION\`: [$log_file_name_default](https://compilenix.org/static/build-logs/nginx/$log_file_name_default)
- image tag \`$NGINX_VERSION-extras\`: [$log_file_name_extras](https://compilenix.org/static/build-logs/nginx/$log_file_name_extras)
- image tag \`$NGINX_VERSION-slim\`: [$log_file_name_slim](https://compilenix.org/static/build-logs/nginx/$log_file_name_slim)

### Changes

- Update nginx njs from 0.8.10 to 0.9.0
- Update QuickJS from [330625486f1d67b35c3720e9fc4bcc794302fd5b to a8b2d7c2b2751130000b74ac7d831fd75a0abbc3](https://github.com/bellard/quickjs/compare/330625486f1d67b35c3720e9fc4bcc794302fd5b...a8b2d7c2b2751130000b74ac7d831fd75a0abbc3)

#### Changes from nginx

\`\`\`
Changes with nginx 1.28.0                                        23 Apr 2025

    *) 1.28.x stable branch.

    *) Bugfix: nginx could not be built by gcc 15 if ngx_http_v2_module or
       ngx_http_v3_module modules were used.

    *) Bugfix: nginx might not be built by gcc 14 or newer with -O3 -flto
       optimization if ngx_http_v3_module was used.
\`\`\`

### Nginx Build Info
#### Default Image Variant

\`\`\`
$version_info_default
\`\`\`

#### Extras Image Variant

\`\`\`
$version_info_extras
\`\`\`

#### Slim Image Variant

\`\`\`
$version_info_slim
\`\`\`

EOF
