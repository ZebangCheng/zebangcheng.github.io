---
layout: default
title: "Achievements"
description: "Competition results, academic honors, and contributions to the research community."
nav_key: achievements
permalink: /achievements/
---

{% include detail-header.html eyebrow="Recognition & Service" %}
{% assign activities = site.data.service | where: "kind", "event" %}
{% assign reviews = site.data.service | where: "kind", "review" %}

<section class="detail-section achievement-section" aria-labelledby="competition-title">
  <h2 id="competition-title">Competition Highlights</h2>
  <p class="section-lead">Challenge results, research contributions, and award certificates.</p>
  <div class="achievement-list">
    {% for item in site.data.competitions %}
      <article class="achievement-row" id="{{ item.id }}" aria-labelledby="{{ item.id }}-title">
        {% include achievement-gallery.html images=item.gallery title=item.title document=item.certificate %}
        <div class="achievement-details">
          <div class="achievement-meta"><span>{{ item.rank }}</span><time>{{ item.year }}</time></div>
          <h3 id="{{ item.id }}-title">{{ item.title }}</h3>
          <p>{{ item.summary }}</p>
          {% if item.role and item.role != '' %}<p class="achievement-role"><strong>Role:</strong> {{ item.role }}</p>{% endif %}
          {% include achievement-links.html links=item.links document=item.certificate %}
        </div>
      </article>
    {% endfor %}
  </div>
</section>

<section class="detail-section achievement-section" aria-labelledby="honors-detail-title">
  <h2 id="honors-detail-title">Honors &amp; Awards</h2>
  <p class="section-lead">Academic honors, scholarships, and talent development programs.</p>
  <div class="achievement-list">
    {% for honor in site.data.honors %}
      <article class="achievement-row honor-row" id="{{ honor.id }}" aria-labelledby="{{ honor.id }}-title">
        {% include achievement-gallery.html images=honor.gallery title=honor.title document=honor.certificate %}
        <div class="achievement-details">
          <div class="achievement-meta"><span>{{ honor.category_label }}</span><time>{{ honor.year }}</time></div>
          <h3 id="{{ honor.id }}-title">{{ honor.title }}</h3>
          <p>{{ honor.description }}</p>
          {% if honor.awarding_body %}<p class="achievement-role"><strong>Awarding institution:</strong> {{ honor.awarding_body }}</p>{% endif %}
          {% include achievement-links.html links=honor.links document=honor.certificate %}
        </div>
      </article>
    {% endfor %}
  </div>
</section>

<section class="detail-section achievement-section" aria-labelledby="service-detail-title">
  <h2 id="service-detail-title">Professional Activities</h2>
  <p class="section-lead">Workshop and challenge organization, community events, and peer review.</p>
  <h3 class="activity-group-title">Organizing &amp; Community</h3>
  <div class="achievement-list activity-list">
    {% for event in activities %}
      <article class="achievement-row activity-row" id="{{ event.id }}" aria-labelledby="{{ event.id }}-title">
        {% include achievement-gallery.html images=event.gallery title=event.organization photos=true %}
        <div class="achievement-details">
          <div class="achievement-meta"><span>{{ event.role }}</span><time>{{ event.period }}</time></div>
          <h3 id="{{ event.id }}-title">{{ event.organization }}</h3>
          <p>{{ event.description }}</p>
          {% if event.link and event.link != '' %}<p class="publication-links"><a href="{{ event.link }}" target="_blank" rel="noopener noreferrer">Official website ↗</a></p>{% endif %}
        </div>
      </article>
    {% endfor %}
  </div>
  <aside class="peer-review" aria-labelledby="peer-review-title">
    <h3 id="peer-review-title">Peer Review</h3>
    <dl>{% for review in reviews %}<div><dt>{{ review.role }}</dt><dd>{{ review.organization }}</dd></div>{% endfor %}</dl>
  </aside>
</section>

<dialog class="gallery-dialog" id="gallery-dialog" aria-labelledby="gallery-dialog-title">
  <div class="gallery-dialog-header">
    <h2 id="gallery-dialog-title">Image gallery</h2>
    <form method="dialog"><button class="gallery-close" type="submit" autofocus aria-label="Close gallery">Close <span aria-hidden="true">×</span></button></form>
  </div>
  <div class="gallery-stage">
    <button class="gallery-arrow gallery-prev" type="button" aria-label="Previous image" hidden>←</button>
    <img id="gallery-dialog-image" alt="">
    <button class="gallery-arrow gallery-next" type="button" aria-label="Next image" hidden>→</button>
    <p class="gallery-error" hidden>Unable to load this image. You can open the original file or try the next image.</p>
  </div>
  <div class="gallery-dialog-footer">
    <div aria-live="polite" aria-atomic="true"><span class="gallery-counter" id="gallery-counter"></span><p id="gallery-caption"></p></div>
    <a id="gallery-original" target="_blank" rel="noopener noreferrer">Open original file ↗</a>
  </div>
</dialog>
<script src="{{ '/assets/js/achievements.js' | relative_url }}?v={{ site.time | date: '%s' }}" defer></script>

{% include footer.html %}
