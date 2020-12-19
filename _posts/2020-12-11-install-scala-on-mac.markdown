---
layout: post
comments: true
title:  "Scala on mac"
date:   2020-12-11 23:00:00 +0200
categories: [scala, sbt]
---

We assume the you have installed Java version 1.8 or 11, for example `doptopenjdk11`, see
[How to install multiple java versions]({% post_url 2019-03-28-how-to-install-java %})

## Sbt

``` shell
brew install sbt
```

## First project

You can follow 
[How to create scala project with sbt]({% post_url 2018-07-09-how-to-create-scala-project-with-sbt %})
for setting up first project.

## Scala

You can also install scala  by
``` shell
brew install scala
```

## ZSH Plugin

``` shell
plugin=(
    ...
    sbt
    ...
)
```


_Updated: 2020-12-11_
