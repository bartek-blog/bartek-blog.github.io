---
layout: post
comments: true
title:  "How to install pyspark"
date:   2019-03-27 11:00:00 +0200
categories: python spark pyspark
---


__Note__ We will assume here that you are using Ubuntu with `bash`. Therefore default shell
configuration file is `~/.bashrc`. If you are using Mac with standard configuration, then you would
need to use `~/.bash_profile`. And finally if you are using `zshell` then you most likely know what
to do (use `~/.zshrc` or `./.zshenv`).

## Download spark

First you need to download spark from 
<https://spark.apache.org/downloads.html>
wherever you want. I'll download and unzip it to `~\programs`.

Then I will create symbolic link to it by calling 

``` shell
ln -s ~/programs/spark-2.4.0-bin-hadoop2.7 ~/programs/spark
```

In `~/.bashrc` you need to add the following lines:

``` shell
export SPARK_HOME="$HOME/programs/spark"
export PATH=$SPARK_HOME/bin:$PATH
```

## Pyspark

We assume that you are using `pyenv`. Instruction to install it are here:
<http://bartek-blog.github.io/python/virtualenv/2018/08/18/Pyenv-and-VirtualEnvs.html>

So let's create environment for pyspark.

``` shell
pyenv shell 3.6.8
mkvirtualenv py3.6-spark
pip install pyspark intel-numpy	intel-scipy intel-scikit-learn jupyter pandas
```

Now, you can test if you can enter pyspark shell by simply running `pyspark`.


If you want directly launch jupyter directly when running `pyspark` you can add the following lines
in `~/.bashrc`:

``` shell
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
```

