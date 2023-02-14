# vim: sw=2 et

FROM fedora:37 AS base-os
RUN dnf upgrade --refresh -y \
  && dnf install -y \
    curl \
    git \
    lld \
    tree \
    tzdata \
    upx \
    wget

FROM base-os AS build-renvsubst
RUN \
  dnf install -y gcc \
  && cd ~ \
  && curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly \
  && source .cargo/env \
  && rustup component add rust-src --toolchain nightly \
  && git clone https://github.com/CompileNix/renvsubst \
  && cd renvsubst \
  && cargo \
    +nightly build \
    -Z build-std=std,panic_abort \
    -Z build-std-features=panic_immediate_abort \
    --target x86_64-unknown-linux-gnu \
    --release \
  && upx --best --lzma target/x86_64-unknown-linux-gnu/release/cnx-renvsubst \
  && cp -v target/x86_64-unknown-linux-gnu/release/cnx-renvsubst /envsubst

FROM base-os AS build

ARG BUILD_THROTTLE
ARG CFLAGS_ADD
ARG HEADERS_MORE_VERSION
ARG NGINX_COMMIT
ARG NGINX_VERSION
ARG NGX_BROTLI_COMMIT
ARG NJS_COMMIT
ARG NJS_VERSION
ARG OPENSSL_VERSION
ARG PCRE_VERSION
ARG ZLIB_VERSION

RUN \
  env | sort

WORKDIR /usr/src/

RUN \
  echo "Downloading nginx $NGINX_VERSION (rev $NGINX_COMMIT from 'default' branch) ..." \
  && cd /usr/src \
  && wget --no-verbose https://hg.nginx.org/nginx/archive/${NGINX_COMMIT}.tar.gz -O nginx-${NGINX_COMMIT}.tar.gz \
  && tar -xf nginx-${NGINX_COMMIT}.tar.gz

RUN \
  echo "Downloading nginx njs module v${NJS_VERSION} (rev $NJS_COMMIT) ..." \
  && cd /usr/src \
  && wget --no-verbose https://hg.nginx.org/njs/archive/${NJS_COMMIT}.tar.gz -O njs-${NJS_COMMIT}.tar.gz \
  && tar -xf njs-${NJS_COMMIT}.tar.gz

RUN \
  echo "Cloning brotli module (rev $NGX_BROTLI_COMMIT) ..." \
  && mkdir -pv /usr/src/ngx_brotli \
  && cd /usr/src/ngx_brotli \
  && git init \
  && git remote add origin https://github.com/google/ngx_brotli.git \
  && git fetch --depth 1 origin $NGX_BROTLI_COMMIT \
  && git checkout --recurse-submodules -q FETCH_HEAD \
  && git submodule update --init --depth 1

RUN \
  echo "Downloading headers-more module (rev $HEADERS_MORE_VERSION) ..." \
  && cd /usr/src \
  && wget --no-verbose https://github.com/openresty/headers-more-nginx-module/archive/refs/tags/v${HEADERS_MORE_VERSION}.tar.gz -O headers-more-nginx-module-${HEADERS_MORE_VERSION}.tar.gz \
  && tar -xf headers-more-nginx-module-${HEADERS_MORE_VERSION}.tar.gz

RUN \
  echo "Downloading zlib (version $ZLIB_VERSION) ..." \
  && cd /usr/src \
  && wget --no-verbose https://zlib.net/fossils/zlib-${ZLIB_VERSION}.tar.gz -O zlib-${ZLIB_VERSION}.tar.gz \
  && tar -xf zlib-${ZLIB_VERSION}.tar.gz

RUN \
  echo "Downloading OpenSSL (version $OPENSSL_VERSION) ..." \
  && cd /usr/src \
  && wget --no-verbose https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -O openssl-${OPENSSL_VERSION}.tar.gz \
  && tar -xf openssl-${OPENSSL_VERSION}.tar.gz

RUN \
  echo "Downloading PCRE (version $PCRE_VERSION) ..." \
  && cd /usr/src \
  && wget --no-verbose https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${PCRE_VERSION}/pcre2-${PCRE_VERSION}.tar.gz -O pcre2-${PCRE_VERSION}.tar.gz \
  && tar -xf pcre2-${PCRE_VERSION}.tar.gz

# tools required for source patching and building
RUN \
  dnf install -y \
    autoconf \
    automake \
    clang \
    cmake \
    diffutils \
    gcc \
    gd-devel \
    GeoIP-devel \
    glibc-devel \
    kernel-headers \
    libtool \
    libxml2-devel \
    libxslt-devel \
    make \
    openssl-devel \
    pax-utils \
    pcre2-devel \
    perl-devel \
    perl-FindBin \
    perl-IPC-Cmd \
    perl-Pod-Html \
    python3 \
    readline-devel \
    which

  # --with-http_image_filter_module \
ARG CONFIG="\
  --add-module=/usr/src/headers-more-nginx-module-$HEADERS_MORE_VERSION \
  --add-module=/usr/src/ngx_brotli \
  --add-module=/usr/src/njs-$NJS_COMMIT/nginx \
  --build=$NGINX_COMMIT \
  --conf-path=/etc/nginx/nginx.conf \
  --error-log-path=/var/log/nginx/error.log \
  --group=nginx \
  --http-client-body-temp-path=/var/cache/nginx/client_temp \
  --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
  --http-log-path=/var/log/nginx/access.log \
  --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
  --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
  --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
  --lock-path=/var/run/nginx/nginx.lock \
  --modules-path=/usr/lib/nginx/modules \
  --pid-path=/var/run/nginx/nginx.pid \
  --prefix=/etc/nginx \
  --sbin-path=/usr/bin/nginx \
  --user=nginx \
  --with-compat \
  --with-debug \
  --with-file-aio \
  --with-http_addition_module \
  --with-http_auth_request_module \
  --with-http_flv_module \
  --with-http_geoip_module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module \
  --with-http_mp4_module \
  --with-http_random_index_module \
  --with-http_realip_module \
  --with-http_secure_link_module \
  --with-http_slice_module \
  --with-http_ssl_module \
  --with-http_stub_status_module \
  --with-http_sub_module \
  --with-http_v2_module \
  --with-http_xslt_module \
  --with-mail \
  --with-mail_ssl_module \
  --with-openssl=/usr/src/openssl-${OPENSSL_VERSION} \
  --with-pcre-jit \
  --with-pcre=/usr/src/pcre2-$PCRE_VERSION \
  --with-stream \
  --with-stream_geoip_module \
  --with-stream_realip_module \
  --with-stream_ssl_module \
  --with-stream_ssl_preread_module \
  --with-threads \
  --with-zlib=/usr/src/zlib-$ZLIB_VERSION \
  "

COPY ./patches /patches

RUN \
  echo "Apply nginx patches ..." \
  && cd /usr/src/nginx-$NGINX_COMMIT \
  && echo "apply ngx_http_error_tail.patch" && cat /patches/nginx/ngx_http_error_tail.patch && git apply /patches/nginx/ngx_http_error_tail.patch

# RUN \
#   echo "Apply zlib patches ..." \
#   && cd /usr/src/zlib-$ZLIB_VERSION \
#   && echo "apply CVE-2022-37434.patch" && cat /patches/zlib/CVE-2022-37434.patch && git apply /patches/zlib/CVE-2022-37434.patch

RUN \
  echo "Calculate MAKE_JOBS ..." \
  && MAKE_JOBS=$(nproc) \
  # Reduce jobs by 4 if there are more then 7 cores or else set jobs to half of core count
  && if [ "$MAKE_JOBS" -ge 8 ]; then export MAKE_JOBS=$(( $MAKE_JOBS - 4 )); else export MAKE_JOBS=$(( $MAKE_JOBS / 2 )); fi \
  # Set jobs to 1 if calculated value is less then 1
  && if [ "$MAKE_JOBS" -lt 1 ]; then export MAKE_JOBS=1; fi \
  # Set jobs back to result of nproc if BUILD_THROTTLE is not requested
  && if [[ "$BUILD_THROTTLE" != "y" ]]; then export MAKE_JOBS=$(nproc); fi \
  && echo "Make job count: $MAKE_JOBS"

RUN \
  echo "Building nginx ($NGINX_VERSION) ..." \
  && cd /usr/src/nginx-${NGINX_COMMIT} \
  # cc and ld opts from official fedora builds
  && ./auto/configure $CONFIG \
    --with-cc-opt="$CFLAGS_ADD -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fPIC -fstack-protector-strong -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection" \
    --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -Wl,--build-id=sha1 -Wl,-E' \
    --with-openssl-opt="$CFLAGS_ADD" \
    --with-zlib-opt="$CFLAGS_ADD" || cat objs/autoconf.err \
  && make -j$MAKE_JOBS \
  && make install \
  && env | sort

RUN \
  cd /usr/src/nginx-${NGINX_COMMIT} \
  # && strip /usr/lib/nginx/modules/*.so
  && strip /usr/bin/nginx \
  && echo "Scan for reqired runtime libs ..." \
  # && scanelf --needed --nobanner /usr/bin/nginx /usr/lib/nginx/modules/*.so \
  && NEEDED_LIBS=$(scanelf --needed --nobanner /usr/bin/nginx /bin/basename /bin/bash /bin/cat /bin/cp /bin/cut /bin/dirname /bin/echo /bin/env /bin/find /bin/ls /bin/mkdir /bin/printf /bin/rm /bin/sh /bin/sort /bin/stat \
    | awk '{ gsub(/,/, "\n", $2); print $2 }' | sort -u) \
  && NEEDED_LIBS=$(echo "$NEEDED_LIBS ld-linux-x86-64.so.2 libz.so.1 liblzma.so.5 libpcre2-8.so.0 libgcc_s.so.1" | awk '{ gsub(/ /, "\n"); print }' | sort -u) \
  && echo -e "Scan found the following needed libs:\n$NEEDED_LIBS\nFinding libs in filesystem:" \
  && for LIB_NAME in $NEEDED_LIBS; do echo "Looking for $LIB_NAME ..."; LIB_PATHS=$(find / -name "$LIB_NAME" -type f,l -print); for LIB_PATH in $LIB_PATHS; do echo "Found lib at: $LIB_PATH"; mkdir -pv $(dirname "/tmp/needed_libs$LIB_PATH"); cp -v "$LIB_PATH" "/tmp/needed_libs$LIB_PATH"; done; done

FROM base-os AS dist-os

COPY src/etc/group src/etc/passwd src/etc/shadow /etc/
COPY --from=build-renvsubst /envsubst /tmp/scratch/usr/bin/
COPY --from=build /usr/bin/nginx /tmp/scratch/usr/bin/
COPY --from=build /tmp/needed_libs /tmp/needed_libs
# COPY --from=build /usr/lib/nginx/modules/ /usr/lib/nginx/modules/
COPY --from=build /etc/nginx /etc/nginx
COPY src/etc/nginx/ /etc/nginx
COPY config/ /etc/nginx

RUN \
  # remove unused default nginx config files
  rm -v /etc/nginx/*.default \
  # link to nginx modules
  && ln -sv /usr/lib/nginx/modules /etc/nginx/modules \
  # forward error logs to docker log collector
  && mkdir -pv /var/log/nginx \
  && touch /var/log/nginx/access.log /var/log/nginx/error.log \
  && ln -sfv /dev/stdout /var/log/nginx/error.log \
  && ln -sfv /dev/stdout /var/log/nginx/access.log \
  # prepare new filesystem structure for next build stage
  && mkdir -pv /tmp/scratch/bin \
  && mkdir -pv /tmp/scratch/docker-entrypoint.d \
  && mkdir -pv /tmp/scratch/etc/nginx/njs \
  && mkdir -pv /tmp/scratch/etc/nginx/ssl \
  && mkdir -pv /tmp/scratch/etc/ssl/certs \
  && mkdir -pv /tmp/scratch/tmp \
  && mkdir -pv /tmp/scratch/usr/bin \
  && mkdir -pv /tmp/scratch/usr/lib/nginx/modules \
  && mkdir -pv /tmp/scratch/usr/share \
  && mkdir -pv /tmp/scratch/var/cache/nginx/client_temp \
  && mkdir -pv /tmp/scratch/var/cache/nginx/fastcgi_temp \
  && mkdir -pv /tmp/scratch/var/cache/nginx/proxy_temp \
  && mkdir -pv /tmp/scratch/var/cache/nginx/scgi_temp \
  && mkdir -pv /tmp/scratch/var/cache/nginx/uwsgi_temp \
  && mkdir -pv /tmp/scratch/var/log/nginx \
  && mkdir -pv /tmp/scratch/var/run/nginx \
  && mkdir -pv /tmp/scratch/var/www/html \
  && touch /tmp/scratch/etc/nginx/njs.conf \
  && cp -rv /tmp/needed_libs/* /tmp/scratch/ \
  && cp -rv /etc/nginx /tmp/scratch/etc/ \
  && cp -rv /usr/share/zoneinfo /tmp/scratch/usr/share/ \
  && cp -v /bin/basename /bin/bash /bin/cat /bin/cp /bin/cut /bin/dirname /bin/echo /bin/env /bin/find /bin/ls /bin/mkdir /bin/printf /bin/rm /bin/sh /bin/sort /bin/stat /tmp/scratch/bin/ \
  && cp -v /etc/group /tmp/scratch/etc/ \
  && cp -v /etc/passwd /tmp/scratch/etc/ \
  && cp -v /etc/shadow /tmp/scratch/etc/ \
  && cp -v /etc/ssl/certs/ca-certificates.crt /tmp/scratch/etc/ssl/certs/ \
  && mv -v /tmp/scratch/usr/lib64 /tmp/scratch/lib \
  && mv -v /var/log/nginx /tmp/scratch/var/log/ \
  && rm -rv /tmp/scratch/etc/nginx/html \
  && chown -Rv nginx:nginx /tmp/scratch/etc/nginx \
  && chown -Rv nginx:nginx /tmp/scratch/var/cache/nginx \
  && chown -Rv nginx:nginx /tmp/scratch/var/log/nginx \
  && chown -Rv nginx:nginx /tmp/scratch/var/run/nginx \
  && chmod -v 1777 /tmp/scratch/tmp
COPY src/docker-entrypoint.sh /tmp/scratch/
COPY src/docker-entrypoint.d/* /tmp/scratch/docker-entrypoint.d/
RUN \
  cd /tmp/scratch \
  && ln -s lib lib64 \
  && tree -a -F --dirsfirst -A -n .

FROM scratch
ENV DNS_RESOLVER="1.1.1.1"
ENV NGINX_ENVSUBST_TEMPLATE_SUFFIX=".conf"
ENV NGINX_LOG_FORMAT_NAME="main"
ENV NGINX_SERVER_HEADER=""
ENV NGINX_WORKER_PROCESSES="2"
ENV TZ="UTC"

COPY --from=dist-os /tmp/scratch /

USER nginx
EXPOSE 2080 2443
STOPSIGNAL SIGQUIT

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/nginx", "-g", "daemon off;"]

