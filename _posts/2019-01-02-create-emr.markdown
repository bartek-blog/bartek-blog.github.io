---
layout: post
comments: true
title:  "How to deploy Amazon EMR"
date:   2019-01-02 12:00:00 +0200
categories: aws cloud spark
tags: emr
---

## What is EMR?

Elastic MapReduce (EMR) is service that allows to deploy Hadoop cluster on Amazon cloud. 

Here we explain how to deploy EMR.

## Data

Here we are using data from Kaggle competition.
<https://www.kaggle.com/c/competitive-data-science-predict-future-sales>
We assume they are copied into bucket `s3://bartek-ml-course`. You can do this as the follows.
First download files to dirctory `predict_future_sales` and then you can run:
``` shell
for f in predict_future_sales/*;\
do aws  --profile=myaws s3 cp $f s3://bartek-ml-course/predict_future_sales/;
done
```
Of course you have to replace `s3://bartek-ml-course` by the bucket you have created.

We assume that you have installed AWS CLI. If not please refer to 
[AWS-CLI-And-S3]({% post_url 2018-09-11-AWS-CLI-And-S3 %}).

## Create cluster

Go to <https://console.aws.amazon.com/elasticmapreduce> and click `Create cluster`.

Then
![png](/assets/imgs/emr/emr_create.png)

### Connect

In order to connect you need master ip address:
![png](/assets/imgs/emr/master_ip_address.png)

and then create Security Group:
![png](/assets/imgs/emr/access_security_group.png)
![png](/assets/imgs/emr/create_security_group.png)
![png](/assets/imgs/emr/configuration_of_security_group.png)

Now we need to assign security group to master.
![png](/assets/imgs/emr/go_to_ec2.png)
![png](/assets/imgs/emr/running_instances.png)
![png](/assets/imgs/emr/choose_master.png)
![png](/assets/imgs/emr/change_security_group.png)
![png](/assets/imgs/emr/add_security_group.png)

From terminal execute:
``` shell
ssh -i ~/.ssh/barteks-aws.pem hadoop@ec2-XX-XX-XX-XX.compute-1.amazonaws.com
```
where `XX.XX.XX.XX` is master's ip address.


![png](/assets/imgs/emr/connect_to_master.png)


