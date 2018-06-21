---
layout: post
title:  "How to install and use Jekyll"
date:   2018-06-17 10:00:00 +0200
categories: ruby
---

[Jekyll](https://jekyllrb.com/) is a static web site generator. It is written in Ruby. Here 
we will show you how to create sample project. 

# Installation

If you use RVM 
(see [my post]({% post_url 2018-06-16-how-to-use-rvm %})), first choose ruby version calling:
{% highlight shell %}
rvm use 2.6
{% endhighlight %}
Then as in documentation:
{% highlight shell %}
gem install bundler jekyll
jekyll new my-awesome-site
cd my-awesome-site
{% endhighlight %}

# Usage

In order to generate file:
{% highlight shell %}
bundle exec jekyll build
{% endhighlight %}
And in order to run it on development  (http://localhost:4000/):
{% highlight shell %}
bundle exec jekyll serve
{% endhighlight %}

# Add comments to a blog

Follow
<https://medium.com/@balogic/adding-comments-part-to-your-jekyll-blog-6a8fccb7e634>
