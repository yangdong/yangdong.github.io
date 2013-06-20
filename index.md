---
layout: page
title: Greetings from Dong
tagline: Continuous Improvment
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
  {% if post.categories.first != 'draft' %}
    <li class="post"><span class="{{post.categories}}">{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
  {% endfor %}
</ul>

