---
layout: post
comments: true
title:  "MongoDB: Hello World"
date:   2019-04-14 09:00:00 +0200
categories: mongodb install
---


## Install on mac

``` shell
brew tap mongodb/brew
brew install mongodb-community@4.0
```

## Run

``` shell
mongod --config /usr/local/etc/mongod.conf
```

## Connect

``` shell
mongo
```

You can connect to different host, using different port or connect directly to a database by using
something like:

``` shell
mongo 192.168.0.5:27018/shop
```

### User name password

``` shell
mongo --username USERNAME --password PASSWORD 127.0.0.1:27018/shop
```

## Create database

Creating a database is as easy as tell `mongodb` to use it and inserting something in it.
So let's start with "using" database `objects`.

``` shell
use objects
```

A command to list existing databases is the following:

``` shell
show dbs
```
As you see there no any database. So let's insert something in `objects`.

## Insert and query data

``` shell
db.shop.insertOne({ item: "phone", details: {manufacturer: "Samsung", model: "S10", price: "909"}})
```
Now you can see that there is a new database.
``` shell
show dbs
```
The `shop` in above is the name of your table (called collections). 
You can change it for anything you want. You can see available collections by calling:

``` shell
show collections
```

## Queries: sql vs mongo

``` shell
db.shop.find({item: "phone"})
```
or
``` shell
db.shop.find({"item": "phone"})
```

This corresponds to
``` sql
SELECT * 
FROM shop
WHERE item = 'phone'
```

``` shell
db.shop.insertMany([
    { item: "phone", details: {manufacturer: "Apple", model: "8"}},
    { item: "phone", details: {manufacturer: "Apple", model: "Xs", price: "1159"}}
])
```


``` sql
SELECT * 
FROM shop
```

``` shell
db.shop.find({})
```


``` sql
SELECT * 
FROM shop
WHERE details.manufacturer = "Apple"
```

``` shell
db.shop.find({"details.manufacturer": "Apple"})
```

## Links


* <https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/>
