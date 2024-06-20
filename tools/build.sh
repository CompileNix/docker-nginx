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
# v: Print shell input lines as they are read.
# a: Variables defined from now will be exported automatically.
#: If set, the return value of a pipeline is the value of the last
#           (rightmost) command to exit with a non-zero status, or zero if
#           all commands in the pipeline exit successfully. This option is
#           disabled by default.
set -euv

build_date_start_timestamp=$(date +%s)
build_date_start_pretty=$(LC_TIME="en_US.UTF-8" TZ="GMT" date "+%a, %d %b %Y %T %Z")
build_date_start=$(LC_TIME="en_US.UTF-8" TZ="UTC" date +"%Y-%m-%d.%H%M")

set -a
source ".env"
set +a

mkdir -pv "config"
if [ ! -f "config/ssl/dhparam.pem" ]; then
  openssl dhparam -out "config/ssl/dhparam.pem" 4096
fi
mkdir -pv "config/ssl"
if [ ! -f "config/ssl/privkey.pem" ]; then
  openssl genrsa -out "config/ssl/privkey.pem" 4096
fi
if [ -f "config/ssl/cert_temp.pem" ]; then
  rm -v "config/ssl/cert_temp.pem"
fi
if [ ! -f "config/ssl/cert.pem" ]; then
  openssl req -key "config/ssl/privkey.pem" -config <(cat "/etc/ssl/openssl.cnf" <(printf "[SAN]\nbasicConstraints=CA:FALSE\nkeyUsage=nonRepudiation,digitalSignature,keyEncipherment\nsubjectAltName=DNS:localhost, DNS:localhost.localdomain, IP:127.0.0.1, IP:::1")) -sha256 -subj "/C=/ST=/L=/O=/OU=/CN=localhost" -extensions SAN -nodes -x509 -days 3650 -out "config/ssl/cert_temp.pem"
  openssl x509 -in "config/ssl/cert_temp.pem" -text >"config/ssl/cert.pem"
  rm -v "config/ssl/cert_temp.pem"
  openssl x509 -noout -text -in "config/ssl/cert.pem"
fi
if [ ! -f "config/ssl/fullchain.pem" ]; then
  cp -v "config/ssl/cert.pem" "config/ssl/fullchain.pem"
fi

DOCKERFILE="$1"
if [[ "$DOCKERFILE" = "" ]]; then
  echo "Arg 1 is missing: Dockerfile path"
  exit 1
fi

ARG_2="${2:-}"
if [[ "$ARG_2" = "" ]]; then
  IMAGE_TAG="$NGINX_VERSION"
else
  IMAGE_TAG="$NGINX_VERSION-$ARG_2"
fi

DOCKER_BUILDKIT=0 docker build \
  $BUILD_CACHE \
  --file "$DOCKERFILE" \
  --build-arg BUILD_THROTTLE \
  --build-arg HEADERS_MORE_VERSION \
  --build-arg NGINX_COMMIT \
  --build-arg NGINX_VERSION \
  --build-arg NGX_BROTLI_COMMIT \
  --build-arg NJS_COMMIT \
  --build-arg NJS_VERSION \
  --build-arg OPENSSL_VERSION \
  --build-arg RTMP_VERSION \
  --build-arg ZSTD_MODULE_VERSION \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

# Run config test
docker run --rm --env-file .env -v "$(pwd)/webroot:/var/www/html:ro,z" "$IMAGE_NAME:$IMAGE_TAG" /usr/bin/nginx -t

# Get build version info
docker run --rm --env-file .env -e ENTRYPOINT_QUIET=y -v "$(pwd)/webroot:/var/www/html:ro,z" "$IMAGE_NAME:$IMAGE_TAG" /usr/bin/nginx -V

build_date_end_timestamp=$(date +%s)
build_date_end_pretty=$(LC_TIME="en_US.UTF-8" TZ="GMT" date "+%a, %d %b %Y %T %Z")
build_date_end=$(LC_TIME="en_US.UTF-8" TZ="UTC" date +"%Y-%m-%d.%H%M")

set +v

echo "build started at: $build_date_start_pretty"
echo "build started at: $build_date_start"
echo "build ended at: $build_date_end_pretty"
echo "build ended at: $build_date_end"
echo "build took $(expr $build_date_end_timestamp - $build_date_start_timestamp) seconds"

