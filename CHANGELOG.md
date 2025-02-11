[TOC]

# Changes

## 1.27.4: Tue, 11 Feb 2025 15:46:41 GMT

Build logs:
- image tag `1.27.4`: [1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-11.1549.log](https://compilenix.org/static/build-logs/nginx/1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-11.1549.log)
- image tag `1.27.4-extras`: [1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-11.1552.log](https://compilenix.org/static/build-logs/nginx/1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-11.1552.log)
- image tag `1.27.4-slim`: [1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-11.1546.log](https://compilenix.org/static/build-logs/nginx/1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-11.1546.log)

### Changes
- Update openssl from 3.4.0 to 3.4.1

#### Changes between 3.4.0 and 3.4.1 [11 Feb 2025]

 * Fixed RFC7250 handshakes with unauthenticated servers don't abort as expected.

   Clients using RFC7250 Raw Public Keys (RPKs) to authenticate a
   server may fail to notice that the server was not authenticated, because
   handshakes don't abort as expected when the SSL_VERIFY_PEER verification mode
   is set.

   ([CVE-2024-12797])

   *Viktor Dukhovni*

 * Fixed timing side-channel in ECDSA signature computation.

   There is a timing signal of around 300 nanoseconds when the top word of
   the inverted ECDSA nonce value is zero. This can happen with significant
   probability only for some of the supported elliptic curves. In particular
   the NIST P-521 curve is affected. To be able to measure this leak, the
   attacker process must either be located in the same physical computer or
   must have a very fast network connection with low latency.

   ([CVE-2024-13176])

   *Tomáš Mráz*

 * Reverted the behavior change of CMS_get1_certs() and CMS_get1_crls()
   that happened in the 3.4.0 release. These functions now return NULL
   again if there are no certs or crls in the CMS object.

   *Tomáš Mráz*

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.4 (ecb809305e54ed15be9f620d56b19ff4e4be7db5)
built with OpenSSL 3.4.1 11 Feb 2025
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.38 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.9/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=ecb809305e54ed15be9f620d56b19ff4e4be7db5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.1 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.4 (ecb809305e54ed15be9f620d56b19ff4e4be7db5)
built with OpenSSL 3.4.1 11 Feb 2025
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.38 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.9/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=ecb809305e54ed15be9f620d56b19ff4e4be7db5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.4.1 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Slim Image Variant
```
nginx version: nginx/1.27.4 (ecb809305e54ed15be9f620d56b19ff4e4be7db5)
built with OpenSSL 3.4.1 11 Feb 2025
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.38 --build=ecb809305e54ed15be9f620d56b19ff4e4be7db5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.1 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2'
```

## 1.27.4: Wed, 05 Feb 2025 21:03:42 GMT

Build logs:
- image tag `1.27.4`: [1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-05.2103.log](https://compilenix.org/static/build-logs/nginx/1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-05.2103.log)
- image tag `1.27.4-extras`: [1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-05.2104.log](https://compilenix.org/static/build-logs/nginx/1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-05.2104.log)
- image tag `1.27.4-slim`: [1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-05.2106.log](https://compilenix.org/static/build-logs/nginx/1.27.4-ecb809305e54ed15be9f620d56b19ff4e4be7db5-2025-02-05.2106.log)

### Changes
- Update nginx from 1.27.3 to 1.27.4
- update headers more module from 0.37 to 0.38

```
Changes with nginx 1.27.4                                        05 Feb 2025

    *) Security: insufficient check in virtual servers handling with TLSv1.3
       SNI allowed to reuse SSL sessions in a different virtual server, to
       bypass client SSL certificates verification (CVE-2025-23419).

    *) Feature: the "ssl_object_cache_inheritable", "ssl_certificate_cache",
       "proxy_ssl_certificate_cache", "grpc_ssl_certificate_cache", and
       "uwsgi_ssl_certificate_cache" directives.

    *) Feature: the "keepalive_min_timeout" directive.

    *) Workaround: "gzip filter failed to use preallocated memory" alerts
       appeared in logs when using zlib-ng.

    *) Bugfix: nginx could not build libatomic library using the library
       sources if the --with-libatomic=DIR option was used.

    *) Bugfix: QUIC connection might not be established when using 0-RTT;
       the bug had appeared in 1.27.1.

    *) Bugfix: nginx now ignores QUIC version negotiation packets from
       clients.

    *) Bugfix: nginx could not be built on Solaris 10 and earlier with the
       ngx_http_v3_module.

    *) Bugfixes in HTTP/3.
```

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.4 (ecb809305e54ed15be9f620d56b19ff4e4be7db5)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.38 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.9/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=ecb809305e54ed15be9f620d56b19ff4e4be7db5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.4 (ecb809305e54ed15be9f620d56b19ff4e4be7db5)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.38 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.9/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=ecb809305e54ed15be9f620d56b19ff4e4be7db5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Slim Image Variant
```
nginx version: nginx/1.27.4 (ecb809305e54ed15be9f620d56b19ff4e4be7db5)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.38 --build=ecb809305e54ed15be9f620d56b19ff4e4be7db5 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2'
```


## 1.27.3: Wed, 15 Jan 2025 19:11:27 GMT

Build logs:
- image tag `1.27.3`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2025-01-15.1940.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2025-01-15.1940.log)
- image tag `1.27.3-extras`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2025-01-15.1944.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2025-01-15.1944.log)
- image tag `1.27.3-slim`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2025-01-15.1947.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2025-01-15.1947.log)

### Changes
- Update NJS from 0.8.8 to 0.8.9

```
Changes with njs 0.8.9                                       14 Jan 2025

    nginx modules:

    *) Bugfix: removed extra VM creation per server.
       Previously, when js_import was declared in http or stream blocks,
       an extra copy of the VM instance was created for each server
       block. This was not needed and consumed a lot of memory for
       configurations with many server blocks.

      This issue was introduced in 9b674412 (0.8.6) and was partially
      fixed for location blocks only in 685b64f0 (0.8.7).

    Core:

    *) Feature: added fs module for QuickJS engine.
```

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.9/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.9/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Slim Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2'
```


## 1.27.3: Tue, 31 Dec 2024 01:25:20 GMT

Build logs:
- image tag `1.27.3`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-12-31.0125.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-12-31.0125.log)
- image tag `1.27.3-extras`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-12-31.0130.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-12-31.0130.log)
- image tag `1.27.3-slim`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-12-31.0134.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-12-31.0134.log)

### Changes
- Update NJS from 0.8.7 to 0.8.8
- Update Hurl from 5.0.1 to 6.0.0

```
Changes with njs 0.8.8                                       10 Dec 2024

    nginx modules:

    *) Feature: implemented shared dictionary for QuickJS engine.

    *) Improvement: js_preload_object is refactored.

    *) Bugfix: fixed limit rated output.

    *) Bugfix: optimized use of SSL contexts for
       js_fetch_trusted_certificate directive.

    Core:

    *) Feature: implemented process object for QuickJS engine.

    *) Feature: implemented process.kill() method.

    *) Bugfix: fixed tests with libxml2 2.13 and later.

    *) Bugfix: fixed promise resolving when Promise is inherited.

    *) Bugfix: fixed absolute scope in cloned VMs.
```

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.8/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.8/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Slim Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2'
```


## 1.27.3: Fri, 29 Nov 2024 21:45:18 GMT

Build logs:
- image tag `1.27.3`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-11-29.2145.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-11-29.2145.log)
- image tag `1.27.3-extras`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-11-29.2151.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-11-29.2151.log)
- image tag `1.27.3-slim`: [1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-11-29.2158.log](https://compilenix.org/static/build-logs/nginx/1.27.3-e7bd2557458c26839da89e694067017eeb214348-2024-11-29.2158.log)

### Changes
- Update Build Image from Fedora 40 to 41
- Update CFLAGS and LDFLAGS
- Update Nginx to version 1.27.3

```
Changes with nginx 1.27.3                                        26 Nov 2024

    *) Feature: the "server" directive in the "upstream" block supports the
       "resolve" parameter.

    *) Feature: the "resolver" and "resolver_timeout" directives in the
       "upstream" block.

    *) Feature: SmarterMail specific mode support for IMAP LOGIN with
       untagged CAPABILITY response in the mail proxy module.

    *) Change: now TLSv1 and TLSv1.1 protocols are disabled by default.

    *) Change: an IPv6 address in square brackets and no port can be
       specified in the "proxy_bind", "fastcgi_bind", "grpc_bind",
       "memcached_bind", "scgi_bind", and "uwsgi_bind" directives, and as
       client address in ngx_http_realip_module.

    *) Bugfix: in the ngx_http_mp4_module.
       Thanks to Nils Bars.

    *) Bugfix: the "so_keepalive" parameter of the "listen" directive might
       be handled incorrectly on DragonFly BSD.

    *) Bugfix: in the "proxy_store" directive.
```

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.7/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.7/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2 -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Slim Image Variant
```
nginx version: nginx/1.27.3 (e7bd2557458c26839da89e694067017eeb214348)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --build=e7bd2557458c26839da89e694067017eeb214348 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -mtls-dialect=gnu2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -DPURIFY -Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,-E -O2'
```

## 1.27.2: Thu, 31 Oct 2024 22:20:02 GMT

Build logs:
- image tag `1.27.2-slim`: [1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-31.2220.log](https://compilenix.org/static/build-logs/nginx/1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-31.2220.log)

### Changes
- Add slim image variant

### Nginx Build Info
#### Slim Image Variant
```
nginx version: nginx/1.27.2 (e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --build=e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.27.2: Mon, 28 Oct 2024 08:23:41 GMT

Build logs:
- image tag `1.27.2`: [1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-28.0823.log](https://compilenix.org/static/build-logs/nginx/1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-28.0823.log)
- image tag `1.27.2-extras`: [1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-28.0832.log](https://compilenix.org/static/build-logs/nginx/1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-28.0832.log)

### Changes
- Add support for NJS QuickJS runtime
- Update NJS module from 0.8.5 to 0.8.7
- Update OpenSSL from 3.3.2 to 3.4.0

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.2 (e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.7/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.2 (e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96)
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.7/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.4.0 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -I/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0' --with-openssl-opt='-O2 -flto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -L/usr/src/quickjs-6e2e68fd0896957f92eb6c242a2e048c1ef3cae0'
```

## 1.27.2: Tue, 24 Sep 2024 12:07:14 GMT

Build logs:
- image tag `1.27.2`: [1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-03.0010.log](https://compilenix.org/static/build-logs/nginx/1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-03.0010.log)
- image tag `1.27.2-extras`: [1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-03.0010.log](https://compilenix.org/static/build-logs/nginx/1.27.2-e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96-2024-10-03.0010.log)

### Changes
- Update nginx from 1.27.1 to 1.27.2

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.2 (e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96)
built with OpenSSL 3.3.2 3 Sep 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.3.2 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.2 (e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96)
built with OpenSSL 3.3.2 3 Sep 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e24f7ccc161f1a2a759eb27263ec9af4fc7c8e96 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.3.2 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.27.1: Tue, 24 Sep 2024 12:07:14 GMT

Build logs:
- image tag `1.27.1`: [1.27.1-e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928-2024-09-24.1222.log](https://compilenix.org/static/build-logs/nginx/1.27.1-e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928-2024-09-24.1222.log)
- image tag `1.27.1-extras`: [1.27.1-e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928-2024-09-24.1207.log](https://compilenix.org/static/build-logs/nginx/1.27.1-e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928-2024-09-24.1207.log)

### Changes
- Add entrypoint script `975-log-nginx-info.sh` to log the current nginx version & buildinfo on container startup
- Remove `dhparam.pem`
- Switch nginx source download from hg.nginx.org to github

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.1 (e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928)
built with OpenSSL 3.3.2 3 Sep 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.3.2 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.1 (e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928)
built with OpenSSL 3.3.2 3 Sep 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=e06bdbd4a20912c5223d7c6c6e2b3f0d6086c928 --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.3.2 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.27.1: Tue, 03 Sep 2024 19:12:04 GMT

Build logs:
- image tag `1.27.1`: [1.27.1-417b1045b18e-2024-09-03.1912.log](https://compilenix.org/static/build-logs/nginx/1.27.1-417b1045b18e-2024-09-03.1912.log)
- image tag `1.27.1-extras`: [1.27.1-417b1045b18e-2024-09-03.1912.log](https://compilenix.org/static/build-logs/nginx/1.27.1-417b1045b18e-2024-09-03.1912.log)

### Changes
- Update openssl from 3.3.1 to 3.3.2
- Update hurl from 4.3.0 to 5.0.1

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.1 (417b1045b18e)
built with OpenSSL 3.3.2 3 Sep 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=417b1045b18e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.3.2 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.1 (417b1045b18e)
built with OpenSSL 3.3.2 3 Sep 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=417b1045b18e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.3.2 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.27.1: Wed, 21 Aug 2024 16:31:43 GMT

Build logs:
- image tag `1.27.1`: [1.27.1-417b1045b18e-2024-08-21.1631.log](https://compilenix.org/static/build-logs/nginx/1.27.1-417b1045b18e-2024-08-21.1631.log)
- image tag `1.27.1-extras`: [1.27.1-417b1045b18e-2024-08-21.1637.log](https://compilenix.org/static/build-logs/nginx/1.27.1-417b1045b18e-2024-08-21.1637.log)

### Changes
- Update Nginx from 1.27.0 to 1.27.1
- Build with support for kTLS and enable by default

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.1 (417b1045b18e)
built with OpenSSL 3.3.1 4 Jun 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=417b1045b18e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.3.1 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.1 (417b1045b18e)
built with OpenSSL 3.3.1 4 Jun 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=417b1045b18e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.3.1 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer enable-ktls' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.27.0: Tue, 02 Jul 2024 16:24:00 GMT

Build logs:
- image tag `1.27.0`: [1.27.0-2166e329fb4e-2024-07-02.1619.log](https://compilenix.org/static/build-logs/nginx/1.27.0-2166e329fb4e-2024-07-02.1619.log)
- image tag `1.27.0-extras`: [1.27.0-2166e329fb4e-2024-07-02.1624.log](https://compilenix.org/static/build-logs/nginx/1.27.0-2166e329fb4e-2024-07-02.1624.log)

### Changes
- Update NJS from 0.8.4 to 0.8.5
- Automated testing using `hurl`
- Add a couple more tests
- Move docker files into dedicated folder
- add nginx zstd module

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.0 (2166e329fb4e)
built with OpenSSL 3.3.1 4 Jun 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=2166e329fb4e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.3.1 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.0 (2166e329fb4e)
built with OpenSSL 3.3.1 4 Jun 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.5/nginx --add-module=/usr/src/zstd-nginx-module-0.1.1 --build=2166e329fb4e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.3.1 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.27.0: Mon, 10 Jun 2024 05:54:18 GMT

Build logs:
- image tag `1.27.0`: [1.27.0-2166e329fb4e-2024-06-10.0554.log](https://compilenix.org/static/build-logs/nginx/1.27.0-2166e329fb4e-2024-06-10.0554.log)
- image tag `1.27.0-extras`: [1.27.0-2166e329fb4e-2024-06-10.0601.log](https://compilenix.org/static/build-logs/nginx/1.27.0-2166e329fb4e-2024-06-10.0601.log)

### Changes
- update nginx from 1.26.0 to 1.27.0
- update openssl from 3.3.0 to 3.3.1
- add `extras` image variant, see project readme for more details about that
- add nginx-rtmp-module
- enable `--with-compat` build flag
- enable `--with-http_v3_module`
- update `CFLAGS` for nginx and openssl
- add patch to disable openssl build tests, which drastically reduces build times
- add RPM package metadata to nginx binary
- add runtime ENV's:
  - NGINX_LOG_ERROR_LEVEL
  - NGINX_LOG_PATH_ACCESS
  - NGINX_LOG_PATH_ERROR
  - USER_NAME
  - GROUP_NAME
- update readme: `Testing` and `Table of Contents` sections
- add example configs for nginx perl module
- move build and helper shell scripts into dedicated `tools` folder
- migrate build script from `docker compose build` to `docker build`
- migrate njs source download from hg.nginx.org to github.com/nginx/njs
- fix some typos

### Nginx Build Info
#### Default Image Variant
```
nginx version: nginx/1.27.0 (2166e329fb4e)
built with OpenSSL 3.3.1 4 Jun 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.4/nginx --build=2166e329fb4e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-openssl=/usr/src/openssl-3.3.1 --with-pcre-jit --with-stream --with-stream_realip_module --with-stream_ssl_module --with-threads --without-http_empty_gif_module --without-http_geo_module --without-http_grpc_module --without-http_memcached_module --without-http_mirror_module --without-http_scgi_module --without-http_ssi_module --without-http_uwsgi_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --without-stream_geo_module --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

#### Extras Image Variant
```
nginx version: nginx/1.27.0 (2166e329fb4e)
built with OpenSSL 3.3.1 4 Jun 2024
TLS SNI support enabled
configure arguments: --add-module=/usr/src/headers-more-nginx-module-0.37 --add-module=/usr/src/nginx-rtmp-module-1.2.2 --add-module=/usr/src/ngx_brotli-a71f9312c2deb28875acc7bacfdd5695a111aa53 --add-module=/usr/src/njs-0.8.4/nginx --build=2166e329fb4e --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --group=nginx --http-client-body-temp-path=/var/cache/nginx/client_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --lock-path=/var/run/nginx/nginx.lock --modules-path=/usr/lib/nginx/modules --pid-path=/var/run/nginx/nginx.pid --prefix=/etc/nginx --sbin-path=/usr/bin/nginx --user=nginx --with-compat --with-debug --with-file-aio --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module --with-mail --with-mail_ssl_module --with-openssl=/usr/src/openssl-3.3.1 --with-pcre-jit --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-threads --with-cc-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-openssl-opt='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes'
```

## 1.26.0: Wed, 01 May 2024 22:32:46 GMT

Some config and entrypoint script changes.

### Changes
- set `HTTP_PROXY` to empty string to mitigate httpoxy
- disable `ssl_stapling` for default configs, since self-signed certs don't have OCSP
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
- update base image of build environment from Fedora 38 to 39
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
- don't build deps which can be linked from build-env os
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
- switch from `nginx` user to `root`, this can be overridden via `--user`
- change default exposed ports from `2080` & `2443` to `80` & `443`
- add `status.conf`, listening on localhost inside the container on port `81`, serving `stub_status` at `/`.
- update envsubst ob nginx configs on container start logic:
  - merge existing configs and those coming from a mapped volume on every container start.
    this allows changed env vars between starts to be re-applied and updates to mapped
    nginx config files to take effect.
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
  - add build start and end timestamps
  - add build log upload command and url
- remove some packages for the build env
  - pcre2-dev
  - zlib-dev
- add `BUILD_THROTTLE` build env
  Reduce build jobs by 4 if there are more then 7 cores else set jobs to half of core count. \
  this is useful if you don't want to congest the cpu of your building system
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
