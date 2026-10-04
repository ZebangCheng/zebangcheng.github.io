# Achievements 素材维护指南

## 页面分工

- 首页 Honors & Awards 只显示 `_data/honors.yml` 中 `featured: true` 的非比赛荣誉，点击名称跳到详情。
- Achievements 的 Competition Highlights 集中展示所有比赛；Honors & Awards 展示全部非比赛荣誉、说明和证书；Professional Activities 展示组织活动相册及审稿经历。
- CV 保留全部非比赛荣誉的文字列表。审稿经历不需要相册。

## 文件目录

所有图片按「类别 / 条目 ID」收纳。目录已经创建，可以直接放入素材：

```text
assets/img/achievements/
├── competitions/<competition-id>/
│   ├── certificate.webp          # 放大预览
│   └── certificate-thumb.webp    # 页面缩略图
├── honors/<honor-id>/
│   ├── certificate.pdf           # 后续新增的原始奖状（可选）
│   ├── certificate.webp
│   └── certificate-thumb.webp
├── activities/<activity-id>/
│   ├── event-01.jpg              # 第一张原图/大图
│   ├── event-01-thumb.webp
│   ├── event-02.jpg
│   └── event-02-thumb.webp
└── placeholders/                # 共享占位图，不是真实活动照片或奖状
```

已有的六份比赛 PDF 保留在此目录第一层，继续使用已公开的英文文件名，避免破坏之前分享的下载链接。其预览图已经归入各自的 `competitions/<id>/` 目录。以后新增的 PDF 请放到对应条目目录。

| 活动 | 照片目录（相对 `assets/img/achievements/`） |
| --- | --- |
| NeuroMM 2026 | `activities/neuromm-2026/` |
| MER2026 | `activities/mer-2026/` |
| VALSE 2026 Special Corner | `activities/valse-2026/` |
| MER2025 | `activities/mer-2025/` |

| 荣誉 | 奖状目录（相对 `assets/img/achievements/`） |
| --- | --- |
| 2026 Pathfinder Program | `honors/cast-leadership-program-2026/` |
| 2025 CAST 博士生专项 | `honors/cast-phd-program/` |
| 优秀硕士毕业生 | `honors/outstanding-masters-graduate/` |
| 优秀硕士论文 | `honors/outstanding-masters-thesis/` |
| 2024 国家奖学金 | `honors/national-scholarship-2024/` |
| 2024 学业奖学金一等奖 | `honors/graduate-scholarship-2024/` |
| 2023 学业奖学金一等奖 | `honors/graduate-scholarship-2023/` |
| 2022 研究生入学奖学金 | `honors/graduate-admission-scholarship/` |
| 2019 国家励志奖学金 | `honors/national-encouragement-scholarship/` |

## 替换活动占位图

将真实照片放入对应目录，然后编辑 `_data/service.yml` 中相应条目的 `gallery`。每个列表项是一张图片，列表顺序就是相册顺序；可以添加任意张，也可以删掉暂不需要的占位项。例如：

```yaml
gallery:
  - src: "/assets/img/achievements/activities/valse-2026/event-01.jpg"
    thumbnail: "/assets/img/achievements/activities/valse-2026/event-01-thumb.webp"
    alt: "Participants at the VALSE 2026 Special Corner"
    caption: "VALSE 2026 Special Corner — group photo."
  - src: "/assets/img/achievements/activities/valse-2026/event-02.jpg"
    thumbnail: "/assets/img/achievements/activities/valse-2026/event-02-thumb.webp"
    alt: "A discussion at the VALSE 2026 Special Corner"
    caption: "Discussion session."
```

图注应描述真实画面。替换后删除 `placeholder: true`；它只用于 `placeholders/` 下的占位图。未提供 `thumbnail` 时会使用 `src`。不要把真实照片覆盖到共享占位文件上，否则多个活动会一起变更。

## 添加奖学金、荣誉或比赛奖状

编辑 `_data/honors.yml` 或 `_data/competitions.yml` 的对应条目，将空的 `gallery: []` 替换为：

```yaml
certificate: "/assets/img/achievements/honors/national-scholarship-2024/certificate.pdf"
gallery:
  - src: "/assets/img/achievements/honors/national-scholarship-2024/certificate.webp"
    thumbnail: "/assets/img/achievements/honors/national-scholarship-2024/certificate-thumb.webp"
    alt: "2024 National Scholarship certificate"
    caption: "National Scholarship, 2024."
```

没有 PDF 时省略 `certificate`；点击预览仍可放大图片。没有真实证书图片时保留空列表，页面会显示明确的占位，不生成虚构奖状。荣誉可通过 `description`、`awarding_body`（有据可查时填写）和 `links` 补充细节。

## 图片规格与检查

- 使用小写英文和连字符命名，不使用中文、空格或相机自动文件名。
- 建议大图长边 1600–2400 像素，缩略图长边约 640 像素。保留原比例；证书预览不要裁掉文字。
- 页面统一采用 4:3 的缩略图框；活动照片可在缩略图中裁切，放大后始终完整显示。
- 相册支持前后按钮、键盘左右键、触屏滑动、Escape 关闭和点击背景关闭。无 JavaScript 时仍可打开原图。
- 更新图片时使用新文件名，避免浏览器缓存旧图；同一活动的多张照片使用 `event-01`、`event-02` 等编号。
- 发布前运行 `ruby scripts/validate_content.rb` 和 `ruby scripts/validate_achievements.rb`，再运行 Jekyll 构建。CI 会检查图片存在、图注、占位标记和重复 ID。
