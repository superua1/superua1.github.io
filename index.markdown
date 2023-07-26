---
layout: simple
title: Video Doküman Blog Komutlar Test
excerpt: "Linux Dersleri Ana Sayfası"
search_omit: true
---

<div class="row mb-2">
<div class="col-md-6">
	<h1 class="text-primary">Eğitimler</h1>

      <div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
        <div class="col p-4 d-flex flex-column position-static">
		<img src="{{ site.url }}/video-egitim.png"/>
    <p></p>
          <p class="card-text mb-auto">Temel Linux kullanımı için eğitim içerikleri.</p>
          <a href="{{ site.url }}/egitim" class=" stretched-link"></a>
        </div>
        </div>
<p></p>
    </div>
	<div class="col-md-6">

	<h1 class="text-primary">Blog</h1>
  <p></p>
  <div id="post-list">
  {% for post in site.categories.blog limit:2 %}
  <div class="post-preview">
    <h4>
      <a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a>
    </h4>
    <div class="post-content">
      <p>
      {% assign _content = post.content %}
      {{ _content | markdownify | strip_html | truncate: 50 }}
      </p>
    </div>
    <div class="post-meta">
      {% assign post_date = post.date | date: "%Y-%m-%d" %}
  {% assign post_modified = post.modified | date: "%Y-%m-%d" %}
      <i class="fa fa-calendar fa-fw text-muted"></i>
      <span class="text-muted timeago" data-toggle="tooltip" data-placement="bottom" title="Yayınlanma Tarihi: {{ post.date }}">{{ post.date | timeago }}</span>

  {% if post_modified > post_date %}
    <span class="small text-success yesil" data-toggle="tooltip" data-placement="bottom" title="Düzenlenme Tarihi: {{ post.modified }}">Güncellendi</span>

  {% endif %}

    </div>
    <hr>
  </div> <!-- .post-review -->
  {% endfor %}
</div> 
 </div>
    </div>
<div class="row">
    <div class="col-md-6">
    <h1 class="text-primary">Komut Listesi</h1>
      <div>
	  
        {% include komut-listesi.html %}

      
    </div>
    </div>
  
  <div class="col-md-6">
  <h1 class="text-primary">Bilgi Testi</h1>
      <div>
	  
         {% include random-question.html %}

    
    </div>
    </div>
  
    </div>
  
