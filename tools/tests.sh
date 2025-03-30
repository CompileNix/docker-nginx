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

source .env

if [ -t 1 ]; then
  # STDOUT is attached to TTY
  extra_docker_command_flags="-it"
  terminal_green="\033[0;32m"
  terminal_reset="\033[0m"
else
  extra_docker_command_flags=""
  terminal_green=""
  terminal_reset=""
fi

download_hurl="true"
if [ -f "./tools/hurl" ]; then
  download_hurl="false"
  echo "./tools/hurl is present"

  present_hurl_version="$(./tools/hurl --version 2>/dev/null | rg 'hurl ([\d.]{1,5})' -or '$1')"
  if [[ "$present_hurl_version" != "$HURL_VERSION" ]]; then
    download_hurl="true"
    echo "./tools/hurl has the version $present_hurl_version but we expected to have $HURL_VERSION"
  else
    echo "./tools/hurl has the expected version of $HURL_VERSION"
  fi
fi

if [[ "$download_hurl" = "true" ]]; then
    INSTALL_DIR="/tmp"

    if [ -d "${INSTALL_DIR}/hurl-${HURL_VERSION}-x86_64-unknown-linux-gnu" ]; then
        rm -rf "${INSTALL_DIR}/hurl-${HURL_VERSION}-x86_64-unknown-linux-gnu"
    fi

    curl --silent --location "https://github.com/Orange-OpenSource/hurl/releases/download/${HURL_VERSION}/hurl-${HURL_VERSION}-x86_64-unknown-linux-gnu.tar.gz" | tar xvz -C "$INSTALL_DIR"
    cp -v "${INSTALL_DIR}/hurl-${HURL_VERSION}-x86_64-unknown-linux-gnu/bin/hurl" ./tools/hurl
    rm -rf "${INSTALL_DIR}/hurl-${HURL_VERSION}-x86_64-unknown-linux-gnu"
fi

# Generate random port numbers to use for testing and echo them for easy copy & paste to stdout
export HTTP_PORT="$(shuf -i 32768-49152 -n 1)"
export HTTP_STUB_PORT="$(shuf -i 32768-49152 -n 1)"
export HTTPS_PORT="$(shuf -i 32768-49152 -n 1)"

docker rm --force "nginx-test" 2>/dev/null

# show nginx build config to stdout
docker run --rm $extra_docker_command_flags \
  --name "nginx-test" \
  "$IMAGE_NAME:$NGINX_VERSION" nginx -T

# Testing default
docker run --rm -d \
  --name "nginx-test" \
  --env-file ".env" \
  -p "127.0.0.1:$HTTP_PORT:80" \
  -p "127.0.0.1:$HTTP_STUB_PORT:81" \
  -p "127.0.0.1:$HTTPS_PORT:443" \
  -p "127.0.0.1:$HTTPS_PORT:443/udp" \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  -v "$PWD/config/sites/localhost.conf:/config/sites/localhost.conf:ro,z" \
  -v "$PWD/config/sites/status.conf:/config/sites/status.conf:ro,z" \
  "$IMAGE_NAME:$NGINX_VERSION"

set +ex
echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
while [ $? -eq 3 ]; do
    sleep 0.2
    echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
done
set -ex

# https://github.com/yurymuski/curl-http3
# https://github.com/stunnel/static-curl
# TODO: build curl from source with http3 support
# && ./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed --http3 ./tests/https_test_compressed_h3.hurl \
# TODO: figure out how to test zstd compression. Create PR for hurl maybe?
# && ./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/https_test_compressed_static_zstd.hurl \

./tools/hurl --verbose --variable HTTP_STUB_PORT="$HTTP_STUB_PORT" ./tests/http_stub.hurl
./tools/hurl --verbose --variable HTTP_PORT="$HTTP_PORT" ./tests/http_test.hurl
./tools/hurl --verbose --variable HTTP_PORT="$HTTP_PORT" ./tests/http_test_error_page.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem ./tests/https_test.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/https_test_compressed.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem ./tests/https_server_protocol_h2.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/https_test_compressed_static_gzip.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/https_test_compressed_static_brotli.hurl

docker rm --force "nginx-test" 2>/dev/null

# Testing NJS for default image variant
docker run --rm -d \
  --name "nginx-test" \
  --env-file ".env" \
  -p "127.0.0.1:$HTTP_PORT:80" \
  -p "127.0.0.1:$HTTP_STUB_PORT:81" \
  -p "127.0.0.1:$HTTPS_PORT:443" \
  -p "127.0.0.1:$HTTPS_PORT:443/udp" \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  -v "$PWD/njs/njs.conf:/config/njs.conf:ro,z" \
  -v "$PWD/njs/http.js:/config/njs/http.js:ro,z" \
  -v "$PWD/njs/localhost.conf:/config/sites/localhost.conf:ro,z" \
  -v "$PWD/config/sites/status.conf:/config/sites/status.conf:ro,z" \
  "$IMAGE_NAME:$NGINX_VERSION"

set +ex
echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
while [ $? -eq 3 ]; do
    sleep 0.2
    echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
done
set -ex

# https://github.com/yurymuski/curl-http3
# https://github.com/stunnel/static-curl
# TODO: build curl from source with http3 support
# && ./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed --http3 ./tests/https_test_compressed_h3.hurl \
# TODO: figure out how to test zstd compression. Create PR for hurl maybe?
# && ./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/https_test_compressed_static_zstd.hurl \

./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem ./tests/https_njs_hello.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --variable NJS_VERSION="$NJS_VERSION" --cacert ./config/ssl/cert.pem ./tests/https_njs_version.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem ./tests/https_healthy.hurl

docker rm --force "nginx-test" 2>/dev/null

# Testing Perl for extras image variant
docker run --rm -d \
  --name "nginx-test" \
  --env-file ".env" \
  -p "127.0.0.1:$HTTP_PORT:80" \
  -v "$PWD/src/etc/nginx/nginx.conf:/config/nginx.conf:ro,z" \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  -v "$PWD/perl/perl.conf:/config/perl.conf:ro,z" \
  -v "$PWD/perl/lib:/config/perl/lib:ro,z" \
  -v "$PWD/perl/localhost.conf:/config/sites/localhost.conf:ro,z" \
  "$IMAGE_NAME:$NGINX_VERSION-extras"

set +ex
echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
while [ $? -eq 3 ]; do
    sleep 0.2
    echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
done
set -ex

./tools/hurl --verbose --variable HTTP_PORT="$HTTP_PORT" ./tests/http_perl.hurl

docker rm --force "nginx-test" 2>/dev/null

# Testing slim
docker run --rm -d \
  --name "nginx-test" \
  --env-file ".env" \
  -p "127.0.0.1:$HTTP_PORT:80" \
  -p "127.0.0.1:$HTTP_STUB_PORT:81" \
  -p "127.0.0.1:$HTTPS_PORT:443" \
  -p "127.0.0.1:$HTTPS_PORT:443/udp" \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  -v "$PWD/config/sites/localhost.conf:/config/sites/localhost.conf:ro,z" \
  -v "$PWD/config/sites/status.conf:/config/sites/status.conf:ro,z" \
  "$IMAGE_NAME:$NGINX_VERSION-slim"

set +ex
echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
while [ $? -eq 3 ]; do
    sleep 0.2
    echo "GET http://127.0.0.1:$HTTP_PORT/test.html" | ./tools/hurl >/dev/null 2>&1
done
set -ex

# https://github.com/yurymuski/curl-http3
# https://github.com/stunnel/static-curl
# TODO: build curl from source with http3 support
# && ./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed --http3 ./tests/https_test_compressed_h3.hurl \

./tools/hurl --verbose --variable HTTP_STUB_PORT="$HTTP_STUB_PORT" ./tests/http_stub.hurl
./tools/hurl --verbose --variable HTTP_PORT="$HTTP_PORT" ./tests/http_test.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem ./tests/https_test.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/slim_https_test_compressed.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem ./tests/https_server_protocol_h2.hurl
./tools/hurl --verbose --variable HTTPS_PORT="$HTTPS_PORT" --cacert ./config/ssl/cert.pem --compressed ./tests/https_test_compressed_static_gzip.hurl

docker rm --force "nginx-test" 2>/dev/null

set +xv

echo
echo -e "${terminal_green}Tests complete 🙌🚀${terminal_reset}"
