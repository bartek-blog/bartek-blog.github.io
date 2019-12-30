---
layout: post
comments: true
title:  "AWS CLI, S3 And Boto3"
date:   2018-09-11 00:00:00 +0200
categories: python storage cloud
tags: S3 cli
---
## Amazon S3

### What it is S3

__Amazon S3__ (Simple Storage Service) is a Amazon's service for storing files. It is simple in a sense that one store data using the follwing:
* __bucket__: place to store. Its name is unique for all S3 users, which means that there cannot exist two buckets with the same name even if they are private for to different users.
* __key__: a unique (for a bucket) name that link to the sotred object. It is common to use path like syntax to group objects. 
* __object__: any file (text or binary). It can be partitioned.

### Sign up
First go to 
<https://s3.console.aws.amazon.com/s3>

and sign up for S3. You can also try to create a bucket, upload files etc. Here we will explain how to use it porogramatically. 

## Data 

But first let's get data we are going to use here. We take the dataset `train.csv` from <https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge>. 
We locally store in `data` directory.

### Sampling data

We also sample this dataset in order to have one more example (and faster execution).


```python
import numpy as np
import pandas as pd
np.random.seed(10)
comments = pd.read_csv("data/train.csv")
nrows = comments.shape[0]
comments.iloc[np.random.choice(range(nrows), 10000, replace=False)]\
    .to_csv("data/train_sample10000.csv", index=False)
comments.iloc[np.random.choice(range(nrows), 1000, replace=False)]\
    .to_csv("data/train_sample1000.csv", index=False)
comments.iloc[np.random.choice(range(nrows), 100, replace=False)]\
    .to_csv("data/train_sample100.csv", index=False)
comments10 = comments.iloc[np.random.choice(range(nrows), 10, replace=False)]
comments10.to_csv("data/train_sample10.csv", index=False)
comments10
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>comment_text</th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>58764</th>
      <td>9d5dbcb8a5b4ffe7</td>
      <td>Excuse me? \n\nHi there. This is . I was just ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>131811</th>
      <td>c14eac99440f267c</td>
      <td>Millionaire is at GAN... \n\n…and the review h...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>88460</th>
      <td>eca71b12782e19dd</td>
      <td>SHUT yOUR bUTT \n\nThats right, i siad it. I h...</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>116091</th>
      <td>6cb62773403858a4</td>
      <td>"\n I agree. Remove. flash; "</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>42014</th>
      <td>7013c411cfcfc56a</td>
      <td>OK, I will link them on the talk page - could ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>49713</th>
      <td>84ee5646920773c5</td>
      <td>err... What exactly happens with Serviceman?</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>103293</th>
      <td>28ca8dcc0b342980</td>
      <td>i am a newbe i dont even know how to type on t...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>95607</th>
      <td>ffb366cd60c48f56</td>
      <td>"\nAbsolutely agree. No relevance to either hi...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>83139</th>
      <td>de66043ff744144b</td>
      <td>Thats what I think did i changed plot to story...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>90771</th>
      <td>f2d6367d798492d9</td>
      <td>"I will improve references. Again, please do n...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



## Installing AWS Command Line Interface and boto

In order to install boto (Python interface to Amazon Web Service) and AWS Command Line Interface (__CLI__) type:
```
pip install boto3
pip install awscli
```

Then in your home directory create file `~/.aws/credentials` with the following:

```
[myaws]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

If you add these configuration as `[default]`, you won't need to add `--profile myaws` in CLI commands in Section CLI Basic Commands.

### Where to get credentials from

1. Go to https://console.aws.amazon.com/console/home and log in
2. Click on USER NAME (right top) and select `My Security Credentials`.
3. Click on `+ Access keys (access key ID and secret access key)` and then on `Create New Acess Key`.
4 Choose `Show access key`.

## CLI Basic Commands 

### List buckets
```
aws --profile myaws s3 ls
```

### List all buckets

```
aws --profile myaws s3 ls 
```

### Create buckers
```
aws --profile myaws s3 mb s3://barteks-toxic-comments
```
__Warning__ The bucket namespace is shared by all users of the system so you need to change the name.

### Upload and download files

#### Upload
```
aws --profile myaws s3 cp data/train.csv s3://barteks-toxic-comments
aws --profile myaws s3 cp data/train_sample10000.csv s3://barteks-toxic-comments/sample/
aws --profile myaws s3 cp data/train_sample1000.csv s3://barteks-toxic-comments/sample/
aws --profile myaws s3 cp data/train_sample100.csv s3://barteks-toxic-comments/sample/
aws --profile myaws s3 cp data/train_sample10.csv s3://barteks-toxic-comments/sample/
```

The last 4 commands can be done in shell calling:
```
for f in data/train_sample1*.csv; do aws --profile myaws s3 cp $f s3://barteks-toxic-comments/sample/; done
```

#### Download
```
aws --profile myaws s3 cp s3://barteks-toxic-comments/sample/train_sample10.csv data/train_copy_sample10.csv
```

### List files in path
 
```
aws --profile myaws s3 ls s3://barteks-toxic-comments/
aws --profile myaws s3 ls s3://barteks-toxic-comments/sample/
```

### Remove file(s)

```
aws --profile myaws s3 rm s3://barteks-toxic-comments/sample/train_sample2.csv
aws --profile myaws s3 rm s3://barteks-toxic-comments/sample/ --recursive
```

### Delete bucket

For deleting a bucket use
```
aws --profile myaws s3 rb  s3://barteks-toxic-comments
```
in order to delete non empty backet use `--force` option.

In order to empty a backet use
```
aws --profile myaws s3 rm s3://barteks-toxic-comments/ --recursive
```

## What Boto is

Boto is a Python package that provides interfaces to Amazon Web Services. Here we are focused on its application to S3.

### Creating S3 Resource

We start using boto3 by creating S3 resorce object.


```python
import boto3
session = boto3.Session(profile_name='myaws')
s3 = session.resource('s3')
```

#### From evironment variables

If your credentials are stored as evirionment variables `AWS_SECRET_KEY_ID` and `AWS_SECRET_ACCESS_KEY` then you can do the following:

```
import os
aws_access_key_id = os.environ.get('AWS_SECRET_KEY_ID')
aws_secret_access_key = s.environ.get('AWS_SECRET_ACCESS_KEY')
session = boto3.Session(
    aws_access_key_id=aws_access_key_id, 
    aws_secret_access_key=aws_secret_access_key)
```

### List buckets


```python
list(s3.buckets.all())
```




    [s3.Bucket(name='barteks'),
     s3.Bucket(name='barteks-mess-nlp'),
     s3.Bucket(name='barteks-toxic-comments'),
     s3.Bucket(name='barteks-toxic-comments-stats'),
     s3.Bucket(name='edreams2018')]



### Create a bucket

__Warning__ As before, bucket's namespace is shared, so the following command may not poroduce a bucket if a bucket with the name exists.


```python
#s3.create_bucket(
#    ACL='public-read',
#    Bucket="barteks-toxic-comments-stats")
```

And you have the followng Access Control List (ACL) options while creating it: 
* `'private', 
* 'public-read', 
* 'public-read-write', 
* 'authenticated-read'`.

### Deleting


```python
#bucket = s3.Bucket('barteks-toxic-comments-stats')
#bucket.delete()
```

### List keys in the bucket


```python
bucket = s3.Bucket('barteks-toxic-comments')
objs = [obj for obj in bucket.objects.all()]
objs
```




    [s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample100.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample1000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='train.csv')]




```python
[obj.key for obj in bucket.objects.filter(Prefix="sample/")]
```




    ['sample/train_sample10.csv',
     'sample/train_sample100.csv',
     'sample/train_sample1000.csv',
     'sample/train_sample10000.csv']



The object of class `ObjectSummary` has to properties `Bucket` (that returns Bucket object), `bucket_name` and `key` that return strings. 


```python
objs[0].Bucket(), objs[0].bucket_name, objs[0].key
```




    (s3.Bucket(name='barteks-toxic-comments'),
     'barteks-toxic-comments',
     'sample/train_sample10.csv')



#### Filter keys and sort them 


```python
objects = [obj for obj in bucket.objects.filter(Prefix="sample/")]
objects.sort(key=lambda obj: obj.key, reverse=True)
objects
```




    [s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample1000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample100.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10.csv')]



### Download file


```python
bucket = s3.Bucket('barteks-toxic-comments')
bucket.download_file('sample/train_sample10.csv', "data/train_copy2_sample10.csv")
```

#### Transform to pandas.DataFrame

One way to do this is to download the file and open it with `pandas.read_csv` method. If we do not want to do this we have to read it a buffer and open it from there. In order to do this we need to use low level interaction.


```python
import io
obj = s3.Object('barteks-toxic-comments', 'sample/train_sample100.csv').get()
comments100 = pd.read_csv(io.BytesIO(obj['Body'].read()))
comments100.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>comment_text</th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2e9c4b5d271ed9e2</td>
      <td>From McCrillis Nsiah=\n\nI'm welcome again aft...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>717f6930af943c80</td>
      <td>"\n\n Invitation \n  I'd like to invite you to...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>6fbf60373657a531</td>
      <td>"=Tropical Cyclone George=====\nNamed George, ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>9deaefedc0fcb51f</td>
      <td>No. I agree with BenBuff91 statement. The AFDI...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>345bedef916b9f9e</td>
      <td>. It seems the typical paranoid and prejudiced...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



Another way, using higher level `download_fileobj` requires transform bytes streaiming into text streaming.


```python
f = io.BytesIO()
bucket.download_fileobj('sample/train_sample10.csv', f)
f.seek(0)
pd.read_csv(io.TextIOWrapper(f, encoding='utf-8'))
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>comment_text</th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>9d5dbcb8a5b4ffe7</td>
      <td>Excuse me? \n\nHi there. This is . I was just ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>c14eac99440f267c</td>
      <td>Millionaire is at GAN... \n\n…and the review h...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>eca71b12782e19dd</td>
      <td>SHUT yOUR bUTT \n\nThats right, i siad it. I h...</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>6cb62773403858a4</td>
      <td>"\n I agree. Remove. flash; "</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>7013c411cfcfc56a</td>
      <td>OK, I will link them on the talk page - could ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>84ee5646920773c5</td>
      <td>err... What exactly happens with Serviceman?</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>28ca8dcc0b342980</td>
      <td>i am a newbe i dont even know how to type on t...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>ffb366cd60c48f56</td>
      <td>"\nAbsolutely agree. No relevance to either hi...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>de66043ff744144b</td>
      <td>Thats what I think did i changed plot to story...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>f2d6367d798492d9</td>
      <td>"I will improve references. Again, please do n...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



### Upload file


```python
stat_bucket = s3.Bucket("barteks-toxic-comments-stats")
```


```python
comments100stat = \
    comments100.groupby(["toxic", "severe_toxic", "obscene", "threat", "insult", "identity_hate"])\
    .count().reset_index()
comments100stat.to_csv("data/train_sample100stat.csv", index=False)
```


```python
stat_bucket.upload_file("data/train_sample100stat.csv", 'sample/train_sample100stat.csv')
```


```python
list(bucket.objects.all())
```




    [s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample100.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample1000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='train.csv')]



#### With buffer


```python
import io
f = io.StringIO()
comments100stat.to_csv(f, index=False)
stat_bucket.upload_fileobj(f, 'sample/train_sample100stat_copy.csv')
```


```python
list(bucket.objects.all())
```




    [s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample100.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample1000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='sample/train_sample10000.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments', key='train.csv')]



### Delete


```python
obj = s3.Object('barteks-toxic-comments', 'sample/train_copy2_sample10.csv')
```


```python
obj.delete()
```




    {'ResponseMetadata': {'HTTPHeaders': {'date': 'Fri, 02 Nov 2018 15:39:39 GMT',
       'server': 'AmazonS3',
       'x-amz-id-2': 'CSAuR7e4fWUqg2YuQ8i3gkca1/wGN56Fv3Mt7//D1VmwVm7M2a94FHrJhS0ks4yRFxuPyCB6B8U=',
       'x-amz-request-id': '80F7365FBF37C732'},
      'HTTPStatusCode': 204,
      'HostId': 'CSAuR7e4fWUqg2YuQ8i3gkca1/wGN56Fv3Mt7//D1VmwVm7M2a94FHrJhS0ks4yRFxuPyCB6B8U=',
      'RequestId': '80F7365FBF37C732',
      'RetryAttempts': 0}}



### S3 client: low level access


```python
s3_client = session.client('s3')
```

## Access through http(s)

### Change Access Control


```python
obj = s3.Object('barteks-toxic-comments-stats', 'sample/train_sample100stat_copy.csv')
obj.Acl().put(ACL='public-read')
```




    {'ResponseMetadata': {'HTTPHeaders': {'content-length': '0',
       'date': 'Fri, 02 Nov 2018 15:39:39 GMT',
       'server': 'AmazonS3',
       'x-amz-id-2': 'n/UeTtw/7MUHgi1tBDFBeJ7mVoyjcenZekIC+qgNQ9izGyTeEAY+PZ9IAJ77g/39EOFSHgI46rY=',
       'x-amz-request-id': '76736BA5657E239C'},
      'HTTPStatusCode': 200,
      'HostId': 'n/UeTtw/7MUHgi1tBDFBeJ7mVoyjcenZekIC+qgNQ9izGyTeEAY+PZ9IAJ77g/39EOFSHgI46rY=',
      'RequestId': '76736BA5657E239C',
      'RetryAttempts': 0}}



### Uri

There are two formats of uri:
```
http(s)://s3.amazonaws.com/<bucket>/<object>
http(s)://<bucket>.s3.amazonaws.com/<object>
```

### Example

<https://s3.amazonaws.com/barteks-toxic-comments-stats/sample/train_sample100stat_copy.csv>

## Streaming with smart_open

### Install

```
pip install smart_open
```


```python
from smart_open import smart_open

comments1000 = \
    pd.read_csv(
        smart_open(
            's3://barteks-toxic-comments/sample/train_sample1000.csv', 'rb', 
            profile_name='myaws'))
    
comments1000_stat =\
    comments1000.groupby(["toxic", "severe_toxic", "obscene", "threat", "insult", "identity_hate"])\
    .count().reset_index()
comments1000_stat.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
      <th>id</th>
      <th>comment_text</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>894</td>
      <td>894</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>4</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>3</td>
      <td>3</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



#### Passing session


```python
pd.read_csv(smart_open(
    's3://barteks-toxic-comments/sample/train_sample100.csv', 'rb', 
        s3_session=session)
).head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>comment_text</th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2e9c4b5d271ed9e2</td>
      <td>From McCrillis Nsiah=\n\nI'm welcome again aft...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>717f6930af943c80</td>
      <td>"\n\n Invitation \n  I'd like to invite you to...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>6fbf60373657a531</td>
      <td>"=Tropical Cyclone George=====\nNamed George, ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>9deaefedc0fcb51f</td>
      <td>No. I agree with BenBuff91 statement. The AFDI...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>345bedef916b9f9e</td>
      <td>. It seems the typical paranoid and prejudiced...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



It is smart enough to recognize from where it has to read


```python
pd.read_csv(smart_open(
    'data/train_sample100.csv', 'rb', 
    s3_session=session)
).head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>comment_text</th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2e9c4b5d271ed9e2</td>
      <td>From McCrillis Nsiah=\n\nI'm welcome again aft...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>717f6930af943c80</td>
      <td>"\n\n Invitation \n  I'd like to invite you to...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>6fbf60373657a531</td>
      <td>"=Tropical Cyclone George=====\nNamed George, ...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>9deaefedc0fcb51f</td>
      <td>No. I agree with BenBuff91 statement. The AFDI...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>345bedef916b9f9e</td>
      <td>. It seems the typical paranoid and prejudiced...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



#### Writing


```python
with smart_open('s3://barteks-toxic-comments-stats/sample/train_sample1000stat123.csv', 'w', 
               profile_name='myaws') as fout:
    comments1000_stat.to_csv(fout, index=False)
```


```python
import pickle
class Model:

    def __init__(self):
        self.attr = 123
        
model = Model()

with smart_open("s3://barteks-toxic-comments-stats/models/model.pickle", 'wb', 
               profile_name='myaws') as f:
    pickle.dump(model, f, pickle.HIGHEST_PROTOCOL)
    
```


```python
list(stat_bucket.objects.all())
```




    [s3.ObjectSummary(bucket_name='barteks-toxic-comments-stats', key='sample/train_sample1000stat.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments-stats', key='sample/train_sample1000stat.csv.gzip'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments-stats', key='sample/train_sample1000stat123.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments-stats', key='sample/train_sample1000stat2.csv.gzip'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments-stats', key='sample/train_sample100stat.csv'),
     s3.ObjectSummary(bucket_name='barteks-toxic-comments-stats', key='sample/train_sample100stat_copy.csv')]




```python
with smart_open("s3://barteks-toxic-comments-stats/models/model.pickle", 'rb', 
               profile_name='myaws') as f:
    model = pickle.load(f)
print(model.attr)
```

    123


## Links:

* https://github.com/boto/boto3
* https://boto3.amazonaws.com/v1/documentation/api/latest/index.html
* https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge

_Last update:_ `2018-11-03`
