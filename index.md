---
layout: page
title: Greetings from Dong
tagline: Continuous Improvment
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
  {% if post.categories.first != 'draft' %}
    <li class="post {{post.categories}}">
        <a class="title" href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
        <span class="date">{{ post.date | date_to_string }}</span>
    </li>
  {% endif %}
  {% endfor %}
</ul>

