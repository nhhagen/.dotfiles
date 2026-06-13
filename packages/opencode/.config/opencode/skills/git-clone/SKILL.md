---
name: git-clone
description: >-
  Niels's custom clone commands — `git clone-repo` for permanent work into
  `~/repos`, and `git clone-repo-tmp` for temporary multi-repo changes.
allowed-tools:
  - bash
---

# Git clone

## Cloning into ~/repos

```text
git clone-repo <url>   # clones into ~/repos/<host>/<org>/<repo>
```

Use for single-repo work where the clone should persist.

## Cloning into a temp directory

Use when cloning **multiple repos** to make broad changes across them.
Do **not** use for single-repo work — use `git clone-repo` instead.

Clone from the local repo when possible.

```text
git clone-repo-tmp <url>   # clones into /tmp/<random>/<host>/<org>/<repo>, prints the path
```
