---
layout: post
comments: true
title:  "How to install multiple java versions"
date:   2019-03-28 11:00:00 +0200
categories: java
---


## Inastall java on Mac

``` shell
brew update
brew tap homebrew/cask-versions
brew install java
brew install adoptopenjdk/openjdk/adoptopenjdk11
```

## Install jenv

[jEnv](https://www.jenv.be/) is a tool for managing different java's version from command line.

``` shell
brew install jenv
```

Then in `~/.zshrc` add

``` shell
export PATH="$HOME/.jenv/bin:$PATH"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
```
Then run `source ~/.zshrc`.

Now you can check available java version with

``` shell
brew search jdk
```

And then you can install it with:

``` shell
brew install adoptopenjdk14
```

## Add it to jenv

Unfortunately you have to manually add installed java's version to available versions in `jenv`.
You can see them by calling

``` shell
ls /Library/Java/JavaVirtualMachines/
```
And then add them by calling __something like__ (you may need to change
`adoptopenjdk-8.jdk` and `openjdk-14.0.1.jdk` to results of `ls /Library/Java/JavaVirtualMachines/`.
``` shell
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/openjdk-14.0.1.jdk/Contents/Home
```

Then when you call
``` shell
jenv versions
```
you should see:

``` shell
* 1.8 (set by /Users/bartekskorulski/.jenv/version)
  1.8.0.275
  14
  14.0
  14.0.2
  openjdk64-1.8.0.275
  openjdk64-14.0.2
```

And finally you can set your global or local (directory) version by calling

``` shell
jenv global 14
```
or

``` shell
jenv local 14
```

Then restart your terminal. You can double check your java version by calling

``` shell
java -version
```

## Ubuntu

``` shell
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```

``` shell
java -version
update-alternatives --config java
```

_Updated: 2021-01-26_
