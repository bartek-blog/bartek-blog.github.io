---
layout: post
comments: true
title:  "Writing Python Script"
date:   2019-12-30 09:00:00 +0200
categories: [python, scripting]
---

## Create file

In you favorite editor open a python file. We will call it `sample_script.py`.


## Shebang

In order to execute python from virtualenv we should start the script with:

``` python
#!/usr/bin/env python
```

## Now script

We can print argument with

``` python
import sys

def main(args):
    print(args)

if __name__ == "__main__":
   main(sys.argv[1:])
```

## Run it

Now add `x` flag:

``` shell
chmod u+x sample_script.py
```

Then you can run it with:

``` shell
./sample_script.py aaa bbb
```

## Key values arguments

In the following example we have created a script thar read key-value arguments.

``` python
#!/usr/bin/env python

import argparse
import sys


def print_parameters(data_path, size):
    print(f"data_path: {data_path}")
    print(f"size: {size}")
    
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_path", default="data/random_data.json", type=str)
    parser.add_argument("--size", default=100, type=int)
    args = parser.parse_args()
    print_parameters(**vars(args))

    
if __name__ == "__main__":
    main()
```

_Updated: 2019-12-30_

