---
layout: default
title: "Publications"
description: "Research publications by Zebang Cheng in multimodal intelligence, affective computing, and related areas."
nav_key: publications
permalink: /publications/
---

{% include detail-header.html eyebrow="Research Output" %}

<section class="detail-section" aria-labelledby="all-publications-title">
  <div class="section-heading-row">
    <h2 id="all-publications-title">All Publications</h2>
    <a class="section-more" href="{{ site.data.profile.links.google_scholar }}" target="_blank" rel="noopener noreferrer">Google Scholar ↗</a>
  </div>
  <p class="section-lead">Publications are grouped by year. My name is shown in <strong>bold</strong>; an asterisk (*) denotes equal contribution.</p>
  {% assign publication_years = site.data.publications | map: "year" | uniq %}
  {% for year in publication_years %}
    <div class="year-group">
      <h3>{{ year }}</h3>
      {% assign year_publications = site.data.publications | where: "year", year %}
      {% include publication-list.html publications=year_publications show_summary=true %}
    </div>
  {% endfor %}
</section>

{% include footer.html %}
