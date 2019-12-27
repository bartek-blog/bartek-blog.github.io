---
layout: post
comments: true
title:  "Kubernetes: Namespace and Replication Controller"
date:   2019-12-27 09:00:00 +0200
categories: kubernetes 
---


# Simple node app

In [Node.js Hello World with Docker and k8s]({% post_url 2019-12-25-node-hello-world %}) 
we have explained how to create docker with simple node app and how to deploy it kubernetes.
Here we will show how to make kubernetes to automatically control the deployment. 

We will modify `app.js` as follows:

``` shell
const http = require('http');
const os = require('os');

const port = 80;

var handler = function(request, response) {
    if (request.url === '/') {
        console.log(
            "Received request from " + request.connection.remoteAddress
        ); 
        response.statusCode = 200;
        response.setHeader('Content-Type', 'text/plain');
        text = "Hello World\n" +
        "from " + os.hostname() + "\n";
        response.end(text);
    } else if (request.url === '/healthCheck') {
        var randomNumber = Math.random( );
        console.log(randomNumber);
        if (randomNumber < 0.25) {
            response.writeHead(500);
            response.end("Not OK");
        } else {
            response.statusCode = 200;
            response.end("OK");
        }
    }
};

const server = http.createServer(handler);
server.listen(port);
```

Anyway, in what follows we will use already built image. The entire code is available in:
<https://github.com/sbartek/samplenode>.

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

## Replication Controller

In [Kubernetes hello world]({% post_url 2019-12-16-k8s-hello-world %}) we have created pods
manually. Here we create something called `Replication Controller` that will be responsible for
making sure that declared number of replicas of pod are always alive.

This can be done in declarative way with the following `samplenode-rc.yaml`:
``` yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: samplenode
  namespace: node-dev
spec:
  replicas: 3
  selector:
    run: samplenode
  template:
    metadata:
      labels:
        run: samplenode
    spec:
      containers:
      - name: samplenode
        image: barteks/samplenode:latest
```

Now you can run:

``` shell
kubectl apply -f samplenode-ns.yaml
kubectl apply -f samplenode-rc.yaml
kubectl apply -f samplenode-svc.yaml
```

And this will create three replicas of the pod. Now you can try to delete one pod. Get its name by
calling

``` shel
kubectl get pods
```
And then (remember to change pod name)

``` shell
kubectl delete pod samplenode-cn9pv
```

Then, when calling 
``` shell
kubectl get pods
```
you can see that new pod has been created in order to keep 3 of them running.

The count is done by counting pods that has label `run=samplenode`. So let's change the label by  

``` shell
kubectl label pod samplenode-6fksr run=complicatednode --overwrite
```

Then by running

``` shel
kubectl get pods -L run
```

you can see that there is one more pod. It means that the pod with label changed is no longer
monitored by Replication Controller.

If you want to change number of replicas to 5, you can do this by:

``` shell
kubectl scale rc samplenode --replicas=5
```
or by modifying `samplenode-rc.yaml` and running:

``` shell
kubectl apply -f samplenode-rc.yaml
```

or even modifying directly running Replication Controller's yaml by calling

``` shell
kubectl edit rc samplenode
```

(you can change the default editor by change environment variable `KUBE_EDITOR` ).

Now, if you run `minikube` call

``` shell
minikube servie samplenode -n node-dev
```

Then you can call few times:

``` shell
curl localhost
```
and see that from is changing since it is hitting different pods.

## Health Check

Independently on Replication Controller you can add health check to pods. It works the way that k8s
sends a http request and if it dose not get 2xxx or 3xx responds it will restart the same pod. It is
called __liveness probe__ is declared by adding a section `livenessProbe` to the declaration of a
container of the pod.

New version will look like:

``` shell
apiVersion: v1
kind: ReplicationController
metadata:
  name: samplenode
  namespace: node-dev
spec:
  replicas: 3
  selector:
    run: samplenode
  template:
    metadata:
      labels:
        run: samplenode
    spec:
      containers:
      - name: samplenode
        image: barteks/samplenode:latest
        livenessProbe:
          httpGet:
            path: /healthCheck
            port: 80
          initialDelaySeconds: 30
```

Now, if you keep it running long enough, you should see that the command

``` shell
kubectl get pods -l run=samplenode
```

returns information that pods has been restarted several times.


_Updated: 2019-12-27_

