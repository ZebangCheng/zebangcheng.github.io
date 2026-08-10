---
layout: default
title: "Research"
description: "Research directions in multimodal large language models, affective computing, and multimodal agents."
nav_key: research
permalink: /research/
---

{% include detail-header.html eyebrow="Research Agenda" %}

<section class="detail-section" aria-labelledby="research-directions-title">
  <h2 id="research-directions-title">Research Directions</h2>
  <p class="section-lead">I study how multimodal systems can perceive, reason about, and respond to human states in realistic environments.</p>
  <div class="research-list">
    {% for direction in site.data.research %}
      <article class="research-item" id="{{ direction.id }}">
        <p class="research-kicker">{{ direction.kicker }}</p>
        <h3>{{ direction.title }}</h3>
        <p>{{ direction.summary }}</p>
        {% if direction.focus %}
          <ul class="topic-list">
            {% for topic in direction.focus %}<li>{{ topic }}</li>{% endfor %}
          </ul>
        {% endif %}
        {% if direction.publication_ids %}
          <p class="representative-links"><strong>Representative work:</strong>
            {% for publication_id in direction.publication_ids %}
              {% assign paper = site.data.publications | where: "id", publication_id | first %}
              {% if paper %}<a href="{{ '/publications/#' | append: paper.id | relative_url }}">{{ paper.short_title | default: paper.title }}</a>{% unless forloop.last %}, {% endunless %}{% endif %}
            {% endfor %}
          </p>
        {% endif %}
      </article>
    {% endfor %}
  </div>
</section>

{% include footer.html %}
