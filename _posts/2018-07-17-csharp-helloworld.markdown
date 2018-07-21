---
layout: post
comments: true
title:  "How to run C# from command line"
date:   2018-07-17 18:00:00 +0200
categories: csharp
---

## Installing compiler

The easiest way is to install `MonoDevelop` from <https://www.monodevelop.com/>.

## File extension

Standard extension for C# code is `.cs`. So one can create `Hello.cs` file with

``` csharp
using System;
namespace HelloWorld
{
    class Hello 
    {
        static void Main() 
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```

## Compile and run

In order to compile one has to write

``` shell
mcs Hello.cs
```
and in order to run:

``` shell
mono Hello.exe
```

## Links

* Hello World: <https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/hello-world-your-first-program>
* Documentation: <https://msdn.microsoft.com/>
