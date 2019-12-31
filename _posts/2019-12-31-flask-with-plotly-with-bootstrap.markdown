---
layout: post
comments: true
title:  "Flask with bootstrap and plotly"
date:   2019-12-31 09:00:00 +0200
categories: [python, bootstrap, plotly flask]
---

In <https://github.com/sbartek/flask-with-plotly/tree/d364f1fcf0673a25750f035422e27b7f220bafd1> we
have created an app that generate random data and then plot it. Please clone this version of the
repo.

## Generate data

First generate data and save them to `data/random_data.json`. This is simply done by calling:

``` python
python generate_data.py
```

## App 

``` python
gunicorn app:app --bind 0.0.0.0:80\
         --access-logfile logs/gunicorn-access.log\
         --error-logfile logs/gunicorn-error.log
```

Go to <http://0.0.0.0:80>. When you generate data and reload the page you see that the plot is
changing. 

We have added also a simple menu to change color of the plot in order to illustrate how to do this.



_Updated: 2019-12-30_

