---
layout: post
comments: true
title:  "Creating Ubuntu VM with Jupyter on GCP"
date:   2020-01-03 09:00:00 +0200
categories: [python, gcloud, jupyter]
---

In [Google Kubernetes Engine Set Up]({% post_url 2019-12-26-gke %}) we have explained how to install
`google-cloud-sdk` and configure a project. Here we explain how to create a simple, single machine on 
[Google Compute Engine](https://cloud.google.com/compute/) from public image.

## Choose image

In shell run

``` shell
gcloud compute images list|more
```

From the column family choose the family and project you like. We choose `ubuntu-1910` 
from `ubuntu-os-cloud` project.

## Choose machine-type

Info about types of machines that are available is on
<https://cloud.google.com/compute/docs/machine-types> or going directly to prices info at
<https://cloud.google.com/compute/vm-instance-pricing>.

Since again we are going to create machine in region `us-east1` we can check what we have by calling:

``` shell
gcloud compute machine-types list --zones=us-east1-b|more
```

Here we choose `n1-standard-1`.

## Creating machine

Here we are going to create machine named `bartek-machine`

``` shell
gcloud compute instances create bartek-machine \
    --image-family ubuntu-1910 \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 --zone us-east1-b
```

If you are planing to have write access to google cloud storage you have to add
`--scopes storage-rw`
(see [Google Storage]({% post_url 2019-12-29-gstorage %}) ).

## Check the status

``` shell
gcloud compute instances list
```


## Opening port

<https://cloud.google.com/vpc/docs/using-firewalls>

``` shell
gcloud compute firewall-rules create jupyter-access \
    --allow=tcp:8888\
    --direction=INGRESS
```


## Connect to machine

<https://cloud.google.com/compute/docs/instances/connecting-to-instance>

``` shell
gcloud compute ssh bartek-machine
```


## Install jupyter on the machine

Follow [How to install pytorch with conda]({% post_url 2018-11-12-install-pytorch-with-conda %})
(ubuntu part) in order to install jupyter.

Then create jupyter configuration by calling:

``` shell
jupyter notebook --generate-config
```

and at the end of the file `.jupyter/jupyter_notebook_config.py` add:

``` python
c = get_config()
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8888
```

Now run 

``` shell
jupyter-notebook --no-browser --port=8888
```
Note the there is a token listed there in the output.


Then from local computer get `EXTERNAL_IP` of the machine

``` shell
gcloud compute instances list
```

and in the browser open 
`http://[EXTERNAL_ID]:8888`

where `[EXTERNAL_IP]` is the external ip of the machine. Insert the token from the output of the
command

``` shell
jupyter-notebook --no-browser --port=8888
```

## Deleting machine

``` shell
gcloud compute instances delete bartek-machine
```



_Updated: 2020-01-03_

