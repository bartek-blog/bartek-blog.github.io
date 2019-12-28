---
layout: post
comments: true
title:  "Kubernetes: Flask with redis"
date:   2019-12-28 09:00:00 +0200
categories: kubernetes flask redis
---


# Flask with redis

In [Docker Compose: Flask with Redis]({% post_url 2019-12-21-docker-compose %}) we have created two
dockers that can communicate with each others using `docker-compose`. The same can be easily
achieved with kubernetes. We will do this using declarative style with `yaml` files. Please refer to
[Kubernetes: Namespace and Replication Controller]({% post url 2019-12-27-k8s-namespace-rc %}).

We have also modified the code of the app. You can find everything in 
<https://github.com/sbartek/sample_flask_with_redis>.

## Namespace

Let's start with declaring namespace. Let's create `app.yaml`.

``` yaml
apiVersion: v1
kind: Namespace
metadata:
  name: flaskapp-dev
```

## Flask app

Then let's declare how to create docker with flask using `ReplicaSet` which is very similar to
`ReplicationController` described in 
[Kubernetes: Namespace and Replication Controller]({% post url 2019-12-27-k8s-namespace-rc %}).
The only difference in definition of `selector`. This is done in the following `flaskapp-rs.yaml`
file:

``` yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: flaskapp
  namespace: flaskapp-dev
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask
  template:
    metadata:
      labels:
        app: flask
    spec:
      containers:
      - name: flaskapp
        image: barteks/flaskappforredis:latest
        ports:
        - name: http
          containerPort: 80
```

## Flask app service (load balancer)

Next we define a service for serving the flask app. This is done in
`flaskapp-svc.yaml`:

``` yaml
apiVersion: v1	
kind: Service
metadata:
  labels:
    app: flask
  name: flaskapp
  namespace: flaskapp-dev
spec:
  ports:
  - name: http
    port: 8080
    targetPort: http
  selector:
    app: flask
  type: LoadBalancer
```

## Redis

`redis-rs.yaml`:

``` yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: redis
  namespace: flaskapp-dev
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: barteks/redis:latest
        ports:
        - name: redisport
          containerPort: 6379
```

## Service for redis

`redis-svc.yaml`

``` yaml
apiVersion: v1
kind: Service
metadata:
  labels:	
    app: redis
  name: redis
  namespace: flaskapp-dev
spec:
  ports:
  - name: redis
    port: 6379
    targetPort: redisport
  selector:	
    app: redis
```

## Apply it

``` shell
kubectl apply -f flaskappwithredis/app-ns.yaml
kubectl apply -f flaskappwithredis/flaskapp-svc.yaml
kubectl apply -f flaskappwithredis/flaskapp-rs.yaml
kubectl apply -f flaskappwithredis/redis-svc.yaml
kubectl apply -f flaskappwithredis/redis-rs.yaml
```


_Updated: 2019-12-28_

