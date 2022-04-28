---
layout: post
comments: true
title:  "Installing Rust on Mac or Ubuntu"
date:   2022-04-28 23:00:00 +0200
categories: [rust]
---

## Installing

``` shell
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
```

## C compiler

### Mac

``` shell
xcode-select --install
```

### Ubuntu

``` shell
apt install build-essential
```

## Hello world

Create directory

``` shell
mkdir hello
cd hello
```

Create file `main.rs`.

``` rust
fn main() {
    println!("Hello, world!");
}
```

Compile

``` shell
rustc main.rs
```

and run

``` shell
./main
```

## Links

<https://doc.rust-lang.org/book/ch01-01-installation.html>


_Updated: 2022-04-28_
