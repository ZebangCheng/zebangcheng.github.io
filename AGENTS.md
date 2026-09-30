# Repository Guidelines

## Project Structure & Module Organization

This repository hosts Zebang Cheng's academic homepage using Jekyll and GitHub Pages.

- `_data/*.yml`: profile, publications, research, navigation, news, and other structured content. Make routine content updates here.
- `_layouts/default.html`: shared page shell; `_includes/`: reusable Liquid/HTML sections.
- `index.html` and root Markdown pages such as `research.md` and `publications.md`: page composition and front matter.
- `assets/css/main.css` and `assets/img/`: homepage styles and images.
- `Emotion-LLaMA_homepage/`: standalone project page with its own static assets; preserve its existing URL.
- `scripts/validate_content.rb`: content validation; `.github/workflows/content-check.yml`: CI validation and Jekyll build.

## Build, Test, and Development Commands

Run commands from the repository root:

- `ruby scripts/validate_content.rb`: check YAML structure, required fields, IDs, references, link formats, and required assets.
- `jekyll serve`: build and preview locally at `http://localhost:4000`, rebuilding when files change.
- `jekyll build`: generate the static site in `_site/`; do not commit generated output.

Local preview/build commands require an installed Jekyll environment; this repository has no Gemfile or npm setup. CI runs validation and `actions/jekyll-build-pages` on pull requests and pushes to `main`. Merging into `main` publishes through GitHub Pages.

## Coding Style & Naming Conventions

Use two-space indentation in YAML, HTML/Liquid, CSS, and Ruby. Match surrounding formatting; no formatter or linter is configured. Use descriptive kebab-case IDs and CSS classes, and snake_case YAML keys such as `publication_ids`.

Keep publication IDs stable because research entries and anchors reference them. Entries display in file order: add newest entries first and use `selected: true` for homepage publications. Keep years numeric and flags boolean. Use HTTPS or absolute site paths for links; omit unavailable publication links. Apply `relative_url` to internal template links.

## Testing Guidelines

The Ruby validator is the automated content check; there is no separate test framework, test naming convention, or coverage threshold. Run it before committing. Extend its checks when adding content constraints. For layout changes, also build and inspect affected pages at desktop and mobile widths, including navigation and anchors.

## Commit & Pull Request Guidelines

Follow recent history with short, imperative subjects, such as `Add profile photo favicon` or `Update honors and activities`. Keep changes focused. PRs should describe the change, list validation performed, link relevant issues, and include screenshots for visual changes. Ensure both CI validation and the Jekyll build pass before merging.
