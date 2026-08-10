# Zebang Cheng's academic homepage

This repository powers [zebangcheng.github.io](https://zebangcheng.github.io/). The site uses GitHub Pages and Jekyll so that content can be updated without editing page markup.

## Updating the site

- Personal details and profile links: `_data/profile.yml`
- News: `_data/news.yml`
- Selected publications: `_data/publications.yml`
- Education: `_data/education.yml`
- Honors and awards: `_data/honors.yml`
- Academic service: `_data/service.yml`

Entries are displayed in file order. Put the newest news item first and set `selected: true` for publications that should appear on the homepage.

## Publication format

```yaml
- title: "Paper title"
  authors: "Author One, Zebang Cheng, Author Three"
  venue: "Conference or journal"
  year: 2026
  type: conference
  note: "Optional highlight"
  selected: true
  links:
    paper: "https://example.com/paper"
    project: "https://example.com/project"
    code: "https://github.com/example/project"
```

Leave an unavailable link out instead of adding a placeholder. The template automatically emphasizes `Zebang Cheng` in author lists.

## Validation and publishing

Run the content check before committing:

```bash
ruby scripts/validate_content.rb
```

Opening a pull request also runs this check automatically. After changes are merged into `main`, GitHub Pages publishes the updated site.

The existing Emotion-LLaMA project page remains available under `/Emotion-LLaMA_homepage/`.
