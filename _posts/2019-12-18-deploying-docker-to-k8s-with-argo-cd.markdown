---
layout: post
comments: true
title:  "Deploying docker to kubernetes with Argo CD"
date:   2019-12-18 09:00:00 +0200
categories: argo docker kubernetes
---

## Argo CD

[Argo CD](https://argoproj.github.io/argo-cd/) is a continuous delivery tool for Kubernetes.


## Installation of cli on mac

``` sh
brew tap argoproj/tap
brew install argoproj/tap/argocd
```

## Installation in minikube

In [Kubernetes hello world]({% post_url 2019-12-16-k8s-hello-world %}) we have created kuberentes
instance and we have run simple service. For that we have used minikube. Now we are going to use it
for installing Argo CD. See also <https://argoproj.github.io/argo-cd/getting_started/> for more
details.

``` sh
kubectl create namespace argocd
kubectl apply -n argocd \
    -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Change the argocd-server service type to LoadBalancer:

``` sh
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```
And forward port:

``` sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Now you can access argocd by <https://localhost:8080/>. Username is `admin` and the password:
``` sh
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
```
This allows you to login. You can use CLI to change password and admin kubernetes.

``` sh
argocd login localhost:8080
```

``` sh
argocd account update-password
argocd relogin
```

Now you can sync a repo with argo cd by:

``` sh
argocd app create flaskhelloworld \
  --repo https://github.com/sbartek/sample_flask_app.git\
  --path flaskhelloworld \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default
```

Then one can set argo cd to automatically sync an application.

``` sh
argocd app set flaskhelloworld --sync-policy automated
```

## Links 
* <https://medium.com/@doronsegal/workflow-using-argo-kubernetes-6b45ef3f1614>


_Updated: 2019-12-18_
