[TOC]

# Changes

## 1.26.0: Wed, 01 May 2024 22:32:46 GMT

Some config and entrypoint script changes.

### Changes
- set `HTTP_PROXY` to empty string to mitigate httpoxy
- disable `ssl_stapling` for default configs, since self-signed certs dont have OCSP
- add entrypoint script `150-remove-default-sites.sh` to remove default sites if the user supplied one or more site configs via `/config/sites/*.conf`

## 1.26.0: Sat, 27 Apr 2024 23:41:39 GMT

Build log: [1.26.0-a58202a8c41b-2024-04-27.2341.log](https://compilenix.org/static/build-logs/nginx/1.26.0-a58202a8c41b-2024-04-27.2341.log)

### Changes
- update nginx from 1.25.5 to 1.26.0
- update build base image from fedora 39 to 40
- add custom `mime.types`, with additional mime-type `.mjs` -> `application/javascript`

### Nginx Build Info
```
nginx version: nginx/1.26.0 (a58202a8c41b)
built with OpenSSL 3.3.0 9 Apr 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-11d956c1577c/nginx --build=a58202a8c41b --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-openssl=/usr/src/openssl-3.3.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-openssl-opt='-O2 -pipe' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.5: Tue, 16 Apr 2024 18:39:57 GMT

Build log: [1.25.5-8618e4d900cc-2024-04-16.1825.log](https://compilenix.org/static/build-logs/nginx/1.25.5-8618e4d900cc-2024-04-16.1825.log)

### Changes
- update nginx from 1.25.4 to 1.25.5
- update njs from 0.8.3 to 0.8.4

### Nginx Build Info
```
nginx version: nginx/1.25.5 (8618e4d900cc)
built with OpenSSL 3.3.0 9 Apr 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-11d956c1577c/nginx --build=8618e4d900cc --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-openssl=/usr/src/openssl-3.3.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-openssl-opt='-O2 -pipe' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.4: Tue, 09 Apr 2024 17:20:11 GMT

Build log: [1.25.4-173a0a7dbce5-2024-04-09.1706.log](https://compilenix.org/static/build-logs/nginx/1.25.4-173a0a7dbce5-2024-04-09.1706.log)

### Changes
- update openssl from 3.2.1 to 3.3.0

### Nginx Build Info
```
nginx version: nginx/1.25.4 (173a0a7dbce5)
built with OpenSSL 3.3.0 9 Apr 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-3aba7ee62080/nginx --build=173a0a7dbce5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-openssl=/usr/src/openssl-3.3.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-openssl-opt='-O2 -pipe' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.4: Sun, 25 Feb 2024 19:47:26 GMT

Build log: [1.25.4-173a0a7dbce5-2024-02-25.1947.log](https://compilenix.org/static/build-logs/nginx/1.25.4-173a0a7dbce5-2024-02-25.1947.log)

### Changes
- update nginx from 1.25.3 to 1.25.4
- update njs 0.8.2 to 0.8.3
- update headers more module from 0.35 to 0.37
- update base image of build enviroment from Fedora 38 to 39
- update openssl from 3.0.12 to 3.2.1
- change default rsa certificate and dhparam size from 2048 bits to 4096 bits
- add dhparam file to container image
- remove `AES256+EECDH` and `AES256+EDH` from `ssl_ciphers` in default `nginx.conf`
- switch from `docker-compose` script to `docker compose` plugin

### Nginx Build Info
```
nginx version: nginx/1.25.4 (173a0a7dbce5)
built with OpenSSL 3.2.1 30 Jan 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-3aba7ee62080/nginx --build=173a0a7dbce5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-openssl=/usr/src/openssl-3.2.1 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-openssl-opt='-O2 -pipe' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.3: Mon, 30 Oct 2023 16:57:40 GMT

Build log: [1.25.3-294a3d07234f-2023-10-30.1645.log](https://compilenix.org/static/build-logs/nginx/1.25.3-294a3d07234f-2023-10-30.1645.log)

### Changes
- build openssl from source again, because fedora ships an outdated version
- update nginx from 1.25.2 to 1.25.3
- update njs 0.8.1 to 0.8.2
- update headers-more-nginx-module from 0.34 to 0.35
- update ngx_brotli to [a71f9312c2deb28875acc7bacfdd5695a111aa53](https://github.com/google/ngx_brotli/compare/63ca02abdcf79c9e788d2eedcc388d2335902e52...a71f9312c2deb28875acc7bacfdd5695a111aa53)

### Nginx Build Info
```
nginx version: nginx/1.25.3 (294a3d07234f)
built with OpenSSL 3.0.12 24 Oct 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.35 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-45f81882c780/nginx --build=294a3d07234f --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-openssl=/usr/src/openssl-3.0.12 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-openssl-opt='-O2 -pipe' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.2: Fri, 15 Sep 2023 09:03:06 GMT

Build log: [1.25.2-1d839f05409d-2023-09-15.0857.log](https://compilenix.org/static/build-logs/nginx/1.25.2-1d839f05409d-2023-09-15.0857.log)

### Changes
- update njs from 0.8.0 to 0.8.1: [Release notes](https://nginx.org/en/docs/njs/changes.html#njs0.8.1)
- update ngx_brotli to [63ca02abdcf79c9e788d2eedcc388d2335902e52](https://github.com/google/ngx_brotli/commit/63ca02abdcf79c9e788d2eedcc388d2335902e52)
  - Update brotli submodule to v1.1.0 ([#147](https://github.com/google/ngx_brotli/pull/147))
  - Fix broken brotli build (upstream brotli dropped makefile support and sources.lst file) ([#150](https://github.com/google/ngx_brotli/pull/150))
- update build base image from Fedora 37 to 38

### Nginx Build Info
```
nginx version: nginx/1.25.2 (1d839f05409d)
built with OpenSSL 3.0.9 30 May 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli-63ca02abdcf79c9e788d2eedcc388d2335902e52 --add-module=/usr/src/njs-a52b49f9afcf/nginx --build=1d839f05409d --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.2: Thu, 24 Aug 2023 19:14:31 GMT

Build log: [1.25.2-1d839f05409d-2023-08-24.1908.log](https://compilenix.org/static/build-logs/nginx/1.25.2-1d839f05409d-2023-08-24.1908.log)

### Changes
- update nginx from 1.25.1 to 1.25.2: [Release notes](https://nginx.org/en/CHANGES)
- update njs from 0.7.12 to 0.8.0: [Release notes](https://nginx.org/en/docs/njs/changes.html#njs0.8.0)

### Nginx Build Info
```
nginx version: nginx/1.25.2 (1d839f05409d)
built with OpenSSL 3.0.9 30 May 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli-6e975bcb015f62e1f303054897783355e2a877dc --add-module=/usr/src/njs-0ed1952588ab/nginx --build=1d839f05409d --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.25.1: Sat, 17 Jun 2023 19:30:50 GMT

Build log: [1.25.1-f8134640e861-2023-06-17.1926.log](https://compilenix.org/static/build-logs/nginx/1.25.1-f8134640e861-2023-06-17.1926.log)

### Changes
- update nginx from 1.24.0 to 1.25.1: [Release notes](https://nginx.org/en/CHANGES)

### Nginx Build Info
```
nginx version: nginx/1.25.1 (f8134640e861)
built with OpenSSL 3.0.9 30 May 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli-6e975bcb015f62e1f303054897783355e2a877dc --add-module=/usr/src/njs-a1faa64d4972/nginx --build=f8134640e861 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.24.0: Wed, 12 Apr 2023 09:55:42 GMT

Build log: [1.24.0-420f96a6f7ac-2023-04-12.0950.log](https://compilenix.org/static/build-logs/nginx/1.24.0-420f96a6f7ac-2023-04-12.0950.log)

### Changes
- update nginx from 1.23.4 to 1.24.0: [Release notes](https://nginx.org/en/CHANGES-1.24)

### Nginx Build Info
```
nginx version: nginx/1.24.0 (420f96a6f7ac)
built with OpenSSL 3.0.8 7 Feb 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli-6e975bcb015f62e1f303054897783355e2a877dc --add-module=/usr/src/njs-a1faa64d4972/nginx --build=420f96a6f7ac --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.23.4: Tue, 11 Apr 2023 11:17:11 GMT

Build log: [1.23.4-ac779115ed6e-2023-04-11.1117.log](https://compilenix.org/static/build-logs/nginx/1.23.4-ac779115ed6e-2023-04-11.1117.log)

### Changes
- update njs from 0.7.11 to 0.7.12: [Release notes](https://nginx.org/en/docs/njs/changes.html#njs0.7.12)

### Nginx Build Info
```
nginx version: nginx/1.23.4 (ac779115ed6e)
built with OpenSSL 3.0.8 7 Feb 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli-6e975bcb015f62e1f303054897783355e2a877dc --add-module=/usr/src/njs-a1faa64d4972/nginx --build=ac779115ed6e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.23.4: Wed, 05 Apr 2023 11:48:57 GMT

Build log: [1.23.4-ac779115ed6e-2023-04-05.1143.log](https://compilenix.org/static/build-logs/nginx/1.23.4-ac779115ed6e-2023-04-05.1143.log)

### Changes
- update nginx from 1.23.3 to 1.23.4
  - we are now only building nginx mainline versions
- update njs from 0.7.10 to 0.7.11
- update openssl from 3.0.7 to 3.0.8
- switch from static linked binary to dynamically linked
- add `add-user.sh` and `permissions.sh`
- put image name into env variable
- dont build deps which can be linked from build-env os
  - openssl
  - pcre
  - zlib
- removed busybox; we are using build-env os binaries instead
- no custom CFLAGS anymore; we are using now the same as fedora does
- run `strip` on shared objects as well, in case there is something to
  remove from any
- remove default http response header `referrer-policy` from nginx config
- cleanup `/etc/{group,passwd,shadow}` files
  - remove some unused users and groups
  - switch `nginx` user and group id from `1000` to `101`
- remove obsolete zlib patch
- add tools / binaries:
  - `chmod`
  - `chown`
  - `id`
- remove nginx modules:
  - `http_xslt`
  - `mail`
  - `mail_ssl`
  - `compat`
  - `http_random_index`
  - `http_slice`
  - `http_secure_link`
  - `http_dav`
- add default index.html file to `/var/www/html`
- change default value of `NGINX_WORKER_PROCESSES` from `2` to `auto`
- switch from `nginx` user to `root`, this can be overriden via `--user`
- change default exposed ports from `2080` & `2443` to `80` & `443`
- add `status.conf`, listening on localhost inside the container on port `81`, serving `stub_status` at `/`.
- update envsubst ob nginx configs on container start logic:
  - merge existing configs and those coming from a mapped volume on every container start.
    this allowes changed env vars between starts to be re-applied and updates to mapped
    nginx conig files to take effect.
- update file permissions on container start for merged configs in `/etc/nginx`
- update `nginx.conf`:
  - disable on-the-fly brotli compression of responses. Can be enabled via `brotli on;`
  - same with on-the-fly gzip compression. Can be enabled via `gzip on;` and `gzip_vary on;`

### Nginx Build Info
```
nginx version: nginx/1.23.4 (ac779115ed6e)
built with OpenSSL 3.0.8 7 Feb 2023
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-26dd3824b9f3/nginx --build=ac779115ed6e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-debug --with-file-aio --with-http_gunzip_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fPIC -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --with-ld-opt='-fPIC -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1'
```

## 1.22.1: Sun, 08 Jan 2023 23:24:59 GMT

Build log: [1.22.1-af7a3fb7558f-2023-01-08.2254.log](https://compilenix.org/static/build-logs/nginx/1.22.1-af7a3fb7558f-2023-01-08.2254.log)

### Changes
- update pcre2 from 10.40 to 10.42
- update busybox from 1.34.1 to 1.36.0

### Nginx Build Info
```
nginx version: nginx/1.22.1 (af7a3fb7558f)
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-5f705230a62c-0.7.9/nginx --build=af7a3fb7558f --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.7 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.42 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.23.3: Sun, 08 Jan 2023 23:52:49 GMT

Build log: [1.23.3-ff3afd1ce6a6-2023-01-08.2324.log](https://compilenix.org/static/build-logs/nginx/1.23.3-ff3afd1ce6a6-2023-01-08.2324.log)

### Changes
- update nginx from 1.23.2 to 1.23.3
- update pcre2 from 10.40 to 10.42
- update busybox from 1.34.1 to 1.36.0

### Nginx Build Info
```
nginx version: nginx/1.23.3 (ff3afd1ce6a6)
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-5f705230a62c-0.7.9/nginx --build=ff3afd1ce6a6 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.7 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.42 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.22.1: Sun, 27 Nov 2022 20:19:30 GMT

Build log: [1.22.1-af7a3fb7558f-2022-11-27.2012.log](https://compilenix.org/static/build-logs/nginx/1.22.1-af7a3fb7558f-2022-11-27.2012.log)

### Changes
- nginx njs module update to 0.7.9
- add njs module version string to build config
- remove the following timezone data binary files:
  - `posixtz`
  - `zdump`
  - `zic`

### Nginx Build Info
```
nginx version: nginx/1.22.1 (af7a3fb7558f)
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-5f705230a62c-0.7.9/nginx --build=af7a3fb7558f --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.7 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.23.2: Sun, 27 Nov 2022 20:12:59 GMT

Build log: [1.23.2-aa901551a7eb-2022-11-27.2005.log](https://compilenix.org/static/build-logs/nginx/1.23.2-aa901551a7eb-2022-11-27.2005.log)

### Changes
- nginx njs module update to 0.7.9
- add njs module version string to build config
- remove the following timezone data binary files:
  - `posixtz`
  - `zdump`
  - `zic`

### Nginx Build Info
```
nginx version: nginx/1.23.2 (aa901551a7eb)
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-5f705230a62c-0.7.9/nginx --build=aa901551a7eb --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.7 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.22.1: Tue, 01 Nov 2022 16:27:58 GMT

Build log: [1.22.1-af7a3fb7558f-2022-11-01.1621.log](https://compilenix.org/static/build-logs/nginx/1.22.1-af7a3fb7558f-2022-11-01.1621.log)

### Changes
- openssl update to 3.0.7
  - X.509 Email Address 4-byte Buffer Overflow (CVE-2022-3602)
  - X.509 Email Address Variable Length Buffer Overflow (CVE-2022-3786)
  - https://www.openssl.org/news/secadv/20221101.txt
- nginx update to 1.22.1
- nginx njs module update to 0.7.8

### Nginx Build Info
```
nginx version: nginx/1.22.1 (af7a3fb7558f)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-3308415d7de8/nginx --build=af7a3fb7558f --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.7 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.23.2: Tue, 01 Nov 2022 16:21:19 GMT

Build log: [1.23.2-aa901551a7eb-2022-11-01.1614.log](https://compilenix.org/static/build-logs/nginx/1.23.2-aa901551a7eb-2022-11-01.1614.log)

### Changes
- openssl update to 3.0.7
  - X.509 Email Address 4-byte Buffer Overflow (CVE-2022-3602)
  - X.509 Email Address Variable Length Buffer Overflow (CVE-2022-3786)
  - https://www.openssl.org/news/secadv/20221101.txt
- nginx update to 1.23.2
- nginx njs module update to 0.7.8

### Nginx Build Info
```
nginx version: nginx/1.23.2 (aa901551a7eb)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-3308415d7de8/nginx --build=aa901551a7eb --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.7 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.22.0: Tue, 18 Oct 2022 19:58:07 GMT

Build log: [1.22.0-f669c9c2a617-2022-10-18.1952.log](https://compilenix.org/static/build-logs/nginx/1.22.0-f669c9c2a617-2022-10-18.1952.log)

### Changes
- zlib upgrade to 1.2.13
  - https://www.zlib.net/ChangeLog.txt \
    This remedies [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434)
- openssl downgrade to 3.0.5
  - https://mta.openssl.org/pipermail/openssl-announce/2022-October/000237.html

### Nginx Build Info
```
nginx version: nginx/1.22.0 (f669c9c2a617)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.5 5 Jul 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=f669c9c2a617 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.5 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.23.1: Tue, 18 Oct 2022 19:52:01 GMT

Build log: [1.23.1-a63d0a70afea-2022-10-18.1945.log](https://compilenix.org/static/build-logs/nginx/1.23.1-a63d0a70afea-2022-10-18.1945.log)

### Changes
- zlib upgrade to 1.2.13
  - https://www.zlib.net/ChangeLog.txt \
    This remedies [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434)
- openssl downgrade to 3.0.5
  - https://mta.openssl.org/pipermail/openssl-announce/2022-October/000237.html
- add `clean.sh`

### Nginx Build Info
```
nginx version: nginx/1.23.1 (a63d0a70afea)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.5 5 Jul 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=a63d0a70afea --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.5 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.13 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.22.0: Tue, 11 Oct 2022 19:08:39 GMT

Build log: [1.22.0-f669c9c2a617-2022-10-11.1902.log](https://compilenix.org/static/build-logs/nginx/1.22.0-f669c9c2a617-2022-10-11.1902.log)

### Changes
- update to OpenSSL 3.0.6

### Nginx Build Info
```
nginx version: nginx/1.22.0 (f669c9c2a617)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.6 11 Oct 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=f669c9c2a617 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.6 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.12 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.23.1: Tue, 11 Oct 2022 19:02:35 GMT

Build log: [1.23.1-a63d0a70afea-2022-10-11.1856.log](https://compilenix.org/static/build-logs/nginx/1.23.1-a63d0a70afea-2022-10-11.1856.log)

### Changes
- update to OpenSSL 3.0.6
- add env template
- add build-all and push-image scripts

### Nginx Build Info
```
nginx version: nginx/1.23.1 (a63d0a70afea)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.6 11 Oct 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=a63d0a70afea --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.6 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.12 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.22.0: Sat, 08 Oct 2022 17:33:19 GMT

Build log: [1.22.0-f669c9c2a617-2022-10-08.1733.log](https://compilenix.org/static/build-logs/nginx/1.22.0-f669c9c2a617-2022-10-08.1733.log)

### Changes
- fix [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434) in zlib
  - https://github.com/madler/zlib/commit/eff308af425b67093bab25f80f1ae950166bece1
  - https://github.com/madler/zlib/commit/1eb7682f845ac9e9bf9ae35bbfb3bad5dacbd91d

### Nginx Build Info
```
nginx version: nginx/1.22.0 (f669c9c2a617)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.5 5 Jul 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=f669c9c2a617 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.5 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.12 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

## 1.23.1: Sat, 08 Oct 2022 17:24:14 GMT

Build log: [1.23.1-a63d0a70afea-2022-10-08.1724.log](https://compilenix.org/static/build-logs/nginx/1.23.1-a63d0a70afea-2022-10-08.1724.log)

### Changes
- fix [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434) in zlib
  - https://github.com/madler/zlib/commit/eff308af425b67093bab25f80f1ae950166bece1
  - https://github.com/madler/zlib/commit/1eb7682f845ac9e9bf9ae35bbfb3bad5dacbd91d
- add Changelog
- update readme `Nginx config test` section
- update `build.sh`
  - switch from `sh` to `bash`
  - run `nginx -t` config test after build completion
  - run `nginx -V` after build completion
  - add build start and end timesamps
  - add build log upload command and url
- remove some packages for the build env
  - pcre2-dev
  - zlib-dev
- add `BUILD_THROTTLE` build env
  Reduce build jobs by 4 if there are more then 7 cores else set jobs to half of core count. \
  this is useful if you dont want to congest the cpu of your building system
- `sites/localhost.conf` \
  override default content type for `GET /health` requests
- add runtime env support of `ENTRYPOINT_QUIET` to docker entrypoint scripts

### Nginx Build Info
```
nginx version: nginx/1.23.1 (a63d0a70afea)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.5 5 Jul 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=a63d0a70afea --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.5 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.12 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

