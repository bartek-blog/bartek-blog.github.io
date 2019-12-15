---
layout: post
comments: true
title:  "Flask with gunicorn"
date:   2019-12-14 09:00:00 +0200
categories: flask gunicorn
---

[Flask](https://www.palletsprojects.com/p/flask/) is a minimalist web framework. Although it has
build-in a wsgi (Web Server Gateway Interface) server, but this server is not suitable for
production. Popular solution is [gunicorn](https://gunicorn.org/).

## Flask App

Let's create simple flask app. Create a file `simple_app.py` with:

``` python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello World!'
```

## Run with gunicorn

``` shell
gunicorn simple_app:app
```

If you use `virtualenvs` and have `gunicorn` installed globally you may need to run:

``` shell
$VIRTUAL_ENV/bin/gunicorn simple_app:app
```

`Gunicorn` has more options. In order to run it with, for example, 4 workers, on 5000 port, and
put logs in files you can run:

``` shell
$VIRTUAL_ENV/bin/gunicorn wsgi:app \
    --bind 0.0.0.0:5000 -w 4\
    --access-logfile gunicorn-access.log\
    --error-logfile gunicorn-error.log
```

Then you can see logs with, for example,

``` shell
tail -f gunicorn-access.log
```




