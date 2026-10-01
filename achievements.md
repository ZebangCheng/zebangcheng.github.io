---
layout: default
title: "Achievements"
description: "Competition results, honors, awards, and academic service by Zebang Cheng."
nav_key: achievements
permalink: /achievements/
---

{% include detail-header.html eyebrow="Recognition & Service" %}

<section class="detail-section" aria-labelledby="competition-title">
  <h2 id="competition-title">Competition Highlights</h2>
  <div class="achievement-list">
    {% for item in site.data.competitions %}
      <article class="achievement-row" id="{{ item.id }}" aria-labelledby="{{ item.id }}-title">
        <div class="achievement-certificate">
          {% if item.certificate_preview and item.certificate_preview != "" and item.certificate_thumbnail and item.certificate_thumbnail != "" %}
            <a class="certificate-thumbnail" href="{{ item.certificate_preview | relative_url }}" data-certificate-preview data-certificate-title="{{ item.title | escape }}" data-certificate-pdf="{{ item.certificate | relative_url }}" aria-label="Enlarge certificate for {{ item.title | escape }}">
              <img src="{{ item.certificate_thumbnail | relative_url }}" alt="{{ item.rank | escape }} certificate for {{ item.title | escape }}" width="210" loading="lazy" decoding="async">
              <span class="certificate-zoom-hint">Click to enlarge <span aria-hidden="true">↗</span></span>
            </a>
          {% elsif item.certificate and item.certificate != "" %}
            <a class="certificate-placeholder" href="{{ item.certificate | relative_url }}">View certificate (PDF)</a>
          {% else %}
            <p class="certificate-placeholder">Certificate to be added</p>
          {% endif %}
        </div>
        <div class="achievement-details">
          <div class="achievement-meta"><span>{{ item.rank }}</span><time>{{ item.year }}</time></div>
          <h3 id="{{ item.id }}-title">{{ item.title }}</h3>
          <p>{{ item.summary }}</p>
          {% if item.role and item.role != "" %}<p class="achievement-role"><strong>Role:</strong> {{ item.role }}</p>{% endif %}
          <div class="publication-links">
            {% for link in item.links %}
              {% if link[1] and link[1] != "" %}
                {% if link[1] contains '://' %}
                  <a href="{{ link[1] }}" target="_blank" rel="noopener noreferrer">{{ link[0] | capitalize }}</a>
                {% else %}
                  <a href="{{ link[1] | relative_url }}">{{ link[0] | capitalize }}</a>
                {% endif %}
              {% endif %}
            {% endfor %}
            {% if item.certificate and item.certificate != "" %}<a href="{{ item.certificate | relative_url }}" target="_blank" rel="noopener noreferrer">Certificate PDF</a>{% endif %}
          </div>
        </div>
      </article>
    {% endfor %}
  </div>
</section>

<section class="detail-section" aria-labelledby="honors-detail-title">
  <h2 id="honors-detail-title">Honors &amp; Awards</h2>
  <ul class="honors-list detail-honors">
    {% for honor in site.data.honors %}
      <li><span><strong>{{ honor.title }}</strong>{% if honor.description and honor.description != "" %}<small>{{ honor.description }}</small>{% endif %}</span><time>{{ honor.year }}</time></li>
    {% endfor %}
  </ul>
</section>

<section class="detail-section" aria-labelledby="service-detail-title">
  <h2 id="service-detail-title">Professional Activities</h2>
  {% include service-list.html %}
</section>

<dialog class="certificate-dialog" id="certificate-dialog" aria-labelledby="certificate-dialog-title">
  <div class="certificate-dialog-header">
    <h2 id="certificate-dialog-title">Competition certificate</h2>
    <form method="dialog"><button class="certificate-dialog-close" type="submit" autofocus>Close <span aria-hidden="true">×</span></button></form>
  </div>
  <div class="certificate-dialog-body"><img id="certificate-dialog-image" alt=""></div>
  <div class="certificate-dialog-footer"><a id="certificate-dialog-pdf" target="_blank" rel="noopener noreferrer">Open original PDF <span aria-hidden="true">↗</span></a></div>
</dialog>
<script src="{{ '/assets/js/achievements.js' | relative_url }}?v={{ site.time | date: '%s' }}" defer></script>

{% include footer.html %}
