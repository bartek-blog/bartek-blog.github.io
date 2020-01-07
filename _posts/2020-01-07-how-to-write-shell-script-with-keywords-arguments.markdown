---
layout: post
comments: true
title:  "How to write shell script with keywords arguments"
date:   2020-01-07 09:00:00 +0200
categories: [shell]
---

## Simple access to arguments

In shell scripts one can access first argument with `$1`, The same way one can get second, third,
etc. For example, create the following script `script1.sh`. 

``` shell
#!/bin/sh 

first_argument=$1
second_argument=$2


echo $first_argument
echo $second_argument
```

In shell add execute permissions for the script by running

``` shell
chmod u+x script1.sh
```

Then you can run

``` shell
./script1.sh arg1 arg2
```

## Access to unknown number of argument

Create `script2.sh` with

``` shell
#!/bin/sh

for argument in "$@"
do
    echo $argument
done
```

Then you can run

``` shell
./script1.sh arg1 arg2 arg3 arg4
```

## Simple keywords arguments

Now we would like to be able to have a scrip that can interpret the following:

``` shell
./script3.sh --arg1=123 --arg2=234
```

This can be easily piping command `cut` with `echo`. Create the following script and call it
`script3.sh`

``` shell
#!/bin/sh

for keyword in "$@"
do
    key=$(echo $keyword| cut -d = -f 1)
    word=$(echo $keyword| cut -d = -f 2)

    echo $key
    echo $word
done
```

Now call it with

``` shell
./script3.sh --arg1=123 --arg2=234 
```

_Updated: 2020-01-07_

