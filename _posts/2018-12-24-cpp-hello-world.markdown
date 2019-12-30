---
layout: post
comments: true
title:  "C++ Hello World"
date:   2018-12-24 18:00:00 +0200
categories: c++ 
tags: helloworld
---


## Code

Open your favorite editor and create file `helloworld.cpp`.

``` c++
#include <iostream>

int main() {
  std::cout << "Hello World!\n";
  return 0;
}
```

## Compile

In order to compile it in a console run:
``` shell
g++ helloworld.cpp -o helloworld
```

Then run it with:

``` shell
./helloworld
```

## Makefile

You can also create a `makefile` in the same directory as `helloworld.cpp` 
(<https://www.gnu.org/software/make/manual/html_node/index.html>).

``` makefile
helloworld:
	g++ helloworld.cpp -o helloworld

.PHONY: clean
clean:
	rm helloworld
```

Then, in order to compile it, just run

``` shell
make
```

