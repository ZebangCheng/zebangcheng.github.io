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
  <div class="achievement-grid">
    {% for item in site.data.competitions %}
      <article class="achievement-card">
        <div class="achievement-meta"><span>{{ item.rank }}</span><time>{{ item.year }}</time></div>
        <h3>{{ item.title }}</h3>
        <p>{{ item.summary }}</p>
        {% if item.role and item.role != "" %}<p class="achievement-role"><strong>Role:</strong> {{ item.role }}</p>{% endif %}
        {% if item.links %}
          <p class="publication-links">
            {% for link in item.links %}{% if link[1] and link[1] != "" %}<a href="{{ link[1] }}" target="_blank" rel="noopener noreferrer">{{ link[0] | capitalize }}</a>{% endif %}{% endfor %}
          </p>
        {% endif %}
        {% if item.certificate and item.certificate != "" %}
          <a class="certificate-link" href="{{ item.certificate | relative_url }}">View certificate</a>
        {% else %}
          <p class="certificate-placeholder">Certificate image to be added</p>
        {% endif %}
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

{% include footer.html %}
