---
layout: post
comments: true
title:  "Kubernetes hello world"
date:   2019-12-16 09:00:00 +0200
categories: kubernetes nginx
---

## Kubernetes

[Kubernetes](https://kubernetes.io/) is a system for deployment and management of containers.

<https://www.youtube.com/watch?v=HlAXp0-M6SY>

On mac one can install it with 

``` shell
brew install kubectl
brew install kubernetes-cli
```

## minikube

We are going to use [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/).
On mac you can install it with:

``` shell
brew install minikube
```

In order to start, run:
``` shell
minikube start
```

Check the status

``` shell
minikube status
```
or run a dashboard

``` sh
minikube dashboard
```

## Run simple docker container instance with kubectl

<https://kubernetes.io/docs/reference/kubectl/cheatsheet/>

``` shell
kubectl run nginx --image=nginx --generator=run-pod/v1
kubectl get pods
```

More about pods <https://kubernetes.io/docs/concepts/workloads/pods/pod/>.

### Create service

``` shell
kubectl expose deployment nginx --port 80 --type LoadBalancer
kubectl get services
```

### Run it 

``` sh
minikube service nginx
```

### Running custom docker container

If you have crated a docker container and push it docker hub you can run then in k8s,
see [Docker: Hello World]({% post_url 2019-04-23-docker-hello-world %}) for instructions.

Create a file `app.yaml`

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flaskhelloworld-deployment
spec:
  selector:
    matchLabels:
      app: flaskhelloworld
  replicas: 1
  template:
    metadata:
      labels:
        app: flaskhelloworld
    spec:
      containers:
      - name: flaskhelloworld
        image: barteks/flaskhelloworld:1.0.0
        ports:
        - containerPort: 80
```

``` shell
kubectl apply -f app.yaml
kubectl expose deployment flaskhelloworld --port 80 --type LoadBalancer
minikube service flaskhelloworld
```

If your file is in github you can try:

``` sh
kubectl apply -f https://raw.githubusercontent.com/sbartek/sample_flask_app/master/flaskhelloworld/flaskhelloworld.yaml
kubectl apply -f https://raw.githubusercontent.com/sbartek/sample_flask_app/master/flaskhelloworld/flaskhelloworld-service.yaml
```


## Useful commands

### Login to shell

``` sh
kubectl exec -it <pod_name> -- sh
```

### What is running 

You can see what is installed on you k8s custer by:

``` sh
kubectl get all
```

### Clean up


You can delete service/deployment etc by
``` sh
kubectl delete service nginx
kubectl delete deployment nginx
```

Then you can stop and delete minikube by:

``` sh
minikube stop
minikube delete
```

_Updated: 2019-12-21_
