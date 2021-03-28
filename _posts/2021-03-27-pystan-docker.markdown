---
layout: post
comments: true
title:  "Pystan with jupyter in docker"
date:   2021-03-27 23:00:00 +0200
categories: [python, stan, bayes, docker, jupyter]
---

## Dockerfile

First create locally a file `requirements.txt` with:

``` python
pystan
```
Add there also other requirements you need.

Then create `Dockerfile` with

``` dockerfile
FROM jupyter/datascience-notebook

COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /workdir

ENV JUPYTER_ENABLE_LAB=yes
```

## Build docker

``` shell
docker build -t barteks/bayes-notebook .
```

## Running with linking to local directory

If you locally create locally a directory `workdir` and put there notebooks, then you can run the docker with the command:

``` shell
docker run -it --rm -p 8888:8888 -p 8787:8787 --mount type=bind,source="$(pwd)"/workdir,target=/workdir barteks/bayes-notebook
```

## Links

<https://jupyter-docker-stacks.readthedocs.io/en/latest/using/recipes.html#using-pip-install-or-conda-install-in-a-child-docker-image>


_Updated: 2021-03-28_
