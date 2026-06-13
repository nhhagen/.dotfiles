---
name: pdf-read
description: >-
  Extract and read text content from PDF files using pdftotext (poppler).
  Use when asked to read, open, view, analyze, summarize, or extract text
  from a PDF file. Triggers on keywords: read pdf, open pdf, pdf content,
  extract text, pdf file, what does this pdf say.
allowed-tools:
  - bash
---

# PDF Read — pdftotext

Extract selectable text from PDF files using **pdftotext** (part of the
poppler utilities).

---

## Prerequisites

Verify `pdftotext` is available before proceeding:

```sh
which pdftotext
```

If not found, install it:

```sh
brew install poppler
```

---

## Basic usage

Output extracted text to stdout so the Bash tool captures it directly — no
temp files needed:

```sh
pdftotext path/to/file.pdf -
```

The trailing `-` sends output to stdout instead of writing a `.txt` file.

---

## Options reference

| Flag | Purpose |
|------|---------|
| `-f <N>` | First page to convert (1-based) |
| `-l <N>` | Last page to convert |
| `-layout` | Preserve original physical layout (columns, spacing) |
| `-nopgbrk` | Omit form-feed characters between pages |
| `-opw <password>` | Owner password for encrypted PDFs |
| `-upw <password>` | User password for encrypted PDFs |
| `-q` | Suppress error/warning messages |

---

## Workflow

### Step 1 — Check tool availability

```sh
which pdftotext
```

If missing, run `brew install poppler` and stop until it is installed.

### Step 2 — Extract full text

```sh
pdftotext path/to/file.pdf -
```

Read the captured output and use it to answer the user's question.

### Step 3 — Large PDFs: extract by page range

If the full document is too large, target specific pages:

```sh
# First 10 pages
pdftotext -f 1 -l 10 path/to/file.pdf -

# Pages 20–30
pdftotext -f 20 -l 30 path/to/file.pdf -
```

### Step 4 — Preserve layout if text appears garbled

Some PDFs use complex column layouts. If extracted text looks disordered, add
`-layout`:

```sh
pdftotext -layout path/to/file.pdf -
```

---

## Empty output — scanned / image-only PDFs

If `pdftotext` returns empty or near-empty text, the PDF likely contains
scanned images with no selectable text layer. Fall back to OCR:

### OCR fallback with tesseract

**Install:**

```sh
brew install tesseract poppler
```

**Convert each PDF page to an image, then OCR it:**

```sh
# Split PDF into per-page PNGs
pdftoppm -r 300 -png path/to/file.pdf /tmp/pdf-pages

# OCR all pages and concatenate output
for img in /tmp/pdf-pages-*.png; do
  tesseract "$img" stdout -l eng
done
```

Use `-l nor` for Norwegian, `-l eng+nor` for mixed language documents.
`tesseract --list-langs` shows all installed language packs.

**Install Norwegian language pack if needed:**

```sh
brew install tesseract-lang
```

---

## Common issues

| Symptom | Cause | Fix |
|---------|-------|-----|
| Empty output | Scanned / image-only PDF | Use OCR fallback (see above) |
| Garbled column order | Multi-column layout | Add `-layout` flag |
| Page-break `^L` characters in output | Default behaviour | Add `-nopgbrk` |
| `Error: Couldn't open file` | Wrong path or permissions | Verify path with `ls -l` |
| `Error: PDF file is damaged` | Corrupt file | Try `qpdf --check file.pdf` to diagnose |
| Encrypted / password-protected | Missing password | Use `-opw` or `-upw` with the password |
