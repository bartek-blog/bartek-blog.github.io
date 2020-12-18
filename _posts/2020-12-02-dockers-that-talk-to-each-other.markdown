---
layout: post
comments: true
title:  "Dockers that talk to each other"
date:   2020-12-02 23:00:00 +0200
categories: docker 
---

## Bridge networks

### Define bridge

``` shell
docker network create bartek-net
```

### network flag

When creating a new container, you can specify one or more --network flags:

``` shell
docker run --detach --publish=8080:80 --name=webserver --network bartek-net nginx
```

You can test it with:

``` shell
curl http://0.0.0.0:8080
```

Another docker with the same network flag talk to this docker by resolving name  `webserver`:

``` shell
docker run --network bartek-net byrnedo/alpine-curl http://webserver:80
```

_Updated: 2020-12-02_
