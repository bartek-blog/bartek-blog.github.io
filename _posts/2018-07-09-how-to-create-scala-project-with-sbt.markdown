---
layout: post
comments: true
title:  "How to create scala project with sbt"
date:   2018-07-11 08:00:00 +0200
categories: scala
tags: sbt
---

## Creating package structure

Command to create package structure:

``` shell
sbt new scala/scalatest-example.g8
```

Then you have to `cd` into the directory and run tests by

``` shell
sbt test
```

This will run the test suite `CubeCalculatorTest` with a single test called `CubeCalculator.cube`.
Then you can transform the code to your need.

## sbt commands

### Compile

``` shell
sbt compile
```

### Run

``` shell
sbt run
```

### Package

``` shell
sbt package
```

The jar is located in `target/scala-X.XX/`.

### Assembly

This will create a fat JAR of your project with all of its dependencies 
(<https://github.com/sbt/sbt-assembly>).

In `project/plugins.sbt` add

``` shell
addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.15.0")
```



## Setting up sbt version

In `project/build.properties` change line into, for example,
``` scala
sbt.version= 1.4.4
```

## Setting up scala version

In `build.sbt` set up 

``` scala
scalaVersion := "2.13.4"
```

## Links

* <https://docs.scala-lang.org/getting-started-sbt-track/testing-scala-with-sbt-on-the-command-line.html>


_Updated: 2020-12-10_
