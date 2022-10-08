
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
- add runtime env support of `NGINX_ENTRYPOINT_QUIET_LOGS` to docker entrypoint scripts

### Nginx Build Info
```
nginx version: nginx/1.23.1 (a63d0a70afea)
built by gcc 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
built with OpenSSL 3.0.5 5 Jul 2022
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.34 --add-module=/usr/src/ngx_brotli --add-module=/usr/src/njs-nginx-module-1592d46d9076/nginx --build=a63d0a70afea --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.0.5 --with-pcre-jit --with-pcre=/usr/src/pcre2-10.40 --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --with-zlib=/usr/src/zlib-1.2.12 --with-cc-opt='-O3 -pipe' --with-openssl-opt='-O3 -pipe' --with-zlib-opt='-O3 -pipe' --with-ld-opt=-static
```

