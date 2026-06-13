---
name: slide-deck
description: >-
  Generate SVG slide visualizations for presentations, decks, and
  PowerPoint-compatible slides. Use when creating slides, decks, presentations,
  or visualizations in SVG format. Triggers on keywords: slide, slides, deck,
  presentation, powerpoint, visualization.
---

# Slide Deck Skill

Generate SVG slides with a PowerPoint-compatible 16:9 canvas at 2560×1440px
resolution.

## Canvas

```xml
<svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1440" viewBox="0 0 2560 1440">
```

- **Width:** 5120px
- **Height:** 2880px
- **Aspect ratio:** 16:9 (PowerPoint default)
- **viewBox:** `0 0 2560 1440`

## File Conventions

- Naming: `slide-01.svg`, `slide-02.svg`, …
- Save in `./slides/` if that directory exists, otherwise save in the current
  working directory.

## Slide Template Skeleton

```xml
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
     width="5120" height="2880" viewBox="0 0 2560 1440">
  <title>Title</title>
  <defs>
    <!-- gradients, filters, clip paths, symbol icons -->
  </defs>

  <!-- Background -->
  <rect width="2560" height="1440" fill="#ffffff"/>

  <!-- Title area: y=100–280 -->
  <!-- Gap (separator): y=280–320 -->
  <!-- Content area: y=320–1280 -->
  <!-- Gap (separator): y=1280–1320 -->
  <!-- Footer: y=1320–1400 -->
</svg>
```

## Layout Zones

| Zone         | Y range     | X range          | Notes                                        |
| ------------ | ----------- | ---------------- | -------------------------------------------- |
| Title area   | 100 – 280   | 140 – 2420       | Slide title and subtitle                     |
| Gap          | 280 – 320   | —                | Reserved whitespace — use for decorative rule or accent bar only |
| Content area | 320 – 1280  | 140 – 2420       | Main body: text, charts, etc.                |
| Gap          | 1280 – 1320 | —                | Reserved whitespace — use for decorative rule or accent bar only |
| Footer       | 1320 – 1400 | 140 – 2420       | Captions, page numbers, logos                |
| Side margins | —           | 0–140, 2420–2560 | Keep content clear of edges                  |

## Typography Scale

| Role      | Size  | Weight | Line height |
| --------- | ----- | ------ | ----------- |
| Title     | 112px | 700    | 168px       |
| Heading   | 84px  | 600    | 126px       |
| Body      | 56px  | 400    | 84px        |
| Sub-body  | 48px  | 400    | 72px        |
| Caption   | 42px  | 400    | 63px        |
| Monospace | 44px  | 400    | 66px        |

Prose font stack: `Inter`, `Helvetica Neue`, `Arial`, `sans-serif`

Monospace font stack: `JetBrains Mono`, `Fira Code`, `Cascadia Code`, `Courier New`, `monospace`

Set `font-family` on the root `<svg>` element or per `<text>` element.

Use `dominant-baseline="auto"` for standalone prose text (baseline at the given
`y`). Use `dominant-baseline="middle"` when aligning text with a sibling marker
such as a bullet circle or rect (see Bullet Lists).

## Color Palette

### Coop Brand Palette — Light

Sourced from `coopnorge/coop-design-tokens` — masterbrand light theme. Use
these as the default palette for Coop-branded slides.

| Role             | Token            | Hex       |
| ---------------- | ---------------- | --------- |
| Background       | neutral.1        | `#ffffff` |
| Surface          | neutral.2        | `#F3F5F7` |
| Primary text     | neutral.11       | `#202327` |
| Secondary text   | neutral.9        | `#66686B` |
| Border / rule    | neutral.4        | `#EAEBEC` |
| Brand navy       | dominant.12      | `#003366` |
| Brand dark navy  | dominant.9       | `#002b57` |
| Brand blue (CTA) | complementary.12 | `#0050FF` |
| Brand light blue | accent.12        | `#44AFFC` |
| Brand red        | support2.12      | `#E8002A` |
| Brand yellow     | support3.12      | `#FBD901` |

The dominant accent for slide chrome (left bar, dividers, headings) is
`#003366` (brand navy). Use `#0050FF` for interactive / CTA elements and
`#44AFFC` for lighter accent touches.

### Coop Brand Palette — Dark

Sourced from `coopnorge/coop-design-tokens` — masterbrand dark theme. Use
for dark-background Coop slides.

| Role             | Token            | Hex       |
| ---------------- | ---------------- | --------- |
| Background       | neutral.1        | `#13181f` |
| Surface          | neutral.2        | `#192029` |
| Primary text     | neutral.11       | `#ebeced` |
| Secondary text   | neutral.9        | `#949aa1` |
| Border / rule    | neutral.4        | `#262e3a` |
| Brand navy       | dominant.12      | `#BDDEFF` |
| Brand dark navy  | dominant.2       | `#111C27` |
| Brand blue (CTA) | complementary.12 | `#0553FF` |
| Brand light blue | accent.12        | `#66c4ff` |
| Brand red        | support2.12      | `#E8002A` |
| Brand yellow     | support3.12      | `#FBD901` |

In dark mode the slide background is `#13181f`, primary text is `#ebeced`,
and the chrome accent should use `#BDDEFF` (light navy) rather than the dark
`#003366`.

### Neutral Fallback Palette

Use when slides are not Coop-branded.

| Role           | Value     |
| -------------- | --------- |
| Background     | `#ffffff` |
| Primary text   | `#1a1a1a` |
| Secondary text | `#555555` |
| Accent         | `#0066cc` |
| Subtle bg      | `#f5f5f5` |
| Border/rule    | `#dddddd` |

Override per slide as needed.

## Multi-Column and Split Layouts

Use `<g>` elements to define column regions. The content area (x=140–2420,
y=320–1280) is divided by gutters of **80px**.

### Two-column 50/50

Content area width = 2280px. Gutter = 80px. Each column = (2280 − 80) / 2 = **1100px**.

| Column | X start | X end | Width |
| ------ | ------- | ----- | ----- |
| Left   | 140     | 1240  | 1100  |
| Right  | 1320    | 2420  | 1100  |

### Two-column 60/40

| Column | X start | X end | Width |
| ------ | ------- | ----- | ----- |
| Left   | 140     | 1420  | 1280  |
| Right  | 1500    | 2420  | 920   |

### Two-column 40/60

| Column | X start | X end | Width |
| ------ | ------- | ----- | ----- |
| Left   | 140     | 1060  | 920   |
| Right  | 1140    | 2420  | 1280  |

### Content + image (text left, visual right — 50/50)

Place prose or bullet list in the left column and an SVG illustration,
diagram, or code block in the right column. Both columns share the same
y range: **320–1280**.

```xml
<!-- Left column: text -->
<g id="col-left">
  <text x="140" y="380" font-size="84" font-weight="600" fill="#202327">Heading</text>
  <!-- body text / bullets below -->
</g>

<!-- Right column: visual -->
<g id="col-right">
  <rect x="1320" y="320" width="1100" height="960" rx="12" fill="#F3F5F7"/>
  <!-- diagram, chart, or code block -->
</g>
```

### Three-column 33/33/33

Content area width = 2280px. Two gutters = 160px. Each column = (2280 − 160) / 3 ≈ **707px**
(left and right get 707px, center gets 706px to absorb the remainder).

| Column | X start | X end | Width |
| ------ | ------- | ----- | ----- |
| Left   | 140     | 847   | 707   |
| Center | 927     | 1633  | 706   |
| Right  | 1713    | 2420  | 707   |

---

## Bullet Lists

Render each bullet as a marker element followed by a `<text>` element. Do
**not** use HTML list elements — SVG has none.

### Spacing

| Level | Left indent (x) | Marker x  | Vertical step |
| ----- | --------------- | --------- | ------------- |
| 1     | 220             | 160       | 90px          |
| 2     | 340             | 280       | 80px          |
| 3     | 460             | 400       | 72px          |

- First bullet `y`: **400** (80px below content area top at y=320).
- Increase `y` by the vertical step for each subsequent item at the same
  level, or by the child level's step when nesting.

### Overflow

The usable height from first bullet (y=400) to the overflow threshold (y=1240)
is **840px**. At level-1 only (step=90px) this allows ~9 items before
overflow. If the calculated final bullet `y` exceeds **1240** (40px of
breathing room before the footer):

1. Reduce all step sizes by 20% uniformly (e.g. 90→72, 80→64, 72→58), or
2. Split the list across two slides, continuing with a "…continued" label.

### Markers

- **Level 1:** filled circle `r="10"`, color matches the heading/accent.
- **Level 2:** filled circle `r="7"`, color `neutral.9` (`#66686B` light /
  `#949aa1` dark).
- **Level 3:** filled square `8×8` rect, same color as level 2.

### Per-line pattern

```xml
<!-- Level 1 bullet -->
<circle cx="160" cy="{Y}" r="10" fill="#003366"/>
<text x="220" y="{Y}" font-family="Inter,'Helvetica Neue',Arial,sans-serif"
      font-size="56" fill="#202327" dominant-baseline="middle">Bullet text</text>

<!-- Level 2 bullet -->
<circle cx="280" cy="{Y}" r="7" fill="#66686B"/>
<text x="340" y="{Y}" font-family="Inter,'Helvetica Neue',Arial,sans-serif"
      font-size="48" fill="#202327" dominant-baseline="middle">Sub-item</text>

<!-- Level 3 bullet — rect y = text Y − 4 (half of 8px square height) -->
<rect x="398" y="{marker_y}" width="8" height="8" fill="#66686B"/>
<text x="460" y="{Y}" font-family="Inter,'Helvetica Neue',Arial,sans-serif"
      font-size="42" fill="#202327" dominant-baseline="middle">Detail</text>
```

Where `{marker_y}` = text `{Y}` − 4 (centers the 8px square on the text
baseline when using `dominant-baseline="middle"`). Compute this as a literal
integer — do not embed arithmetic inside SVG attribute strings.

### Spacing between groups

Add **40px** of extra vertical space before the first child bullet and after
returning to a parent level, to visually separate nesting levels.

---

## Icon and Logo Placement

### Logo safe zones

The layout zones table defines the title area starting at y=100. The top-right
logo must sit entirely above that boundary (y=0–100).

| Position     | X    | Y  | Max width | Max height | Notes                                    |
| ------------ | ---- | -- | --------- | ---------- | ---------------------------------------- |
| Top-right    | 2200 | 20 | 200       | 60         | y=20–80: clear of title area (y≥100); right edge at 2400, 20px from margin |
| Footer-left  | 140  | 1340 | 160     | 60         |                                          |
| Footer-right | 2240 | 1340 | 160     | 60         | Right edge at 2400, 20px from right margin |

Logos must stay within the side margins (x=140–2420) and must not overlap
the title or content zones.

### Inline SVG icons

Embed icons as `<symbol>` elements inside `<defs>` and reference them via
`<use>`. `<symbol>` provides its own `viewBox` and viewport, enabling clean
scaling via `width` and `height` on `<use>`. Do **not** use `<g>` inside
`<defs>` for icons — a `<g>` has no viewport and does not scale correctly.

```xml
<defs>
  <symbol id="icon-check" viewBox="0 0 64 64">
    <!-- 64×64 icon, drawn at origin -->
    <circle cx="32" cy="32" r="30" fill="none" stroke="#003366" stroke-width="4"/>
    <polyline points="18,32 28,44 48,22" fill="none" stroke="#003366"
              stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
  </symbol>
</defs>

<!-- Place the icon at (x, y) with explicit size -->
<use href="#icon-check" xlink:href="#icon-check" x="140" y="400" width="56" height="56"/>
```

Recommended icon sizes:

| Context              | Size    |
| -------------------- | ------- |
| Inline (beside text) | 56×56   |
| Feature icon         | 96×96   |
| Hero / large         | 128×128 |

Include `xlink:href` alongside `href` on all `<use>` elements for compatibility
with PowerPoint versions prior to 365. Add `xmlns:xlink="http://www.w3.org/1999/xlink"`
to the root `<svg>` element (it is already included in the skeleton template).

---

## Dark Mode

### When to use dark theme

Apply the **Coop Brand Palette — Dark** when any of the following is true:

- The user explicitly requests "dark", "dark mode", "dark background", or
  "dark slides".
- The user's existing slides already use a dark background.

Default to the **Coop Brand Palette — Light** in all other cases. Do **not**
infer dark mode from the presentation topic (e.g. developer talks).

### Switching the palette

Replace the background fill and all text/chrome colors with their dark
equivalents. Key substitutions:

| Element            | Light value | Dark value |
| ------------------ | ----------- | ---------- |
| Slide background   | `#ffffff`   | `#13181f`  |
| Surface / card     | `#F3F5F7`   | `#192029`  |
| Primary text       | `#202327`   | `#ebeced`  |
| Secondary text     | `#66686B`   | `#949aa1`  |
| Border / rule      | `#EAEBEC`   | `#262e3a`  |
| Chrome accent      | `#003366`   | `#BDDEFF`  |
| Bullet level-2 / 3 | `#66686B`   | `#949aa1`  |
| Brand red          | `#E8002A`   | `#E8002A` (unchanged) |
| Brand yellow       | `#FBD901`   | `#FBD901` (unchanged — use sparingly on dark bg) |

---

## Code Blocks

Use **full token-level syntax highlighting** with the Material Theme palette on
a dark background. Code blocks always use the Material Theme dark background
(`#263238`) regardless of the slide's light/dark theme.

### Code block container

```xml
<rect x="140" y="320" width="2280" height="960" rx="12" fill="#263238"/>
```

> **Note:** The container starts at y=320 (top of the content area) and
> assumes the slide has **no separate heading** in the content zone. If a
> heading is present above the code block, shift the container down to y=400
> and reduce its height accordingly. The first code line `y` is always
> `container_y + 80` (e.g. **400** when container_y=320, **480** when
> container_y=400).

Add a darker line-number strip on the left:

```xml
<rect x="140" y="320" width="100" height="960" fill="#1e2a30"/>
```

### Font

Family: `JetBrains Mono`, `Fira Code`, `Cascadia Code`, `Courier New`,
`monospace`

Three sizes are available. Choose based on how much code fits on the slide.
**Default to Medium (44px)** unless the slide is code-only with many lines,
in which case use Small (36px). Use Large (56px) only for one- or two-line
highlight snippets — it matches the Body text size and can look unintentionally
large in mixed-content slides.

| Size   | Font size | Line height | Line number size |
| ------ | --------- | ----------- | ---------------- |
| Small  | 36px      | 54px        | 28px             |
| Medium | 44px      | 66px        | 36px             |
| Large  | 56px      | 84px        | 44px             |

- First line `y`: `container_y + 80` (e.g. **400** when container starts at y=320)
- Code starts at `x="260"` (after line number strip, which ends at x=240,
  leaving 20px of padding)

### Line numbers

- Rendered as separate `<text>` elements at `x="190"` with
  `text-anchor="middle"` (center of the 100px strip: 140 + 100/2 = 190)
- Color: `#546e7a`
- Font size: see size table above

### Indentation

Each indent level shifts `x` by a multiple of the font size. The per-level
shift approximates 2–3 monospace character widths (a monospace glyph is
roughly 0.6× the font size wide; e.g. at 44px Medium, one character ≈ 26px,
so 88px ≈ 3 character widths):

| Size   | Per-level shift | Indent 0 | Indent 1 | Indent 2 | Indent 3 |
| ------ | --------------- | -------- | -------- | -------- | -------- |
| Small  | 72px            | 260      | 332      | 404      | 476      |
| Medium | 88px            | 260      | 348      | 436      | 524      |
| Large  | 112px           | 260      | 372      | 484      | 596      |

### Token colors (Material Theme)

| Token             | Color     | Examples                                                                  |
| ----------------- | --------- | ------------------------------------------------------------------------- |
| Background        | `#263238` | code block fill                                                           |
| Line number strip | `#1e2a30` | left gutter                                                               |
| Default text      | `#eeffff` | identifiers, operators, braces                                            |
| Keywords          | `#c792ea` | `func`, `if`, `package`, `import`, `return`, `var`, `const`, `type`, `for`, `range` |
| Strings           | `#c3e88d` | `"hello"`, `"net/http"`                                                   |
| Numbers           | `#f78c6c` | `42`, `3.14`                                                              |
| Comments          | `#546e7a` | `// ...`, `/* ... */`                                                     |
| Functions         | `#82aaff` | function names at call/definition site                                    |
| Types / Classes   | `#ffcb6b` | type names, struct names                                                  |
| Punctuation       | `#89ddff` | `(`, `)`, `{`, `}`, `.`, `:=`, `==`, `->`                                |

### Per-line rendering pattern

Each line is two sibling `<text>` elements — one for the line number, one for
the code. Substitute `{font_size}` and `{line_num_size}` from the size table
above:

```xml
<!-- Line N -->
<text x="190" y="{Y}" font-family="'JetBrains Mono','Fira Code','Courier New',monospace"
      font-size="{line_num_size}" fill="#546e7a" text-anchor="middle">{N}</text>
<text x="{indent_x}" y="{Y}" font-family="'JetBrains Mono','Fira Code','Courier New',monospace"
      font-size="{font_size}">
  <tspan fill="#c792ea">func</tspan>
  <tspan fill="#eeffff"> </tspan>
  <tspan fill="#82aaff">handler</tspan>
  <tspan fill="#89ddff">(</tspan>
  ...
</text>
```

Break the line into `<tspan>` elements — one per token or contiguous run of
tokens sharing the same color. Whitespace between `<tspan>` tags is collapsed
by XML parsers and will not render. To render a space between tokens, include
it as a literal character inside a `<tspan>`, e.g.
`<tspan fill="#eeffff"> </tspan>`.

### Blank lines

Render only the line number `<text>`; omit the code `<text>`.

---

## SVG Best Practices

- Use `<defs>` for reusable gradients, clip paths, filters, and icon symbols.
- Group related elements with `<g>` and add descriptive `id` attributes.
- Always include a `<title>` element for accessibility. Add `xml:lang="nb"` on
  the root `<svg>` when slide content is in Norwegian.
- Prefer `<text>` with explicit `x`, `y`, `font-size`, and `fill` attributes.
- Use `dominant-baseline="auto"` and `text-anchor="start"` as defaults for
  prose text. Use `dominant-baseline="middle"` when vertically aligning a
  `<text>` with a sibling marker (bullet circle/rect) — do not mix the two
  defaults on the same slide without a comment.
- For centered text: `text-anchor="middle"` with `x` at the horizontal midpoint
  (1280).
- Avoid embedded raster images where possible; use SVG shapes and paths.

### Text wrapping

SVG `<text>` does **not** wrap automatically. Long text will silently overflow
the slide boundary. Rules:

- Break long text manually into multiple `<tspan>` elements using
  `dy` for line advancement and `x` reset to the left indent:

  ```xml
  <text x="140" y="400" font-size="56" fill="#202327">
    <tspan x="140">First line of a long paragraph that</tspan>
    <tspan x="140" dy="84">continues on the next line.</tspan>
  </text>
  ```

  Omit `dy` on the first `<tspan>` — it inherits position from the parent
  `<text>`. Set `dy` on subsequent tspans to the line height from the
  Typography Scale (e.g. 84px for 56px Body).

- Estimate maximum characters per line:

  | Font size | Column width | ~Chars/line |
  | --------- | ------------ | ----------- |
  | 56px Body | 2280px (full) | ~45 chars  |
  | 56px Body | 1100px (50/50 col) | ~22 chars |
  | 48px Sub-body | 1100px | ~25 chars  |
  | 42px Caption | 1100px | ~29 chars  |

- If text still overflows after manual wrapping, reduce font size to the next
  scale step (e.g. Body 56px → Sub-body 48px → Caption 42px).

---

## Special Slide Layouts

### Title slide

Used as the first slide of a deck. No footer line; background fills the full
canvas with the brand navy.

```xml
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
     width="2560" height="1440" viewBox="0 0 2560 1440">
  <title>Slide 01 — Title</title>
  <!-- Full-bleed background -->
  <rect width="2560" height="1440" fill="#003366"/>
  <!--
    Vertical layout: title block (title + subtitle) centered on the canvas.
    Canvas center = y=720. Title 112px + gap 40px + subtitle 56px = 208px total block.
    Block top = 720 − 104 = 616. Title baseline (dominant-baseline="auto") at 616+112=728 → use 660.
    Using dominant-baseline="central" places the glyph center at the given y.
    Title center at y=660, subtitle center at y=800 (660 + 112/2 + 40 + 56/2 = 660+56+40+28=784, round to 800).
  -->
  <text x="1280" y="660" font-family="Inter,'Helvetica Neue',Arial,sans-serif"
        font-size="112" font-weight="700" fill="#ffffff"
        text-anchor="middle" dominant-baseline="central">Presentation Title</text>
  <text x="1280" y="800" font-family="Inter,'Helvetica Neue',Arial,sans-serif"
        font-size="56" font-weight="400" fill="#BDDEFF"
        text-anchor="middle" dominant-baseline="central">Subtitle or date</text>
</svg>
```

In dark mode, keep the full-bleed background but use `#192029` instead of
`#003366`; title text `#ebeced`, subtitle `#949aa1`.

### Section divider slide

Used to introduce a new section within a deck. Large centered text on an
accent-color background.

```xml
<!-- Full-bleed accent background -->
<rect width="2560" height="1440" fill="#0050FF"/>
<!-- Section label: glyph center at canvas center y=720 -->
<text x="1280" y="720" font-family="Inter,'Helvetica Neue',Arial,sans-serif"
      font-size="112" font-weight="700" fill="#ffffff"
      text-anchor="middle" dominant-baseline="central">Section Name</text>
```

### Blank / image-only slide

Use the standard skeleton with no text elements. Place the visual in the full
drawable area (excluding side margins): x=140–2420, y=100–1400. This
intentionally spans all zones (title, content, footer). For a truly full-bleed
visual, use x=0, y=0, width=2560, height=1440. Include a `<title>` for
accessibility even if the slide has no visible text.

### No-title (full-content) slide

Used when a graphic, diagram, chart, or code block needs maximum vertical space
and no slide heading is required. The entire area from y=100 to y=1280 is
available for content (1180px tall, vs 960px in the standard layout).

```xml
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
     width="2560" height="1440" viewBox="0 0 2560 1440">
  <title>Slide N — Description</title>
  <!-- Background -->
  <rect width="2560" height="1440" fill="#ffffff"/>

  <!-- Full content area: x=140, y=100, width=2280, height=1180 -->
  <!-- No title zone — content fills y=100 to y=1280 -->

  <!-- Footer -->
  <!-- y=1320–1400, x=140–2420 -->
</svg>
```

For a code block on a no-title slide, use:

```xml
<rect x="140" y="100" width="2280" height="1180" rx="12" fill="#263238"/>
<rect x="140" y="100" width="100" height="1180" fill="#1e2a30"/>
```

First code line `y` = 100 + 80 = **180**.

---

## Exporting to PDF

Convert the SVG slides to a single multi-page PDF using `inkscape` (to render
each slide) and `pdfunite` (to merge the per-slide PDFs).

### Prerequisites

| Tool       | Install                        |
| ---------- | ------------------------------ |
| `inkscape` | `brew install inkscape`        |
| `pdfunite` | `brew install poppler`         |

### Page size

By default inkscape maps SVG user units (px at 96 dpi) to PDF points, producing
1920×1080 pt pages. To match the SVG canvas exactly (**2560×1440 pt**) the SVG
`width` and `height` attributes must carry explicit `pt` units before inkscape
reads them. Rewrite them on the fly with `sed` — no permanent changes to the
source files.

### Step 1 — Convert each SVG to a single-page PDF

Run `inkscape` once per slide, rewriting units via process substitution so the
PDF page is exactly 2560×1440 pt:

```sh
inkscape --export-filename=slide-01.pdf --export-area-page \
  <(sed 's/width="2560" height="1440"/width="2560pt" height="1440pt"/' slide-01.svg)
```

Or as a shell loop (from the directory containing the slides):

```sh
for svg in slide-*.svg; do
  inkscape --export-filename="${svg%.svg}.pdf" --export-area-page \
    <(sed 's/width="2560" height="1440"/width="2560pt" height="1440pt"/' "$svg")
done
```

### Step 2 — Merge into one PDF

```sh
pdfunite $(ls slide-*.pdf | sort) deck.pdf
```

If there is a `slide-title.pdf` it goes first.

The output file (`deck.pdf`) is the final presentation-ready PDF. Name it after
the deck, e.g. `quarterly-review.pdf`.

### Full one-liner (loop + merge)

```sh
for svg in slide-*.svg; do
  inkscape --export-filename="${svg%.svg}.pdf" --export-area-page \
    <(sed 's/width="2560" height="1440"/width="2560pt" height="1440pt"/' "$svg")
done && pdfunite $(ls slide-*.pdf | sort) deck.pdf
```

### Notes

- Run all commands from the directory that contains the slide files.
- Requires bash or zsh (for process substitution `<(...)`).
- Inkscape 1.x is required; earlier versions use a different CLI syntax.
- The intermediate per-slide PDFs can be deleted after merging.
- If `pdfunite` is unavailable, `gs` (Ghostscript) is an alternative:

  ```sh
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=deck.pdf slide-*.pdf
  ```

---

## Speaker Notes

Speaker notes live in a single Markdown file alongside the slide SVGs.

### File name and location

Save the notes file as `speaker-notes.md` in the same directory as the slide files
(i.e. `./slides/speaker-notes.md` when slides are in `./slides/`, otherwise
`./speaker-notes.md`).

### Structure

Each slide gets one section. The section heading is the slide number and title,
followed by an embedded image of the slide, then the spoken notes in prose or
bullet form.

```markdown
# Speaker Notes

## Slide 01 — Title

![Slide 01](./slide-01.svg)

Opening remarks. Introduce yourself and the topic.

---

## Slide 02 — Agenda

![Slide 02](./slide-02.svg)

- Walk through the agenda items briefly.
- Set expectations for the session length.

---
```

### Rules

- One `##` section per slide, in order.
- The heading must match the pattern `Slide NN — <title>` where `NN` is the
  zero-padded slide number (e.g. `01`, `02`).
- Embed the slide as a Markdown image immediately after the heading, before
  any prose. Use a relative path matching the slide file name.
- Separate each slide section with a horizontal rule (`---`).
- Write notes as spoken language — what you would say aloud, not bullet
  summaries of the slide content (unless a checklist of talking points is
  genuinely useful).
- Keep notes concise: aim for 3–8 sentences or bullet points per slide.
