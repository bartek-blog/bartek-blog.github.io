---
layout: post
comments: true
title:  "Installing R on mac with brew"
date:   2020-05-21 12:00:00 +0200
categories: R Rstudio
tags: R
---


Here we will show how to install R and Rstudio. Make sure that you have [Homebrew](https://brew.sh/)
installed.

## Installing R 

First we need to run:

``` shell
brew tap brewsci/science
```

Then

``` shell
brew install r
```

In `~/.zshrc` add:

``` shell
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

## Installing Rstudio

``` shell
brew cask install rstudio
```

Then, in order to be able to execute it from command line:

``` shell
echo "alias rstudio='open -a RStudio'" >> ~/.zshrc
source ~/.zshrc
```



_Updated: 2020-05-22_


    
