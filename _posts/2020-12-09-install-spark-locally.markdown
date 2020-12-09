---
layout: post
comments: true
title:  "How to install pyspark locally"
date:   2020-12-09 23:00:00 +0200
categories: [pyspark, python]
---
# How to install pyspark locally

## Download and configure spark

First create a directory of storing spark. We will use directory `~/programs`.

Then in your `~/.zshrc` add the following variables:

``` shell
export SPARK_VERSION=3.0.1
export SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop3.2
export SPARK_HOME=$HOME/programs/${SPARK_PACKAGE}
export PATH=${SPARK_HOME}/bin:$PATH
```

Then call

``` shell
source ~/.zshrc
```

Then run

``` shell
curl -O https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz\
&& tar -xvzf ${SPARK_PACKAGE}.tgz \
&& mv ${SPARK_PACKAGE} ${SPARK_HOME} \
&& rm ${SPARK_PACKAGE}.tgz
```

## Install pyspark

Then create python virtual environment and install pyspark with 

``` shell
pip install pyspark==${SPARK_VERSION}
```

## Test it

Create script `x2.py`

``` python
from pyspark.sql import SparkSession
import pyspark.sql.functions as F

if __name__ == "__main__":

    spark = SparkSession\
        .builder\
        .getOrCreate()

    lst = [(0, ), (1, ), (2, ), (3, )]
    dataset = spark.createDataFrame(lst, ["x"])
    x = dataset.select(
        F.sum(F.pow(F.col("x"), F.lit(2))).alias("sumSquares")
    ).collect()
    print("*************************")
    print(" Sum of squares is ", x[0]["sumSquares"])
    print("*************************")
    spark.stop()
```

Run it with

``` shell
python x2.py
```


_Updated: 2020-12-09_
