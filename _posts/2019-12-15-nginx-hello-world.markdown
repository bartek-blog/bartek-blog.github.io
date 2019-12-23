---
layout: post
comments: true
title:  "nginx http server hello world"
date:   2019-12-15 09:00:00 +0200
categories: nginx
---


[nginx](https://nginx.org/en/) (pronounced engine X) is an HTTP server and much more. Here we
show how to serve a simple static web page using it.

Here we are going to create custom docker with nginx installation.

## nginx.conf

Create `nginx.conf` file. For more information please look at
<https://nginx.org/en/docs/beginners_guide.html>.

``` shell
daemon off;

events {
    worker_connections 1024;
}

http {

    server {
        listen 80;
        
        location / {
            root /www/data;
        }
    }
}
```

## Simple index.html

Create `/www/data/index.html` file with, for example:

``` html
<!doctype html>
<html>
  <head>
    <title>Hello nginx</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <h1>
      Hello World!
    </h1>
  </body>
</html>
```

## Dockerfile

And finaly `Dockerfile`

``` dockerfile
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y nginx

ADD nginx.conf /etc/nginx/nginx.conf
ADD ./www /www

EXPOSE 80
CMD ["nginx"]
```

## Build it and run it

``` shell
docker build --tag=simpleubuntu . 
docker run --detach --publish=5001:80\
    --name=simpleubuntu simpleubuntu
```

Your page is available at
<http://localhost:5001/>

_Updated: 2019-12-23_
