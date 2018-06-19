---
layout: post
comments: true
title:  "How to use RVM"
date:   2018-06-16 18:00:00 +0200
categories: ruby
---

Ruby Version Manager ([RVM](https://rvm.io/)) is a way to mange multiple version of ruby on the 
same computer. It is somehow similar to python's virtualenvs, but has much more features, like:
* list, download and install desired ruby version
* automatically switch to proper version when one enters a project's directory
* etc.

## Installation

Is quite easy: see <https://rvm.io/>. For Mac additionally we have to install `gnupg` by calling:
{% highlight shell %}
brew install gnupg
{% endhighlight %}

## Usage

{% highlight shell %}
rvm get head && rvm reload
rvm list known
{% endhighlight %}

In order to install a MRI version (Matz’s Ruby Interpreter, 
the original version used by most people) you can type, for example,
{% highlight shell %}
rvm install ruby-2.5.1
{% endhighlight %}
or simply
{% highlight shell %}
rvm install 2.5
{% endhighlight %}

In order to use it, type:
{% highlight shell %}
rvm use 2.6
{% endhighlight %}
If you want to come back to the system version type:
{% highlight shell %}
rvm system
{% endhighlight %}

## Screencast

https://www.youtube.com/watch?v=cQVb7fHFjSM
