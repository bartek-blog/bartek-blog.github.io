---
layout: post
comments: true
title:  "Kubernetes hello world"
date:   2019-12-16 09:00:00 +0200
categories: kubernetes nginx node javascript
---

## Kubernetes

[Kubernetes](https://kubernetes.io/) is a system for deployment and management of containers.

<https://www.youtube.com/watch?v=HlAXp0-M6SY>

On mac one can install it with 

``` shell
brew install kubectl
brew install kubernetes-cli
```

It is recommended to add aliases to shell. For example, for `zshell` with `ohmyzsh` you can do this
by adding `kubectl` to `plugins` in `.zshrc`:

``` sh
plugins=(... kubectl)
```
 Then you can simply write `k` instead of `kubectl` in what follows. See 
 <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl> 
 for more aliases.

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
kubectl get pods -o wide
kubectl describe pods nginx
```

More about pods <https://kubernetes.io/docs/concepts/workloads/pods/pod/>.

### Create service

You can get to pod by forwarding the port by

``` sh
kubectl port-forward nginx 8081:80
```

However, the best way is to create a service:
``` shell
kubectl expose pod nginx --port 80 --type LoadBalancer
kubectl get services
```

### Run it 

``` sh
minikube service nginx
```

### Running custom docker container

If you have crated a docker container and push it docker hub you can run then in k8s,
see [Docker: Hello World]({% post_url 2019-04-23-docker-hello-world %}) for instructions.

You can run it in the same imperative way as before:
``` shell
kubectl run flaskhelloworld --image=barteks/flaskhelloworld\
    --generator=run-pod/v1
kubectl expose pod flaskhelloworld --port 80 --type LoadBalancer
```

There is also declarative way to do this. First create a file 
`flaskhelloworld-pod.yaml`

``` yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: flaskhelloworld
  name: flaskhelloworld
spec:
  containers:
  - name: flaskhelloworld
    image: barteks/flaskhelloworld:latest
    ports:
    - containerPort: 80
```
Run `kubectl explain pod` for more info.


Now you can create pod with:

``` sh
kubectl apply -f flaskhelloworld-pod.yaml
```

Then for service, create file `flaskhelloworld-svc.yaml`:

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: flaskhelloworld
  namespace: default
spec:
  ports:
  - nodePort: 31182
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: flaskhelloworld
  type: LoadBalancer
```

And for creating service you can run:

``` sh
kubectl apply -f flaskhelloworld-svc.yaml
```

Now run service and open port for minikube:


``` shell
minikube service flaskhelloworld
```

If your file is in github you can try:

``` sh
kubectl apply -f https://raw.githubusercontent.com/sbartek/sample_flask_app/master/flaskhelloworld/flaskhelloworld-pod.yaml
kubectl apply -f https://raw.githubusercontent.com/sbartek/sample_flask_app/master/flaskhelloworld/flaskhelloworld-svc.yaml
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

Links

* More on pods <https://kubernetes.io/docs/concepts/workloads/pods/pod/>

_Updated: 2019-12-21_xs
