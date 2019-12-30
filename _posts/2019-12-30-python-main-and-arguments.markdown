---
layout: post
comments: true
title:  "Writing Python Script"
date:   2019-12-30 09:00:00 +0200
categories: [python, scripting]
---

## Shebang

In order to execute python from virtualenv we should start the script with.

``` python
#!/usr/bin/env python
```

## Get arguments

``` python
import sys

def main(args):
    print(args)

if __name__ == "__main__":
   main(sys.argv[1:])
```

_Updated: 2019-12-30_

