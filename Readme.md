## What is this?
A smol (~ 6MB) [Nginx](https://nginx.org/en/CHANGES) container image with:
- all optional first-party modules built-in except the following:
  - http_perl: It's large and I don't need it
  - http_xslt: Can't be build into statically linked binary
  - http_image_filter: Can't be build into statically linked binary
- [Google's `brotli` compression](https://github.com/google/ngx_brotli)
- [Nginx njs module](https://hg.nginx.org/njs/)
- [OpenResty's headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module)
- [OpenSSL 3](https://github.com/openssl/openssl)
- [envsubst](https://git.compilenix.org/CompileNix/renvsubst) nginx config processing on container startup

Nginx binary is built from source (using alpine) into a `FROM scratch` container image.

Project Links:
- Git Repository: https://git.compilenix.org/CompileNix/docker-nginx
- Issues: https://git.compilenix.org/CompileNix/docker-nginx/-/issues
- Git Mirror 1: https://github.com/CompileNix/docker-nginx
- Git Mirror 2: https://gitlab.com/CompileNix/docker-nginx
- Container Image Registry: tbd.


## How is this container image that small?
- based on `FROM scratch`
- reducing container image layers to an absolute minimum by making usage of a multistaged `Dockerfile`
- large executable binaries are compressed using [upx](https://upx.github.io/)

## How to use this image
__*Note: (unencrypted) HTTP is discurraged by default!*__

Nginx is running as a non-root user by default:
- username: `nginx`
- user id: 1000
- groupname: `nginx`
- group id: 1000

HTTP: There is a default http server config section that responses to all plain HTTP requests with an 400 status code, listening on the container port `2080`.

HTTPS: This image already contains a self-signed ssl certificate and is used by a default http server config section listening on the container port `2443`.

Also have a look at the following sites to view some additonal examples and guidance on how to use nginx:
- https://nginx.org/en/docs/
- https://hub.docker.com/_/nginx

### Hosting some simple static content on port 443
```sh
docker run --name nginx -v "/some/content:/var/www/html:ro,z" -p 443:2443 compilenix/nginx
```

### Provide Your Own Nginx Configuration Files
You can either add or replace indivitual nginx config files to the [existing default configs](./config) by mapping them as a volume to `/config` into the container. For example would a mapped config file to `/config/nginx.conf` replace the default `nginx.conf` that is present in the container image.

For information on the syntax of nginx configuration files, see the [official documentation](http://nginx.org/en/docs/) and the [Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html#conf_structure).

#### Add A New HTTP Server Config Example
`sites/domain.tld.conf`:
```nginx
# vim: sw=2 et

server {
  listen 2080;
  server_name domain.tld www.domain.tld;
  location / {
    return 307 https://www.domain.tld$request_uri;
  }
}

server {
  listen 2443 ssl http2;
  server_name domain.tld www.domain.tld;
  root '/var/www/domain.tld';
  include 'cfg/header_referrer_policy.conf';
  ssl_certificate 'ssl/domain.tld/fullchain.pem';
  ssl_certificate_key 'ssl/domain.tld/privkey.pem';
  location / {
    allow all;
  }
}
```

Remember to place the required ssl certificates into `./ssl` and add the website content to `./webroot`.

```sh
docker run -v "$(pwd)/sites/domain.tld.conf:/config/sites/domain.tld.conf:ro,z" -v "$(pwd)/ssl:/config/ssl/domain.tld:ro,z" -v "$(pwd)/webroot:/var/www/domain.tld:ro,z" -p 80:2080 -p 443:2443 compilenix/nginx
```

### Using environment variables in nginx configuration
Environment variables can be used in any nginx config file, regardless if they are mapped as a volume, are part of the original container image or copied into custom container images which are based on this one.

Environment variable substitution / templating is performed by [900-envsubst-on-templates.sh](./src/docker-entrypoint.d/900-envsubst-on-templates.sh) on each container start.

__Mapped nginx config files directly to `/etc/nginx` (instead of `/config`) will be overritten / process by this process.__

Only config files whose name ends with a certian suffix will be processed.

This behavior can be changed via the `NGINX_ENVSUBST_TEMPLATE_SUFFIX` environment variable. The default value is defined as `.conf`.

Here is an example using `docker-compose.yml`:
```yml
# vim: sw=2 et

version: '2.4'

services:
  nginx:
    image: compilenix/nginx
    volumes:
      - "./domain.tld.conf:/config/sites/domain.tld.conf:ro,z"
      - "./ssl:/config/ssl/domain.tld:ro,z"
      - "./webroot:/var/www/html:ro,z"
    ports:
      - "80:2080"
      - "443:2443"
    environment:
      NGINX_HOST: "domain.tld"
      NGINX_HOST_CERT_PATH: "/etc/nginx/ssl/domain.tld"
      NGINX_HTTP_REDIRECT_LOCATION: "https://domain.tld$$request_uri"
```

Also have a look at the coresponding default nginx http server config: [default.conf](./config/sites/default.conf).

### Running nginx as root user
Create a custom container image based on this one.

```Dockerfile
FROM compilenix/nginx
USER root
```

### NJS
1. Override `njs.conf` via `/config/njs.conf`.
2. Map / copy njs code into container / image.

Example `njs.conf`:
```nginx
# vim: sw=2 et

js_path '/etc/nginx/njs/';
js_import http.js;
```

See also:
- [./njs/](./njs/)
- https://nginx.org/en/docs/njs/reference.html

Docker Compose Example:
```yml
# vim: sw=2 et

version: '2.4'

services:
  nginx:
    image: compilenix/nginx:${NGINX_VERSION}
    volumes:
      - "./njs/njs.conf:/config/njs.conf:ro,z"
      - "./njs/http.js:/config/njs/http.js:ro,z"
      - "./njs/localhost.conf:/config/sites/localhost.conf:ro,z"
    ports:
      - "0.0.0.0:42661:2080"
      - "0.0.0.0:42662:2443"
```

Testing:
```sh
curl -vk 'https://127.0.0.1:42662/njs'
# Hello world!
```

### Nginx config test
This can be acomplished by creating and starting a new container instance with all parameters, enviroment variables and mapped volumes as usual and then finally by overriding the start command.

Example using `docker run`:
```sh
source .env
docker run --rm -it -e TZ=$TZ -v "$(pwd)/webroot:/var/www/html:ro,z" -v "/some/nginx/config:/config:ro,z" compilenix/nginx /usr/bin/nginx -t
```

### Set a custom timezone
Simply set the enviroment variable `TZ` to the desired timezone.

Example:
```sh
TZ="Europe/Berlin"
```

Default value: `UTC`

### Set a custom amount of nginx worker processes
Set the enviroment variable `NGINX_WORKER_PROCESSES` to the desired amount.

Example:
```sh
NGINX_WORKER_PROCESSES=4
```

Default value: `2`

### Set a custom nginx http server response header value
Set the enviroment variable `NGINX_SERVER_HEADER` to the desired value.

Example:
```sh
NGINX_SERVER_HEADER="nginx"
```

Default value: (empty string)

### Change the DNS resolver nginx will use
Set the enviroment variable `DNS_RESOLVER` to the desired ip address.

This dns server wll be used by nginx to perform dns lookups for dns based upstream targets and OCSP stapling queries.

Example:
```sh
DNS_RESOLVER="8.8.8.8"
```

Default value: `1.1.1.1`

## Nginx Access Log Format
There are two built-in default log formats configured:
- `main` (default)
- `json`

Switch the default nginx log format to the json log format by setting the enviroment variable `NGINX_LOG_FORMAT_NAME` to `json`.

Example:
```sh
NGINX_LOG_FORMAT_NAME="json"
```

### main
```
log_format main '[$time_iso8601] status:$status domain:$host port:$server_port request_time:$request_time upstream_response_time:$upstream_response_time request_length:$request_length bytes_sent:$body_bytes_sent client_ip:$remote_addr request:"$request" referer:"$http_referer" user_agent:"$http_user_agent"';
```

#### Example "main" Log Message
```
[2022-09-27T20:50:58+02:00] status:200 domain:127.0.0.1 port:2443 request_time:0.000 upstream_response_time:- request_length:26 bytes_sent:25 client_ip:172.18.0.1 request:"GET /test.html HTTP/2.0" referer:"-" user_agent:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
```

#### GROK Pattern
`upstream_response_time` is omitted if the value is equal to `-`.

```
\[%{TIMESTAMP_ISO8601:time_local:date}\] status:%{INT:status:short} domain:%{HOSTNAME:domain:text} port:%{INT:port:integer} request_time:%{NUMBER:request_time:float} upstream_response_time:(-|%{NUMBER:upstream_response_time:float}) request_length:%{INT:request_length:integer} bytes_sent:%{INT:bytes_sent:integer} client_ip:%{IP:client_ip:ip} request:\"%{WORD:method:text} %{DATA:request:text} %{DATA:http_protocol_version:text}\" referer:\"%{DATA:referer:text}\" user_agent:\"%{DATA:user_agent:text}\"
```

#### GROK Pattern Example result
```json
{
  "bytes_sent": 25,
  "client_ip": "172.18.0.1",
  "domain": "127.0.0.1",
  "http_protocol_version": "HTTP/2.0",
  "method": "GET",
  "port": 2443,
  "referer": "-",
  "request": "/test.html",
  "request_length": 26,
  "request_time": 0,
  "status": 200,
  "time_local": "2022-09-27T20:50:58+02:00",
  "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
}
```

### json

This log format contains the following properties:
- body_bytes_sent
- brotli_ratio
- bytes_sent
- connection
- connection_requests
- connection_time
- content_length
- content_type
- document_root
- fastcgi_path_info
- fastcgi_script_name
- gzip_ratio
- host
- hostname
- http2
- http_host
- http_name
- http_referer
- http_user_agent
- http_x_forwarded_for
- https
- invalid_referer
- limit_conn_status
- limit_rate
- limit_req_status
- msec
- nginx_version
- pid
- pipe
- proxy_add_x_forwarded_for
- proxy_host
- proxy_port
- query_string
- realip_remote_addr
- realip_remote_port
- realpath_root
- remote_addr
- remote_port
- remote_user
- request
- request_body
- request_body_file
- request_completion
- request_filename
- request_id
- request_length
- request_method
- request_time
- request_uri
- scheme
- server_name
- server_port
- server_protocol
- ssl_alpn_protocol
- ssl_cipher
- ssl_ciphers
- ssl_client_escaped_cert
- ssl_client_fingerprint
- ssl_client_i_dn
- ssl_client_raw_cert
- ssl_client_s_dn
- ssl_client_serial
- ssl_client_v_end
- ssl_client_v_remain
- ssl_client_v_start
- ssl_client_verify
- ssl_curve
- ssl_curves
- ssl_early_data
- ssl_protocol
- ssl_server_name
- ssl_session_id
- ssl_session_reused
- status
- tcpinfo_rcv_space
- tcpinfo_rtt
- tcpinfo_rttvar
- tcpinfo_snd_cwnd
- time_iso8601
- time_local
- uid_got
- uid_reset
- uid_set
- upstream
- upstream_addr
- upstream_bytes_received
- upstream_bytes_sent
- upstream_cache_status
- upstream_connect_time
- upstream_header_time
- upstream_response_length
- upstream_response_time
- upstream_status
- uri

`binary_remote_addr` is intentionally not incuded beause the nginx built-in json escape system does weired stuff.

There are a couple more values you could add, see here [./src/etc/nginx/nginx.conf#L23](./src/etc/nginx/nginx.conf).

#### sent_http_name
Include a arbitrary response header field; the last part of a variable name is the field name converted to lower case with dashes replaced by underscores.

Example: `sent_http_x_powered_by`

#### upstream_http_name
Include a arbitrary server response header fields. For example, the "Server" response header field is available through the $upstream_http_server variable. The rules of converting header field names to variable names are the same as for the variables that start with the "$http_" prefix. Only the header fields from the response of the last server are saved.

Example: `sent_http_server`

#### cookie_name
Include a arbitrary Cookie with the specified name sent by this server in the "Set-Cookie" response header field (1.7.1).

Example: `cookie_sid`

#### upstream_cookie_name
Include a arbitrary Cookie with the specified name sent by the upstream server in the "Set-Cookie" response header field (1.7.1). Only the cookies from the response of the last server are saved.

Example: `upstream_cookie_sid`

#### http3
HTTP/3 isn't in mainline, yet.

Negotiated protocol identifier: "h3" for HTTP/3 over TLS or an empty string.

Example: `http3`

##### Available variables as part of the commercial subscription
This list might be incomplete.

###### session_log_binary_id
Current session ID in binary form (16 bytes).

Example: `session_log_binary_id`

###### session_log_id
Current session ID;

Example: `session_log_id`

###### upstream_queue_time
Keeps time the request spent in the upstream queue (1.13.9); the time is kept in seconds with millisecond resolution. Times of several responses are separated by commas and colons like addresses in the $upstream_addr variable.

Example: `upstream_queue_time`

#### Example "json" Log Message
```json
{
  "body_bytes_sent": "25",
  "brotli_ratio": "",
  "bytes_sent": "260",
  "connection": "3",
  "connection_requests": "3",
  "connection_time": "6.019",
  "content_length": "",
  "content_type": "",
  "document_root": "/var/www/html",
  "fastcgi_path_info": "",
  "fastcgi_script_name": "/test.html",
  "gzip_ratio": "",
  "host": "127.0.0.1",
  "hostname": "76656407ead8",
  "http_host": "127.0.0.1:42662",
  "http_name": "",
  "http_referer": "",
  "http_user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36",
  "http_x_forwarded_for": "",
  "http2": "h2",
  "https": "on",
  "invalid_referer": "",
  "limit_conn_status": "",
  "limit_rate": "0",
  "limit_req_status": "",
  "msec": "1664306240.619",
  "nginx_version": "1.23.1",
  "pid": "46",
  "pipe": ".",
  "proxy_add_x_forwarded_for": "172.18.0.1",
  "proxy_host": "",
  "proxy_port": "",
  "query_string": "",
  "realip_remote_addr": "172.18.0.1",
  "realip_remote_port": "41190",
  "realpath_root": "/var/www/html",
  "remote_addr": "172.18.0.1",
  "remote_port": "41190",
  "remote_user": "",
  "request": "GET /test.html HTTP/2.0",
  "request_body": "",
  "request_body_file": "",
  "request_completion": "OK",
  "request_filename": "/var/www/html/test.html",
  "request_id": "035c89c2558c2048bab75b655fecebd3",
  "request_length": "26",
  "request_method": "GET",
  "request_time": "0.000",
  "request_uri": "/test.html",
  "scheme": "https",
  "server_name": "localhost",
  "server_port": "2443",
  "server_protocol": "HTTP/2.0",
  "ssl_alpn_protocol": "h2",
  "ssl_cipher": "TLS_AES_256_GCM_SHA384",
  "ssl_ciphers": "0x2a2a:TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA:AES256-SHA",
  "ssl_client_escaped_cert": "",
  "ssl_client_fingerprint": "",
  "ssl_client_i_dn": "",
  "ssl_client_raw_cert": "",
  "ssl_client_s_dn": "",
  "ssl_client_serial": "",
  "ssl_client_v_end": "",
  "ssl_client_v_remain": "",
  "ssl_client_v_start": "",
  "ssl_client_verify": "NONE",
  "ssl_curve": "X25519",
  "ssl_curves": "0xfafa:X25519:prime256v1:secp384r1",
  "ssl_early_data": "",
  "ssl_protocol": "TLSv1.3",
  "ssl_server_name": "",
  "ssl_session_id": "0bd1ef5889b3b13db90eb56f616f3f450e17f651acb63bf3a75696fe945c5da8",
  "ssl_session_reused": ".",
  "status": "200",
  "tcpinfo_rcv_space": "14600",
  "tcpinfo_rtt": "7915",
  "tcpinfo_rttvar": "14084",
  "tcpinfo_snd_cwnd": "10",
  "time_iso8601": "2022-09-27T21:17:20+02:00",
  "time_local": "27/Sep/2022:21:17:20 +0200",
  "uid_got": "",
  "uid_reset": "",
  "uid_set": "",
  "upstream": "",
  "upstream_addr": "",
  "upstream_bytes_received": "",
  "upstream_bytes_sent": "",
  "upstream_cache_status": "",
  "upstream_connect_time": "",
  "upstream_header_time": "",
  "upstream_response_length": "",
  "upstream_response_time": "",
  "upstream_status": "",
  "uri": "/test.html"
}
```

## Build Requirements
- internet connection (HTTP/S)
- docker
- openssl
- (optional) docker-compose
- (optional) git

## Building
```sh
git clone https://git.compilenix.org/CompileNix/docker-nginx
cd docker-nginx
cp example.env .env
$EDITOR .env
./build.sh
```

## Run Nginx Using Docker-Compose
```sh
docker-compose up
```

## Test
Firefox 103 and up should work.

```sh
curl -vk 'http://127.0.0.1:42661/'
# Retry on https port
curl -vk 'https://127.0.0.1:42662/'
# It works!
# Using: HTTP/2.0 | TLSv1.3 | TLS_AES_256_GCM_SHA384
curl -vk 'https://127.0.0.1:42662/test.html'
# <h1>It works!</h1>
curl -vk 'https://127.0.0.1:42662/njs'
# Hello world!
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
│   └── stat -> busybox*
├── docker-entrypoint.d/
│   ├── 100-update-default-conf.sh*
│   ├── 800-replace-config-from-volume.sh*
│   └── 900-envsubst-on-templates.sh*
├── etc/
│   ├── nginx/
│   │   ├── cfg/
│   │   │   └── header_referrer_policy.conf
│   │   ├── nginx/
│   │   │   └── Readme.txt
│   │   ├── njs/
│   │   ├── sites/
│   │   │   ├── default.conf
│   │   │   ├── localhost.conf
│   │   │   └── zzz999_default_server_name.conf
│   │   ├── ssl/
│   │   │   ├── cert.pem
│   │   │   ├── dhparam.pem
│   │   │   ├── fullchain.pem
│   │   │   └── privkey.pem
│   │   ├── debug_connection.conf
│   │   ├── fastcgi.conf
│   │   ├── fastcgi_params
│   │   ├── koi-utf
│   │   ├── koi-win
│   │   ├── mime.types
│   │   ├── modules -> /usr/lib/nginx/modules
│   │   ├── nginx.conf
│   │   ├── njs.conf
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
│   │   ├── nginx*
│   │   └── posixtz*
│   ├── lib/
│   │   └── nginx/
│   │       └── modules/
│   ├── sbin/
│   │   ├── zdump*
│   │   └── zic*
│   └── share/
│       └── zoneinfo/
│           └── many files and stuff, Yep.
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

75 directories, 1248 files
```

