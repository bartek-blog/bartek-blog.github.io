---
layout: post
comments: true
title:  "How to create scala project with sbt"
date:   2018-07-11 08:00:00 +0200
categories: scala sbt
---

Command to create package structure:

``` shell
sbt new scala/scalatest-example.g8
```

Then we have series of sbt's commands:

``` shell
$ sbt
> compile
> test
> run
> package
```

Package is located in `target/scala-X.XX/`.

## Links

* <https://docs.scala-lang.org/getting-started-sbt-track/testing-scala-with-sbt-on-the-command-line.html>
