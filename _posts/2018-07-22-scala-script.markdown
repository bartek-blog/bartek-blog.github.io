---
layout: post
comments: true
title:  "How to create Scala script"
date:   2018-07-22 08:00:00 +0200
categories: scala 
---

## Hello World 

Create `HelloWorld.scala` file with the following
``` scala
object HelloWorld extends App {
    println("Hello World")
}
```
Compile it by 

``` shell
scalac HelloWorld.scala
```
Run it with:

``` shell
scala HelloWorld
```

## Read arguments

Once you have create an object that extends `App`, you can access arguments' array with `args`.

``` scala
object HelloWorld extends App {
    if (args.length == 0) {
        println("Hello World")
    } else {
        println("Hello " + args(0))
    }
}
```

Run it
``` shell
scalac HelloWorld.scala
scala HelloWorld
```

## What if I do not want to extend App?

Then you can implement `main` method

``` scala
object HelloWorld {
    def main(args: Array[String]) = {
        println("Hello " + args(0))
    }
}
```

## Script

You can also create script `hello.sh`

``` scala
#!/usr/bin/env scala

println("Hello World")
```

Then you can simply run it with

``` shell
chmod +x hello.sh
hello.sh
```


_Updated 2018-07-30_
