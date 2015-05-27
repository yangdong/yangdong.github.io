---
layout: page
title: Continuous Improvement
tagline: Continuous Improvement
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
  {% if post.categories.first != 'todo' %}
    <li class="post {{post.categories}}">
        <div class="date">{{ post.date | date_to_string }}</div>
        <a class="title" href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
        {{ post.content | split: '<!-- more -->' | first }}
        <a class="readmore" href="{{ BASE_PATH }}{{ post.url }}">Read More</a>        
    </li>
  {% endif %}
  {% endfor %}
</ul>

