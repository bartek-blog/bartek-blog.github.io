---
layout: post
comments: true
title:  "How to run spark in minikube"
date:   2020-12-10 23:00:00 +0200
categories: [pyspark, python]
---

Here we will explain how to run the example from <https://spark.apache.org/docs/3.0.1/running-on-kubernetes.html>
in minikube.

We assume the you have installed:
* Spark locally [How to install pyspark locally]({% post_url 2020-12-09-install-spark-locally %})
* Install minikube [Kubernetes hello world]({% post_url 2019-12-16-k8s-hello-world %})
* Also java 11 [How to install multiple java versions]({% post_url 2019-03-28-how-to-install-java %})


## Java

Now spark support Java 11, so we are going to use it. If you followed the tutorial 
[How to install multiple java versions]({% post_url 2019-03-28-how-to-install-java %})
you can set it up by

``` shell
jenv global 11
```

## Create dockers (spark and spark-py)

First got to downloaded spark and use spark's script to create docker for k8s:

``` shell
cd ${SPARK_HOME} 
./bin/docker-image-tool.sh -r barteks -t v${SPARK_VERSION}-java11 \
    -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
    -b java_image_tag=11-slim build
```
Here `barteks` is my Docker Hub account <https://hub.docker.com/>. 

Then push dockers to Docker Hub:

``` shell
docker push barteks/spark:v${SPARK_VERSION}-java11
docker push barteks/spark-py:v${SPARK_VERSION}-java11
```

## Run minikube

``` shell
minikube --memory 4096 --cpus 2 start
```

It's important to reserve some memory and cpu's. 

## Create service account

``` shell
kubectl create serviceaccount spark-job
```

``` shell
kubectl create clusterrolebinding spark-role \
    --clusterrole=edit --serviceaccount=default:spark-job \
    --namespace=default
```

## Submit example job

From

``` shell
 kubectl cluster-info
```

get `Kubernetes master`. Should look like `https://127.0.0.1:32776` and modify in the command below:

``` shell
./bin/spark-submit \
  --master k8s://https://127.0.0.1:32776 \
  --deploy-mode cluster \
  --name spark-pi \
  --class org.apache.spark.examples.SparkPi \
  --conf spark.executor.instances=2 \
  --conf spark.kubernetes.container.image=barteks/spark-py:v${SPARK_VERSION}-java11 \
  --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-job \
  local:///opt/spark/examples/jars/spark-examples_2.12-3.0.1.jar
```

(check spark's example directory for the proper link).

## Check results

``` shell
kubectl get pods
```

The check logs of the corresponding pod:

``` shell
kubectl logs spark-pi-1751c5764c6efff5-driver
```

_Updated: 2020-12-10_
