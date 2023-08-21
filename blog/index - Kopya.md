---
layout: simple
title: Blog Paylaşımları
excerpt: "Blog üzerinde paylaşılan tüm içeriklerin listesi."
search_omit: true
---
<center>
<h1 class="text-primary">🗃<br>Blog</h1>
  <p>Düzenlenme tarihine göre yeniden eskiye doğru, paylaşılmış olan tüm içeriklerin listesidir. </p>
</center>

{% for post in site.categories.blog %}
<div class="card mb-3">
  <div class="row no-gutters">
    <div class="col-md-3 d-flex align-self-center justify-content-center ">
    <img class="responsive ml-3" src="{{ site.url }}/blog/img/{{ post.cover }}" alt="">
    </div>
    <div class="col-md-9">
      <div class="card-body">
      <p class="text-primary"><i class="fa fa-calendar-o" aria-hidden="true"></i> {{ post.modified | date: "%d/%m/%Y" }}</p>
        <h3 class="mb-0">{{ post.title }}{% if post.puan %}
          <span class="badge badge-warning badge-pill"><i class="fa fa-star" aria-hidden="true"></i> {{ post.puan }}/10</span>
        {% endif %}</h3>
        <p class="card-text mb-auto">{{ post.excerpt | remove: '\[ ... \]' | remove: '\( ... \)' | markdownify | strip_html | strip_newlines | escape_once }}</p>
      </div>
    </div>
     <a href="{{ site.url }}{{ post.url }}" class=" stretched-link"></a>
  </div>
</div>
 {% endfor %}


<div id="post-list">
  {% for post in site.categories.blog %}
  <div class="post-preview">
    <h3>
      <a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a>
    </h3>
    <div class="post-content">
      <p>
      {% assign _content = post.content %}
      {{ _content | markdownify | strip_html | truncate: 200 }}
      </p>
    </div>
    <div class="post-meta text-muted">
      <!-- posted date -->
      <i class="fa fa-calendar fa-fw"></i>
      <span class="timeago" data-toggle="tooltip" data-placement="bottom" title="{{ post.modified }}">{{ post.date | timeago }}

  </span>
      
    </div>
    <hr>
  </div> <!-- .post-review -->
  {% endfor %}
</div> <!-- #post-list -->

<div id="archives" class="pl-xl-2">
{% for post in site.posts %}
  {% capture this_year %}{{ post.date | date: "%Y" }}{% endcapture %}
  {% capture pre_year %}{{ post.previous.date | date: "%Y" }}{% endcapture %}
  {% if forloop.first %}
    {% assign last_day = "" %}
    {% assign last_month = "" %}
  <span class="lead">{{this_year}}</span>
  <ul class="list-unstyled">
  {% endif %}
    <li>
      <div>
        {% capture this_day %}{{ post.date | date: "%d" }}{% endcapture %}
        {% capture this_month %}{{ post.date | date: "%b" }}{% endcapture %}
        <span class="date day">{{ this_day }}</span>
        <span class="date month small text-muted">{{ this_month }}</span>
        <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
      </div>
    </li>
  {% if forloop.last %}
  </ul>
  {% elsif this_year != pre_year %}
  </ul>
  <span class="lead">{{pre_year}}</span>
  <ul class="list-unstyled">
    {% assign last_day = "" %}
    {% assign last_month = "" %}
  {% endif %}
{% endfor %}
</div>