# docker-nginx<!-- omit from toc -->
## What is this?<!-- omit from toc -->
A smol [Nginx](https://nginx.org/en/CHANGES) container image, plus:
- [Google's `brotli` compression](https://github.com/google/ngx_brotli)
- [Nginx njs module](https://hg.nginx.org/njs/)
- [OpenResty's headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module)
- [OpenSSL 3](https://github.com/openssl/openssl)
- `sh` & `envsubst` entrypoints for nginx config processing on container startup

The nginx binary is built from source (using fedora) into a `FROM scratch` container image.

## Supported Container Image Tags<!-- omit from toc -->
- `1.25.3`, `1.25`, `1`, `latest`

## Project Links<!-- omit from toc -->
- [Container Image Registry](https://hub.docker.com/r/compilenix/nginx)
- [Git Repository](https://git.compilenix.org/CompileNix/docker-nginx)
- [Project issues](https://git.compilenix.org/CompileNix/docker-nginx/-/issues)
- [Git Mirror 1](https://github.com/CompileNix/docker-nginx)
- [Git Mirror 2](https://gitlab.com/CompileNix/docker-nginx)

## Table of Contents<!-- omit from toc -->
- [How to use this image](#how-to-use-this-image)
  - [Hosting some simple static content on port 80 and 443](#hosting-some-simple-static-content-on-port-80-and-443)
  - [Provide Your Own Nginx Configuration](#provide-your-own-nginx-configuration)
    - [Add A New HTTP Server Config Example](#add-a-new-http-server-config-example)
  - [Using environment variables in nginx configuration](#using-environment-variables-in-nginx-configuration)
  - [Running nginx using different UID and GID](#running-nginx-using-different-uid-and-gid)
  - [NJS](#njs)
  - [Nginx config test](#nginx-config-test)
  - [Set a custom timezone](#set-a-custom-timezone)
  - [Set a custom amount of nginx worker processes](#set-a-custom-amount-of-nginx-worker-processes)
  - [Set a custom nginx http server response header value](#set-a-custom-nginx-http-server-response-header-value)
  - [Change the DNS resolver nginx will use](#change-the-dns-resolver-nginx-will-use)
- [Nginx Access Log Format](#nginx-access-log-format)
  - [main](#main)
    - [Example "main" Log Message](#example-main-log-message)
    - [GROK Pattern](#grok-pattern)
    - [GROK Pattern Example result](#grok-pattern-example-result)
  - [JSON](#json)
    - [sent\_http\_name](#sent_http_name)
    - [upstream\_http\_name](#upstream_http_name)
    - [cookie\_name](#cookie_name)
    - [upstream\_cookie\_name](#upstream_cookie_name)
    - [http3](#http3)
      - [Available variables as part of the commercial subscription](#available-variables-as-part-of-the-commercial-subscription)
        - [session\_log\_binary\_id](#session_log_binary_id)
        - [session\_log\_id](#session_log_id)
        - [upstream\_queue\_time](#upstream_queue_time)
    - [Example JSON Log Message](#example-json-log-message)
- [Building](#building)
  - [Build Requirements](#build-requirements)
  - [Build Steps](#build-steps)
- [Testing](#testing)
- [Making Updates \& Changes](#making-updates--changes)
  - [Publish Checklist](#publish-checklist)

## How to use this image
Also have a look at the following sites to view some additonal examples and guidance on how to use nginx:
- https://nginx.org/en/docs/
- https://hub.docker.com/_/nginx

### Hosting some simple static content on port 80 and 443
```sh
docker run -v "/some/content:/var/www/html:ro,z" -p 80:80 -p 443:443 compilenix/nginx
```

### Provide Your Own Nginx Configuration
You can either add or replace individual nginx config files to the [existing default configs](./config) by mapping them as a volume to `/config` into the container. For example would a mapped config file to `/config/nginx.conf` replace the default `nginx.conf` that is present in the container image.

For information on the syntax of nginx configuration files, see the [official documentation](http://nginx.org/en/docs/) and the [Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html#conf_structure).

#### Add A New HTTP Server Config Example
`sites/domain.tld.conf`:
```nginx
# vim: sw=2 et filetype=nginx

server {
  listen 80;
  server_name domain.tld www.domain.tld;

  location / {
    return 307 https://www.domain.tld$request_uri;
  }
}

server {
  listen 443 ssl;
  http2 on;
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
docker run \
  -v "$PWD/sites/domain.tld.conf:/config/sites/domain.tld.conf:ro,z" \
  -v "$PWD/ssl:/config/ssl/domain.tld:ro,z" \
  -v "$PWD/webroot:/var/www/domain.tld:ro,z" \
  -p 80:80 \
  -p 443:443 \
  compilenix/nginx
```

### Using environment variables in nginx configuration
Environment variables can be used in any nginx config file, regardless if they are mapped as a volume, are part of the original container image or copied into custom container images which are based on this one.

Environment variable substitution / templating is performed by [900-envsubst-on-templates.sh](./src/docker-entrypoint.d/900-envsubst-on-templates.sh) on container start.

__Mapped nginx config files directly to `/etc/nginx` (instead of `/config`) will be overritten / process by this substitution process!__

Only config files whose name ends with a certian suffix will be processed.

This behavior can be changed via the `NGINX_ENVSUBST_TEMPLATE_SUFFIX` environment variable. The default value is defined as "`.conf`".

Here is an example using `docker-compose.yml`:
```yaml
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
      - "80:80"
      - "443:443"
    environment:
      NGINX_HOST: "domain.tld"
      NGINX_HOST_CERT_PATH: "/etc/nginx/ssl/domain.tld"
      NGINX_HTTP_REDIRECT_LOCATION: "https://domain.tld$$request_uri"
```

Also have a look at the coresponding default nginx http server config: [default.conf](./config/sites/default.conf).

### Running nginx using different UID and GID
Set the `USER_ID` and `GROUP_ID` env variables to the desired uid and gid. The entrypoint [`110-add-user.sh`](./src/docker-entrypoint.d/110-add-user.sh) will create a corresponding nginx user and group at container start.

Defaults are:
```sh
USER_ID="101"
GROUP_ID="101"
```

### NJS
1. Override `njs.conf` via `/config/njs.conf`.
2. Map / copy njs code into container or image.

Example `njs.conf`:
```nginx
# vim: sw=2 et filetype=nginx

js_path '/etc/nginx/njs/';
js_import http.js;
```

See also:
- [./njs/](./njs/)
- https://nginx.org/en/docs/njs/reference.html

Docker Compose Example:
```yaml
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
      - "0.0.0.0:42661:80"
      - "0.0.0.0:42663:443"
```

Testing:
```sh
curl -vk 'https://127.0.0.1:42663/njs'
# Hello world from nginx njs!
```

### Nginx config test
This can be acomplished by creating and starting a new container with the same parameters, enviroment variables and mapped volumes as the currently running container and by overriding the start command.

Example using `docker run`:
```sh
source .env
docker run \
  -it \
  --rm \
  --env-file .env \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  -v "/some/nginx/config:/config:ro,z" \
  compilenix/nginx \
    /usr/bin/nginx -t
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

Default value: `auto`

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
There are two built-in log formats configured:
- `main`
- `json`

Switch the default nginx log format to the json log format by setting the enviroment variable `NGINX_LOG_FORMAT_NAME`.

Example:
```sh
NGINX_LOG_FORMAT_NAME="json"
```

Default value: `main`

### main
```
log_format main '[$time_iso8601] status:$status domain:$host port:$server_port request_time:$request_time upstream_response_time:$upstream_response_time request_length:$request_length bytes_sent:$body_bytes_sent client_ip:$remote_addr request:"$request" referer:"$http_referer" user_agent:"$http_user_agent"';
```

#### Example "main" Log Message
```
[2022-09-27T20:50:58+02:00] status:200 domain:127.0.0.1 port:443 request_time:0.000 upstream_response_time:- request_length:26 bytes_sent:25 client_ip:172.18.0.1 request:"GET /test.html HTTP/2.0" referer:"-" user_agent:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
```

#### GROK Pattern
`upstream_response_time`, `user_agent` and `referer` are omitted if the value is equal to "`-`".

```grok
\[%{TIMESTAMP_ISO8601:time_local:date}\] status:%{INT:status:short} domain:%{HOSTNAME:domain:text} port:%{INT:port:integer} request_time:%{NUMBER:request_time:float} upstream_response_time:(-|%{NUMBER:upstream_response_time:float}) request_length:%{INT:request_length:integer} bytes_sent:%{INT:bytes_sent:integer} client_ip:%{IP:client_ip:ip} request:\"%{WORD:method:text} %{DATA:request:text} %{DATA:http_protocol_version:text}\" referer:\"(-|%{DATA:referer:text})\" user_agent:\"(-|%{DATA:user_agent:text})\"
```

#### GROK Pattern Example result
```json
{
  "bytes_sent": 20,
  "client_ip": "172.17.0.1",
  "domain": "127.0.0.1",
  "http_protocol_version": "HTTP/2.0",
  "method": "GET",
  "port": 443,
  "request": "/test.html",
  "request_length": 39,
  "request_time": 0,
  "status": 200,
  "time_local": "2023-04-05T11:53:34+02:00",
  "user_agent": "curl/7.85.0"
}
```

### JSON

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

#### Example JSON Log Message
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
  "nginx_version": "1.25.1",
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

## Building
### Build Requirements
- docker
- docker-compose
- git
- internet connection (HTTP/S)
- openssl

### Build Steps
```sh
git clone https://git.compilenix.org/CompileNix/docker-nginx
cd docker-nginx
cp example.env .env
$EDITOR .env
./build.sh
```

## Testing
```sh
source .env

# Generate random port numbers to use for testing and echo them for easy copy & paste to stdout
export HTTP_PORT="$(shuf -i 32768-49152 -n 1)"; echo "export HTTP_PORT=\"$HTTP_PORT\""
export HTTP_STUB_PORT="$(shuf -i 32768-49152 -n 1)"; echo "export HTTP_STUB_PORT=\"$HTTP_STUB_PORT\""
export HTTPS_PORT="$(shuf -i 32768-49152 -n 1)"; echo "export HTTPS_PORT=\"$HTTPS_PORT\""

# start container
docker run --rm -it \
  --env-file ".env" \
  -p "127.0.0.1:$HTTP_PORT:80" \
  -p "127.0.0.1:$HTTP_STUB_PORT:81" \
  -p "127.0.0.1:$HTTPS_PORT:443" \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  -v "$PWD/njs/njs.conf:/config/njs.conf:ro,z" \
  -v "$PWD/njs/http.js:/config/njs/http.js:ro,z" \
  -v "$PWD/njs/localhost.conf:/config/sites/localhost.conf:ro,z" \
  "compilenix/nginx:$NGINX_VERSION"

# Test commands from new shell on the same host
curl -v "http://127.0.0.1:$HTTP_PORT/"
# Retry on https port
curl -vk "https://127.0.0.1:$HTTPS_PORT/"
# It works!
# Using: HTTP/2.0 | TLSv1.3 | TLS_AES_256_GCM_SHA384
curl -vk "https://127.0.0.1:$HTTPS_PORT/test.html"
# <h1>It works!</h1>
curl -vk "https://127.0.0.1:$HTTPS_PORT/njs/date"
# Wed Mar 15 2023 16:16:52 GMT+0000
curl -vk "https://127.0.0.1:$HTTPS_PORT/njs/hello"
# Hello world from nginx njs!
curl -vk "https://127.0.0.1:$HTTPS_PORT/njs/version"
# njs v0.7.11
curl -vk "https://127.0.0.1:$HTTPS_PORT/health"
# healthy
curl -v "http://127.0.0.1:$HTTP_STUB_PORT/"
# Active connections: 1 
# server accepts handled requests
#  8 8 8 
# Reading: 0 Writing: 1 Waiting: 0 

# start container
docker run --rm -it \
  --env-file ".env" \
  -p "127.0.0.1:$HTTP_PORT:80" \
  -p "127.0.0.1:$HTTP_STUB_PORT:81" \
  -p "127.0.0.1:$HTTPS_PORT:443" \
  -v "$PWD/webroot:/var/www/html:ro,z" \
  "compilenix/nginx:$NGINX_VERSION"

# Test commands from new shell on the same host
curl -v "http://127.0.0.1:$HTTP_PORT/test.html"
# <h1>It works!</h1>
curl -vk "https://127.0.0.1:$HTTPS_PORT/test.html"
# <h1>It works!</h1>
```

## Making Updates & Changes
If you want to change any versions used to build the container image take a look into `.env`.

### Publish Checklist
- [ ] Update or create `.env`:
  - ```sh
    cp example.env .env
    ```
- [ ] Run `./clean.sh && ./build-with-logs.sh`
- [ ] [Testing](#testing)
- [ ] Upload build logs (printed out at the end of previous step)
- [ ] Update [Supported Container Image Tags](#supported-container-image-tags)
- [ ] Update `CHANGELOG.md`
- [ ] Create / Update Docker Image Tags
  - ```sh
    docker image tag compilenix/nginx:1.25.3 compilenix/nginx:latest
    docker image tag compilenix/nginx:1.25.3 compilenix/nginx:1.25
    docker image tag compilenix/nginx:1.25.3 compilenix/nginx:1
    # inspect image tags
    docker image ls compilenix/nginx
    ```
- [ ] Run `./push-image-tags.sh`
- [ ] Update Supported Container Image Tags on [hub.docker.com](https://hub.docker.com/repository/docker/compilenix/nginx/general)

