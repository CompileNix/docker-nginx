GET https://127.0.0.1:{{HTTPS_PORT}}/njs/version
HTTP/2 200
Content-Type: text/plain
Alt-Svc: h3=":443"; ma=86400
[Asserts]
body == "njs v{{NJS_VERSION}}\n"
