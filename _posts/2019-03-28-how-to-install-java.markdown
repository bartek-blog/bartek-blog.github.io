---
layout: post
comments: true
title:  "How to install multiple java versions"
date:   2019-03-28 11:00:00 +0200
categories: java
---


## Mac

``` shell
brew update
brew tap caskroom/cask
brew cask install java8
```

### jenv

``` shell
brew install jenv
```

Then in `~/.bash_profile` add

``` shell
export PATH="$HOME/.jenv/bin:$PATH"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
```

And unfortunately you have to add them manually to available versions. You can see them by calling

``` shell
ls /Library/Java/JavaVirtualMachines/
```
And then add them by calling something like
``` shell
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
```

Then when you call
``` shell
jenv versions
```
you should see:

``` shell
* system (set by /Users/bartek/.jenv/version)
  1.8
  1.8.0.202
  11.0
  11.0.1
  oracle64-1.8.0.202
  oracle64-11.0.1
```

And finally you can set your global or local (directory) version by calling

``` shell
jenv global 1.8
```
or

``` shell
jenv local 1.8
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
