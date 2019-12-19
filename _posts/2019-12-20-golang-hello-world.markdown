---
layout: post
comments: true
title:  "Golang hello world"
date:   2019-12-20 09:00:00 +0200
categories: go
---

## GO

[Go (Golang)](https://golang.org/) is a statically typed, compiled programming language designed at
Google.

## Mac Install

``` sh
brew install go
```

## Hello World

Create your workspace directory `$HOME/go`. Then make the directory `src/hello` inside your
workspace. Inside it create file `hello.go` with

``` go
package main

import "fmt"

func main() {
	fmt.Printf("Hello World!")
}
```

Then build it with

``` go
cd ~/go/src/hello
go build
```

and run it with

``` sh
./hello
```

_Updated: 2019-12-20_
