---
layout: post
comments: true
title:  "Python pathlib"
date:   2020-01-01 09:00:00 +0200
categories: [python]
---

Python library [pathlib](https://docs.python.org/3/library/pathlib.html) is a cool way of dealing
with filesystem paths. Here we show how we can use it for writing to a file and automatically create
missing directories.

Imagine that we would like to write to a file `data/events/logins.json` but we do knot know if
neither `data` nor `events` directories exist. We could manually check it and then potentially
create them. However, we can do this is an automatic way in just few lines of code.

``` python
from pathlib import Path

path = 'data/events/logins.json'
Path(path).parent.mkdir(parents=True, exist_ok=True)
with open (path, 'w') as f:
    ...
```


_Updated: 2020-01-01_

