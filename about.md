---
layout: page
title: About
permalink: /about/
---

I am Data Scientist and PhD in Dynamical System. 

Here I have collected simple notes that I mostly use for educational proposes.

## Categories 

{% assign categories_sorted = site.categories | sort %}
{% for category in categories_sorted %}
  <h3>{{ category[0] }}</h3>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
