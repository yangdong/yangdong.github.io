---
layout: page
title: Continuous Improvement
tagline: Continuous Improvement
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
    <li class="post {{post.tags}}">
        <div class="date">{{ post.date | date_to_string }}</div>
        <div class="title"><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></div>
        {{ post.content | split: '<!-- more -->' | first }}
        <a class="readmore" href="{{ BASE_PATH }}{{ post.url }}">Read More</a>        
    </li>
  {% endfor %}
</ul>

