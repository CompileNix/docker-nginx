GET http://127.0.0.1:{{HTTP_PORT}}/does_not_exist.txt
HTTP/1.1 404
Content-Type: text/html
Content-Length: 177
```
<html>
<head>
<title>404 Not Found</title>
<meta name="color-scheme" content="light dark">
</head>
<body>
<center><h1>404 Not Found</h1></center>
<hr>
</body>
</html>
```
