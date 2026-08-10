# Zebang Cheng's academic homepage

This repository powers [zebangcheng.github.io](https://zebangcheng.github.io/). The site uses GitHub Pages and Jekyll so that content can be updated without editing page markup.

## Updating the site

- Personal details and profile links: `_data/profile.yml`
- Main navigation: `_data/navigation.yml`
- News: `_data/news.yml`
- Research directions: `_data/research.yml`
- All publications: `_data/publications.yml`
- Competition results and certificates: `_data/competitions.yml`
- Education: `_data/education.yml`
- Honors and awards: `_data/honors.yml`
- Academic service: `_data/service.yml`

Entries are displayed in file order. Put the newest entries first and set `selected: true` for publications that should appear on the homepage. The Research page references papers by their stable publication `id`, so an ID should not be changed after it is published.

The homepage citation badge reads the live Google Scholar total using `google_scholar_id` from `_data/profile.yml`. Shields.io caches the result for one hour to keep the page fast and avoid direct browser scraping.

The favicon assets are derived from `assets/img/profile.jpg`. When replacing the portrait, regenerate `favicon.ico`, `assets/img/favicon-32x32.png`, and `assets/img/apple-touch-icon.png` so browser tabs and saved mobile shortcuts stay consistent.

## Publication format

```yaml
- id: "short-stable-id"
  short_title: "Short display title"
  title: "Paper title"
  authors: "Author One, Zebang Cheng, Author Three"
  venue: "Conference or journal"
  year: 2026
  type: conference
  note: "Optional highlight"
  summary: "One or two sentences for the full publications page."
  selected: true
  links:
    paper: "https://example.com/paper"
    project: "https://example.com/project"
    code: "https://github.com/example/project"
```

Leave an unavailable link out instead of adding a placeholder. The template automatically emphasizes `Zebang Cheng` in author lists.

## Competition and certificate format

Add results to `_data/competitions.yml`. Until a real certificate is available, leave `certificate` blank and the page will show a neutral placeholder. When adding a certificate, place the optimized image or PDF under `assets/img/achievements/` and use its site path:

```yaml
- id: "challenge-2026"
  title: "Challenge name"
  rank: "1st Place"
  year: 2026
  role: "Team lead"
  summary: "Task, contribution, and result."
  certificate: "/assets/img/achievements/challenge-2026.webp"
  links:
    website: "https://example.com/"
```

Check certificate files for personal identifiers, signatures, and QR codes before publishing them.

## Validation and publishing

Run the content check before committing:

```bash
ruby scripts/validate_content.rb
```

Opening a pull request also runs this check automatically. After changes are merged into `main`, GitHub Pages publishes the updated site.

The existing Emotion-LLaMA project page remains available under `/Emotion-LLaMA_homepage/`.
