---
layout: post
comments: true
title:  "Hello World in Java"
date:   2018-08-16 23:00:00 +0200
categories: java 
---

## Hello World 

Create `HelloWorld.java` file with the following
``` java
public class HelloWorld {

    public static void main(String[] args) {
        System.out.println("Hello World");
    }

}
```
Compile it by 

``` shell
javac HelloWorld.java
```
Run it with:

``` shell
java HelloWorld
```

### Creating JAR file

In order to create JAR file one have to create `Manifesto.txt` with
``` txt
Main-Class: HelloWorld
```
Then, one can create `jar` file with
``` shell
jar cfm HelloWorld.jar Manifest.txt HelloWorld.class
```
and run it with
``` shell
java -jar HelloWorld.jar 
```



