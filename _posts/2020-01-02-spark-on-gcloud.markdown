---
layout: post
comments: true
title:  "Spark on gcloud with jupyter"
date:   2020-01-02 09:00:00 +0200
categories: [python, spark, gcloud, google]
---

In [Google Kubernetes Engine Set Up]({% post_url 2019-12-26-gke %}) we have explained how to install
`google-cloud-sdk` and configure a project. Here we explain how to use google storage. Here we show
how to run spark cluster using gcloud. 
For that we have [DATAPROC](https://cloud.google.com/dataproc/).

## Create cluster

See <https://cloud.google.com/dataproc/docs/quickstarts/quickstart-gcloud>

First enable the Dataproc API on <https://console.cloud.google.com/flows/enableapi?apiid=dataproc>

Set default region

``` shell
gcloud config set dataproc/region us-east1
```

Then create a cluster called `spark-cluster` with python 3.6:

``` shell
gcloud dataproc clusters create spark-cluster\
        --image-version=1.4 \
```

See <https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-versions> for information
information about available versions and software installed there.

You can see your cluster at:

<https://console.cloud.google.com/dataproc/clusters>

or by running

``` shell
gcloud dataproc clusters list
```

## Delete cluster

``` shell
gcloud dataproc clusters delete spark-cluster
```


## Create cluster with jupyter notebook

In [Google Storage]({% post_url 2019-12-29-gstorage %}) 
we have explained how to configure google storage. Here we create a bucket for storing notebooks.

One can do this with:

``` shell
gsutil mb gs://bartek-notebooks/
```

You can list buckets with

``` shell
gsutil ls
```

Now we can create cluster 

``` shell
gcloud beta dataproc clusters create jupyter-cluster \
    --optional-components=ANACONDA,JUPYTER \
    --image-version=1.4 \
    --enable-component-gateway \
    --bucket bartek-notebooks
```

## Run notebook

Go to 
<https://console.cloud.google.com/dataproc/clusters>
and select your cluster. Then select `Web Interfaces` and then `Jupyer`.Then choose new `PySpark`

On the cluster you have direct access to google cloud storage. You can read, for example, `csv` file
like this:

``` python 
sdf = spark\
    .read.option("header", "true")\
    .csv("gs://bucket-name-data/test.csv")
```

Now you can easily modify the code 
from [How to access S3 from pyspark]({% post_url 2019-04-22-how-to-access-s3-from-pyspark %}).

At the end do not forget to delete cluster. You will be charged.

## Links
* https://cloud.google.com/dataproc/docs/tutorials/jupyter-notebook



_Updated: 2020-01-02_

