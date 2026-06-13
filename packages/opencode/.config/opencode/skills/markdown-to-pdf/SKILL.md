---
name: markdown-to-pdf
description: >-
  Convert a Markdown document to a branded PDF using pandoc + XeLaTeX +
  eisvogel template, styled with the Coop Masterbrand design tokens (sourced
  from coopnorge/coop-design-tokens). Use when asked to convert, export, or
  render a Markdown file to PDF with Coop branding. Triggers on keywords:
  markdown to pdf, md to pdf, export pdf, pandoc pdf, coop document, branded
  pdf.
---

# Markdown to PDF

Convert a Markdown document to a PDF using **pandoc + XeLaTeX + eisvogel**.
Theme is selected via the `theme` field in the document front-matter.

## Script

One script handles all themes:

| Script | Purpose |
| ------ | ------- |
| `markdown2pdf` | Convert a Markdown file to PDF; theme driven by front-matter |

The script checks all required dependencies at startup and prints the exact
install commands for anything missing.

## Themes

The `theme` front-matter field selects the assets directory used for the
conversion. Supported values:

| Theme | Title page | Headings | Links | Logo |
| ----- | ---------- | -------- | ----- | ---- |
| `coop` (default) | Navy `#003366` | Navy `#003366` | Brand blue `#0050FF` | White Coop logo |
| `generic` | Slate `#435488` | Dark gray | Dark red | None |

If `theme` is omitted, `coop` is used.

## Assets structure

Assets live alongside the script in `packages/scripts/.scripts/markdown2pdf-assets/`:

```text
markdown2pdf-assets/
├── coop/
│   ├── eisvogel.latex        — LaTeX template with Coop colors
│   ├── coop-defaults.yaml    — Pandoc defaults (fonts, layout, colors)
│   ├── coop-logo-white.png   — White Coop logo for the title page
│   ├── coop-logo-white.svg   — Source SVG (white logo)
│   ├── coop-logo.png         — Navy Coop logo for light backgrounds
│   └── coop-logo.svg         — Source SVG (navy logo)
└── generic/
    ├── eisvogel.latex         — LaTeX template with generic colors
    └── generic-defaults.yaml  — Pandoc defaults (fonts, layout)
```

The PNGs are pre-generated from the SVGs using inkscape. If they are missing,
regenerate with:

```sh
ASSETS=$(dirname "$(which markdown2pdf)")/markdown2pdf-assets/coop

inkscape "$ASSETS/coop-logo-white.svg" \
  --export-filename="$ASSETS/coop-logo-white.png" \
  --export-width=400

inkscape "$ASSETS/coop-logo.svg" \
  --export-filename="$ASSETS/coop-logo.png" \
  --export-width=400
```

---

## Coop Masterbrand design tokens

Color values sourced from `coopnorge/coop-design-tokens` —
masterbrand light theme.

| Role | Token | Hex |
| ---- | ----- | --- |
| Background | `neutral.1` | `#FFFFFF` |
| Surface / code bg | `neutral.2` | `#F3F5F7` |
| Primary text | `neutral.11` | `#202327` |
| Secondary text | `neutral.9` | `#66686B` |
| Border / rule | `neutral.4` | `#EAEBEC` |
| Brand navy (headings, chrome) | `dominant.12` | `#003366` |
| Brand blue (links, CTA) | `complementary.12` | `#0050FF` |
| Brand light blue | `accent.12` | `#44AFFC` |
| Brand red | `support2.12` | `#E8002A` |
| Brand yellow | `support3.12` | `#FBD901` |

**Font stack:**

- Body / interface: `Inter` (regular 400, medium 500, bold 700)
- Headings / display: `Inter` (bold 700)
- Monospace / code: `InputMono` (Scale=0.9)

---

## Per-document front-matter

Add a minimal YAML block to the top of the Markdown file if none is present.
Only document-specific fields go here — layout and font variables come from
the theme's defaults file.

```yaml
---
title: "Document Title"
subtitle: "Optional subtitle"
author: "Author Name"
author_title: "Optional job title, shown below author on title page"
date: "2026"
lang: en
theme: coop
---
```

Set `lang: nb` for Norwegian Bokmål or `lang: en` for English. This controls
hyphenation and locale-aware formatting.

### Optional overrides in front-matter

These front-matter keys override the theme defaults when present:

```yaml
# Use generic (unbranded) theme
theme: generic

# Disable TOC for short documents
toc: false

# Custom logo on title page
titlepage-logo: "/path/to/custom-logo.png"
logo-width: 40mm

# Custom header/footer text
header-left: "\\textbf{Team Name}"
footer-center: "Confidential"

# Enable section numbering
numbersections: true
```

---

## Conversion command

```sh
markdown2pdf input.md
markdown2pdf input.md -o output.pdf
```

Output is written to `<input-basename>.pdf` in the same directory as the input
file unless `-o` specifies otherwise.

---

## Workflow

> **Default:** Always use `theme: coop` unless the user explicitly asks for an unbranded PDF.

Follow these steps in order when asked to convert a Markdown file to PDF.

### Step 1 — Prepare the Markdown file

Check whether the file already has a YAML front-matter block (starts with
`---`). If not, prepend the minimal front-matter template from the
Per-document front-matter section above.

Do not overwrite existing front-matter. Patch only missing fields.
Set `theme: generic` only if the user explicitly requests unbranded output.

### Step 2 — Convert

```sh
markdown2pdf "$INPUT_FILE" -o "$OUTPUT_FILE"
```

### Step 3 — Report

Tell the user the absolute path of the output PDF. If pandoc or XeLaTeX
reported errors, surface the relevant lines from stderr.

---

## Common issues

| Symptom | Cause | Fix |
| ------- | ----- | --- |
| `! LaTeX Error: File 'framed.sty' not found` | Incomplete LaTeX install | `tlmgr install framed` |
| `! LaTeX Error: File 'xcolor.sty' not found` | Incomplete LaTeX install | `tlmgr install xcolor` |
| `Error: unsupported theme '...'` | Invalid `theme` value in front-matter | Use `coop` or `generic` |
| `Error: font 'Inter' not found` | Font not installed | `brew install --cask font-inter` |
| `Error: font 'InputMono' not found` | Font not installed | Download from <https://input.djr.com/download/> |
| Logo missing on title page | PNG not generated | Regenerate PNGs (see Assets section) |
| `command not found: xelatex` | MacTeX not on PATH | `eval "$(/usr/libexec/path_helper)"` or restart terminal |
| `command not found: yq` | yq not installed | `brew install yq` |
