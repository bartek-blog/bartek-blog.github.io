---
layout: post
comments: true
title:  "Redis Quick Start"
date:   2019-12-19 09:00:00 +0200
categories: redis
---

## Redis

[Redis](https://redis.io/) (Remote Dictionary Server) is in-memory key-value database.


## Mac install

``` sh
brew install redis
```

### Start

``` sh
redis-server
```

### Testing

``` sh
redis-cli ping
```

Should return `PONG`.

## Using cli

``` sh
redis-cli
set car Lexus
get car
```

### Saving database

``` sh
save
```

### Closing

``` sh
shutdown
```

## Python 

``` sh
import redis
r.set('moto', 'suzuki')
```

``` sh
r.get('moto')
```

``` sh
pipe = r.pipeline()
pipe.set('country', 'Poland')
pipe.set('city', 'Barcelona')
pipe.get('car')
pipe.execute()
```

### Counter

``` sh
r.set("price", 1)
r.incr("price")
r.get("price")
```

## Docker

``` sh
docker run --detach --publish=6379:6379 --name=redis redis
```

Then you can connect from your mac using `redis-cli`.

``` sh
redis-cli
set car Toyota
```

You can also run cli in docker:

``` sh
docker exec -it redis ]redis-cli
get car
```

_Updated: 2019-12-21_
