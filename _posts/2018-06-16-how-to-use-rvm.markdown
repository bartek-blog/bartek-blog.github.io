---
layout: post
comments: true
title:  "How to use RVM"
date:   2018-06-16 18:00:00 +0200
categories: ruby
---

Ruby Version Manager ([RVM](https://rvm.io/)) is a way to mange multiple version of ruby on the 
same computer. It is somehow similar to python's virtualenvs, but has more features, like:
* list, download and install desired ruby version
* automatically switch to proper version when one enters a project's directory
* etc.

## Installation

Is quite easy: see <https://rvm.io/>. 

For Mac additionally we have to install `gnupg` by calling:
{% highlight shell %}
brew install gnupg
{% endhighlight %}
(then use `gpg` insted of `gpg2`)
and for Ubuntu:
{% highlight shell %}
sudo apt install gnupg2
{% endhighlight %}

Then add the following lines to `.bash_profile` (or `.bashrc`):
``` shell
export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
```

## Usage

{% highlight shell %}
rvm get head && rvm reload
rvm list known
{% endhighlight %}

If you get, __Warning! PATH is not properly set up, ...__ you can try to run:
```shell
rvm reset
```

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
rvm use 2.5
{% endhighlight %}
If you want to come back to the system version type:
{% highlight shell %}
rvm system
{% endhighlight %}

## ruby-version

One can make use rvm to automatically switch between ruby version. Let's say we have created a 
project called `bartek-blog`. 
{% highlight shell %}
mkdir bartek-blog
{% endhighlight %}
Then we have to enter the directory of the project.
{% highlight shell %}
cd bartek-blog
{% endhighlight %}
And run the following lines:
{% highlight shell %}
rvm  ruby-2.6.1 do rvm gemset create bartek_blog
rvm --ruby-version use  ruby-2.6.1@bartek_blog
{% endhighlight %}
This will create files `.ruby-gemset` and `.ruby-version`. Now each time ones enter the directory 
`rvm` with switch to the desired version of ruby automatically.

