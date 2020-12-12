---
layout: post
comments: true
title:  "How to build self-contained spark application with scala"
date:   2020-12-11 23:30:00 +0200
categories: [intelij, scala]
---

## Create scala aplication

You can do this directly with `sbt`, see
[How to create scala project with sbt]({% post_url 2018-07-09-how-to-create-scala-project-with-sbt %}),
or with IntelliJ, see
[How to install IntelliJ Community Edition for Scala on mac]({% post_url 2020-12-11-intelij %}),

## Set up dependencies

In `build.sbt` add

``` scala
name := "Spark App"

version := "0.1"

scalaVersion := "2.12.10"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.8" % Test
libraryDependencies += "org.apache.spark" %% "spark-sql" % "3.0.1"
```


_Updated: 2020-12-12_
