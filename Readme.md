## What is this?
A very smol (~ 4MB) [Nginx](https://nginx.org/en/CHANGES) container image with:
- all optional first-party modules built-in except the following:
  - http_perl: It's large and I don't need it
  - http_xslt: Can't be build into statically linked binary
  - http_image_filter: Can't be build into statically linked binary
- [OpenSSL 3](https://github.com/openssl/openssl)
- [Google's `brotli` compression](https://github.com/google/ngx_brotli)
- [Nginx njs module](https://hg.nginx.org/njs/)
- [OpenResty's headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module)
- [envsubst](https://git.compilenix.org/CompileNix/renvsubst) nginx config processing on container startup

Nginx binary is built from source (using alpine) into a `FROM scratch` container image. It's **not production-ready**!

## How is this container image that small?
- based on `FROM scratch`
- reducing container image layers to an absolute minimum by efficent use of a multistaged `Dockerfile`
- nginx (and all it's modules) are build into a single static binary
- all executable binaries are compressed using [upx](https://upx.github.io/)

## Requirements
- internet connection (HTTP/S)
- docker
- openssl
- (optional) docker-compose
- (optional) git

## Clone
```sh
git clone https://git.compilenix.org/compilenix/docker-nginx
cd docker-nginx
```

## Generate SSL Keys
This may take a while.

```sh
mkdir config/ssl
cd config/ssl
openssl dhparam -out dhparam.pem 2048
openssl genrsa -out privkey.pem 2048
openssl req -key privkey.pem -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nbasicConstraints=CA:FALSE\nkeyUsage=nonRepudiation,digitalSignature,keyEncipherment\nsubjectAltName=DNS:localhost, DNS:localhost.localdomain, IP:127.0.0.1, IP:::1")) -sha256 -subj "/C=/ST=/L=/O=/OU=/CN=localhost" -extensions SAN -nodes -x509 -days 3650 -out cert_temp.pem
openssl x509 -in cert_temp.pem -text >cert.pem
rm cert_temp.pem
cd ../..
```

## Build
```sh
docker-compose build
```

## Run Nginx Using Docker-Compose
```sh
docker-compose up
```

## Run Nginx Using Docker
```sh
source .env
docker run --rm -it -v $(pwd)/webroot:/var/www/html:ro,z -p 0.0.0.0:8888:2080 -p 0.0.0.0:8889:2443 -e DNS_RESOLVER=$DNS_RESOLVER compilenix/nginx:${NGINX_VERSION}
```

## Test
Firefox 103 and up should work.

```sh
curl -vk 'https://127.0.0.1:8889/'
curl -vk 'https://127.0.0.1:8889/test.html'
```

## Making Updates & Changes
If you want to change any versions used to build the container image take a look into `.env`.

### Container Image Structure
```
./
├── bin/
│   ├── basename -> busybox*
│   ├── busybox*
│   ├── cat -> busybox*
│   ├── cp -> busybox*
│   ├── cut -> busybox*
│   ├── dirname -> busybox*
│   ├── echo -> busybox*
│   ├── env -> busybox*
│   ├── find -> busybox*
│   ├── ls -> busybox*
│   ├── mkdir -> busybox*
│   ├── printf -> busybox*
│   ├── rm -> busybox*
│   ├── sh -> busybox*
│   ├── sort -> busybox*
│   └── tail -> busybox*
├── docker-entrypoint.d/
│   └── envsubst-on-templates.sh*
├── etc/
│   ├── nginx/
│   │   ├── cfg/
│   │   │   └── header_referrer_policy.conf
│   │   ├── conf.d/
│   │   ├── nginx/
│   │   │   └── Readme.txt
│   │   ├── sites/
│   │   │   ├── 000_default.conf
│   │   │   └── localhost.conf
│   │   ├── ssl/
│   │   │   ├── cert.pem
│   │   │   ├── dhparam.pem
│   │   │   └── privkey.pem
│   │   ├── debug_connection.conf
│   │   ├── fastcgi.conf
│   │   ├── fastcgi_params
│   │   ├── koi-utf
│   │   ├── koi-win
│   │   ├── mime.types
│   │   ├── modules -> /usr/lib/nginx/modules
│   │   ├── nginx.conf
│   │   ├── scgi_params
│   │   ├── uwsgi_params
│   │   └── win-utf
│   ├── ssl/
│   │   └── certs/
│   │       └── ca-certificates.crt
│   ├── group
│   ├── passwd
│   └── shadow
├── tmp/
├── usr/
│   ├── bin/
│   │   ├── envsubst*
│   │   └── nginx*
│   └── lib/
│       └── nginx/
│           └── modules/
├── var/
│   ├── cache/
│   │   └── nginx/
│   │       ├── client_temp/
│   │       ├── fastcgi_temp/
│   │       ├── proxy_temp/
│   │       ├── scgi_temp/
│   │       └── uwsgi_temp/
│   ├── log/
│   │   └── nginx/
│   │       ├── access.log -> /dev/stdout|
│   │       └── error.log -> /dev/stdout|
│   ├── run/
│   │   └── nginx/
│   └── www/
│       └── html/
└── docker-entrypoint.sh*

31 directories, 44 files
```

