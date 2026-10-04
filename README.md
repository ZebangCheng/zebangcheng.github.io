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

The homepage citation badge reads the live Google Scholar total using `google_scholar_id` from `_data/profile.yml`. Paper-specific citation badges use the same shared Shields.io dynamic-regex component, with a paper's English Google Scholar `source_url` and `cites_id` under `google_scholar` in `_data/publications.yml`. The paper badge extracts that article's "Cited by" count and links to its citing articles. Shields.io caches results for one hour; counts are fetched by Shields.io rather than scraped in the visitor's browser.

The 1280-pixel portrait is `assets/img/zebang-cheng-portrait.jpg`; its path and dimensions are set in `_data/profile.yml` for social sharing. The homepage uses CSS to frame the face while preserving the original image. Existing favicons use a close-up of the same photo. When choosing a different portrait, update the photo dimensions, adjust its CSS framing, and regenerate `favicon.ico`, `assets/img/favicon-32x32.png`, and `assets/img/apple-touch-icon.png`.

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

Publications use a text-only list with title, venue, authors, notes, and resource links.

Optional `metrics` provide a source link, API endpoint and count field, plus a verified `value` and `observed_on` date as an offline fallback. Emotion-LLaMA uses this for GitHub stars; the browser refreshes counts and caches successful responses for six hours. Update fallback counts and dates together when refreshing this data. Its citation badge uses Google Scholar, independently of the GitHub metric cache.

`image-source/` is a local staging folder for replacement portraits, excluded from Git and the published site. Add only the chosen web-ready portrait to `assets/img/`.

## Achievements and image galleries

Competition results belong only in `_data/competitions.yml`. Non-competition honors go in `_data/honors.yml`; `featured: true` selects the concise homepage list, while Achievements and the CV include every honor. Event records in `_data/service.yml` use `kind: event` and support photo galleries; reviewer records use `kind: review`.

Store media by category and stable entry ID under `assets/img/achievements/`. Set `gallery: []` until a certificate is available. Each gallery item needs an image, alternative text, and a caption; a smaller thumbnail is optional:

```yaml
- id: "challenge-2026"
  title: "Challenge name"
  rank: "1st Place"
  year: 2026
  role: "Team lead"
  summary: "Task, contribution, and result."
  certificate: "/assets/img/achievements/competitions/challenge-2026/certificate.pdf"
  gallery:
    - src: "/assets/img/achievements/competitions/challenge-2026/certificate.webp"
      thumbnail: "/assets/img/achievements/competitions/challenge-2026/certificate-thumb.webp"
      alt: "First-place certificate for Challenge name"
      caption: "1st Place, 2026."
  links:
    website: "https://example.com/"
```

Check certificate files for personal identifiers, signatures, and QR codes before publishing them.

Rows share a 4:3 thumbnail frame on the left, with full images in a click-to-enlarge gallery. Multiple images support buttons, arrow keys, and touch swipes. Existing PDF download URLs remain unchanged. Shared placeholder images are explicitly labeled and require `placeholder: true`; remove that flag when replacing them with real photos.

See [the achievement media guide](ACHIEVEMENT_MEDIA.md) for prepared folders, photo naming, image sizes, and examples for activities and scholarships.

## Validation and publishing

Run the content check before committing:

```bash
ruby scripts/validate_content.rb
ruby scripts/validate_achievements.rb
```

Opening a pull request runs both checks and a Jekyll build automatically. After changes are merged into `main`, GitHub Pages publishes the updated site.

The existing Emotion-LLaMA project page remains available under `/Emotion-LLaMA_homepage/`.
