---
layout: post
comments: true
title:  "Node.js Hello World with Docker
date:   2019-12-25 09:00:00 +0200
categories: javascript node docker
---


[Node.js](https://nodejs.org/) is JavaScript runtime environment that executes JavaScript code
outside of a browser.

## Install on Mac

This step is not needed if you are planing to use docker.

Install with brew using
``` shell
brew install node
```

After that check if it works with:
``` shell
node -v
```

## Hello world app

Create `app.js` with the following code

``` javascript
const http = require('http');
const os = require('os');

const port = 3000;

var handler = function(request, response) {
    console.log(
        "Received request from " + request.connection.remoteAddress
    ); 
    response.statusCode = 200;
    response.setHeader('Content-Type', 'text/plain');
    text = "Hello World\n" +
        "from " + os.hostname() + "\n";
    response.end(text);
};

const server = http.createServer(handler);
server.listen(port);
```

Run it with `node app.js`. Go to <http://localhost:3000> or run
``` shell
curl http://localhost:3000
```

## Build with docker

Create `Dockerfile`:

``` dockerfile
FROM node:13
ADD app.js /app.js
ENTRYPOINT ["node", "app.js"]
```

Then build it with

``` shell
docker build -t barteks/simple_node .
```

Change `barteks` to your Docker Hub username or simply remove `barteks/` if you are not planing to
push the image to Docker Hub.

Then run docker with

``` shell
docker run -d -p 3000:3000 --name=simple_node barteks/simple_node
```

Check
``` shell
curl http://localhost:3000
```

### Push to docker hub

You can push built docker to Docker Hub by:

``` shell
docker push barteks/simple_node
```

## Run with k8s

See [Kubernetes hello world]({% post_url 2019-12-16-k8s-hello-world %}) for details how to install
minikube.

Running docker on kubernetes cluster as simple as creating pod by:

``` shell
kubectl run simplenode --image=barteks/simple_node\
    --port=3000 --generator=run-pod/v1
```

Then you need to create service in order to expose your pod:

``` shell
kubectl expose pod simplenode --type=LoadBalancer --name simplenode-http
```

In minikube you have get access to local port by running

``` shell
minikube service simplenode-http
```

## Links
* https://nodejs.org/en/docs/guides/getting-started-guide/

_Updated: 2019-12-25_
