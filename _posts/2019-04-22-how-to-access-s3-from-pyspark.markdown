---
layout: post
comments: true
title:  "How to access S3 from pyspark"
date:   2019-04-22 11:00:00 +0200
categories: python spark pyspark
---
## Running pyspark

I assume that you have installed `pyspak` somehow similar to the guide here.

<http://bartek-blog.github.io/python/spark/pyspark/2019/03/27/how-to-install-pyspark.html>

Then you should start `pyspark` with
```
pyspark --packages=org.apache.hadoop:hadoop-aws:2.7.3
```

## Code

### Read aws configuration
For more details how to configure AWS access see <http://bartek-blog.github.io/s3/cli/aws/python/boto3/2018/09/10/AWS-CLI-And-S3.html>


```python
import configparser
aws_profile = "myaws"

config = configparser.ConfigParser()
config.read(os.path.expanduser("~/.aws/credentials"))
access_id = config.get(aws_profile, "aws_access_key_id") 
access_key = config.get(aws_profile, "aws_secret_access_key")
```

### configure hadoop 


```python
hadoop_conf = spark._jsc.hadoopConfiguration()
hadoop_conf.set("fs.s3n.impl", "org.apache.hadoop.fs.s3native.NativeS3FileSystem")
hadoop_conf.set("fs.s3n.awsAccessKeyId", access_id)
hadoop_conf.set("fs.s3n.awsSecretAccessKey", access_key)
```

### Read data


```python
sdf = spark.read.option("header", "true").csv("s3n://bartek-ml-course/predict_future_sales/sales_train.csv.gz")
```


```python
sdf.printSchema()
```

    root
     |-- date: string (nullable = true)
     |-- date_block_num: string (nullable = true)
     |-- shop_id: string (nullable = true)
     |-- item_id: string (nullable = true)
     |-- item_price: string (nullable = true)
     |-- item_cnt_day: string (nullable = true)
    


## Write data


```python
import pyspark.sql.functions as F
sdf.groupBy("date").agg(F.sum(F.col('item_cnt_day')).alias("items"))\
    .repartition(1)\
    .write.mode("overwrite")\
    .parquet("s3n://bartek-ml-course/predict_future_sales-aggregations/daily-total-sales")
```


```python
spark.read.parquet("s3n://bartek-ml-course/predict_future_sales-aggregations/daily-total-sales").show()
```

    +----------+------+
    |      date| items|
    +----------+------+
    |16.02.2013|6643.0|
    |09.02.2014|4646.0|
    |01.09.2014|2887.0|
    |18.10.2014|5001.0|
    |27.06.2015|2563.0|
    |17.09.2015|1887.0|
    |29.04.2013|2771.0|
    |12.04.2013|3947.0|
    |18.09.2014|2441.0|
    |15.08.2015|2201.0|
    |28.10.2015|3593.0|
    |05.02.2013|3302.0|
    |21.09.2013|6698.0|
    |31.05.2014|5395.0|
    |02.11.2014|4390.0|
    |08.07.2015|1905.0|
    |13.09.2015|2660.0|
    |06.10.2015|1343.0|
    |13.06.2013|3399.0|
    |22.02.2014|8472.0|
    +----------+------+
    only showing top 20 rows
    



