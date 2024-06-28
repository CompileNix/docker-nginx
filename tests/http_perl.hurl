GET http://127.0.0.1:{{HTTP_PORT}}/
HTTP/1.1 200
Content-Type: text/html
```
hello!
<br/>/ exists!
```

GET http://127.0.0.1:{{HTTP_PORT}}/test.html
HTTP/1.1 200
Content-Type: text/html
```
hello!
<br/>/test.html exists!
```

GET http://127.0.0.1:{{HTTP_PORT}}/fooo_bar.html
HTTP/1.1 200
Content-Type: text/html
```
hello!
<br/>
```
