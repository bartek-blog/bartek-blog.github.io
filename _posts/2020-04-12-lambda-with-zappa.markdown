---
layout: post
comments: true
title:  "AWS Lambda with Zappa"
date:   2020-04-12 12:00:00 +0200
categories: python 
tags: python lambda zappa
---

[Zappa](https://github.com/Miserlou/Zappa) provides easy way to deploy server-less Python applications 
on [AWS Lambda](https://aws.amazon.com/lambda/) with [API Gateway](https://aws.amazon.com/api-gateway/).


In [AWS CLI, S3 And Boto3]({% post_url 2018-09-11-AWS-CLI-And-S3 %}#installing-aws-command-line-interface-and-boto)
we have explained how to configure [AWS Command Line Interface (__CLI__)](https://aws.amazon.com/cli/).

Now let's create simple Flask app. Before we do this, create a directory `simple-flask-app` and new
empty python's virtual environment. Zappa recommends to name it differently than the project, for
example `simple-flask-app-venv`. We refer you, for example, 
[Pyenv and VirtualEnvs]({% post_url 2018-08-18-Pyenv-and-VirtualEnvs %}) for instructions about how to create
virtual env with `pyenv`).

Now let's install needed packages by creating `requirements.txt` with

``` python
Flask==1.1.2
zappa==0.51.0
```
and then run:

``` shell
pip install -r requirements.txt
```

## Creating app

Create file `random_app.py` with
``` python
import random
import json

from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    random_number_dict = {
        'randomNumber': random.random()
    }
    return json.dumps(random_number_dict)
```

You can test app with 

``` shell
export FLASK_APP=random_app.py; flask run
```

## Zappa

First init zappa by

``` shell
zappa init
```

When it asks "What do you want to call this environment (default 'dev'):", you can choose `dev`.
Then choose your profile and do deploy the app globally. 

Finally run:

``` shell
zappa deploy dev
```

When you change app, use:

``` shell
zappa update dev
```

_Updated: 2020-04-12_
