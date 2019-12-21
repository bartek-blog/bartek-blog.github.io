---
layout: post
comments: true
title:  "Docker Compose: Flask with Redis"
date:   2019-12-21 09:00:00 +0200
categories: go
---

## App

Create `flask_app.py` with

``` python
import redis
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)


@app.route('/')
def home():
    return "What is your price?"

@app.route('/set_price/<int:price>')
def set_price(price):
    cache.set("price", price)
    return f"Price set to {price}"

@app.route('/get_price')
def get_price():
    price = int(cache.get("price"))
    return f"The price is {price}."
```

Then create `requirements.txt` with 

``` python
redis
Flask
```


Then create folder `app` and inside it `Dockerfile`:

``` python
FROM python:3.6-alpine
WORKDIR /app
RUN apk add --no-cache --update make
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . /app
CMD ["gunicorn", "flask_app:app", "--bind", "0.0.0.0:5000"]
```

## Redis


## docker-compose

and finally `docker-compose.yml`:

``` yaml
version: '3'
services:
  app:
    build:
      context: .
      dockerfile: app/Dockerfile
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
```

Run it with:

``` python
docker-compose up --build
```

You can use <http://localhost:5000/set_price/1000> for setting up the price. And 
then get it by calling <http://localhost:5000/get_price>.

## Links

* Repo with code <https://github.com/sbartek/sample_flask_with_redis>


_Updated: 2019-12-21_
