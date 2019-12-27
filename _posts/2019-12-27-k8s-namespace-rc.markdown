---
layout: post
comments: true
title:  "Kubernetes: Namespace and Replication Controller"
date:   2019-12-27 09:00:00 +0200
categories: kubernetes 
---


# Simple node app

In [Node.js Hello World with Docker and k8s]({% post_url 2019-12-25-node-hello-world.markdown %}) 
we have explained how to create docker with simple node app and how to deploy it kubernetes.
Here we will show how to make kubernetes to automatically control the deployment. 


## Namespaces

Namespaces help organize kubernetes resources. It is important when you run 
few independent application on the same cluster. The default namespace is called `default`. 

You can create new namespace calling

``` shell
kubectl create namespace <namespace-name>
```

Than you can switch between namespaces using:
``` shell
kubectl config set-context $(kubectl config current-context) --namespace <namespace-name>

```

With __Kubectl plugin__ for `zshell` 
(see <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl>) it is equivalent to

``` shell
kcn <namespace-name>
```

When you switch to other namespace kubernetes' command work exactly the same but they are restricted
to current namespace. If you want to see resources in another namespace you can do this by adding
`-n <other-namespaca-name>`. For example:

``` shell
kubectl get pods -n default
```

### Declarative way of controlling existence of namespace

The declarative `samplenode-ns.yaml` for namespace called `node-dev` is quite easy.

``` yaml
apiVersion: v1
kind: Namespace
metadata:
  name: node-dev
```

Then in other `yaml`s you need to add `namespace` section in `metadata`. For example, service
declaration `samplenode-svc.yaml` should look like this:

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: samplenode
  namespace: node-dev
spec:
  ports:
  - port: 80
    protocol: TCP
  selector:
    run: samplenode
  type: LoadBalancer
```

_Updated: 2019-12-27_

