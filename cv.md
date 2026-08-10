---
layout: default
title: "Curriculum Vitae"
description: "A concise web curriculum vitae for Zebang Cheng."
nav_key: cv
permalink: /cv/
---

{% include detail-header.html eyebrow="Curriculum Vitae" %}

<p class="cv-note">This web CV is generated from the same data as the homepage and is designed to remain current as the site is updated.</p>

{% include education.html %}

<section aria-labelledby="cv-research-title">
  <h2 id="cv-research-title">Research Interests</h2>
  <p>{{ site.data.profile.research_interests | join: ", " }}.</p>
</section>

<section aria-labelledby="cv-publications-title">
  <div class="section-heading-row">
    <h2 id="cv-publications-title">Selected Publications</h2>
    <a class="section-more" href="{{ '/publications/' | relative_url }}">All publications →</a>
  </div>
  {% assign selected_publications = site.data.publications | where: "selected", true %}
  {% include publication-list.html publications=selected_publications %}
</section>

{% include honors.html %}
{% include service.html %}
{% include footer.html %}
