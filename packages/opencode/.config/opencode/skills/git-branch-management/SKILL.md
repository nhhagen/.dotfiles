---
name: git-branch-management
description: >-
  Niels's custom branch lifecycle commands — create, update, merge, squash, and
  delete branches with automatic datestamp suffixes. Use these instead of plain
  `git checkout -b` or `git push`.
allowed-tools:
  - bash
---

# Git branch management

## Branch lifecycle commands

Branches always get a datestamp suffix (e.g. `my-branch-2026-04-22-10-00-00`).
Always use these commands instead of plain `git checkout -b` or `git push`.

| Goal | Command |
|---|---|
| Create a new branch and push it | `git create-branch <name> [base]` |
| Update a branch from base (rebase + force push) | `git update-branch [branch] [base]` |
| Fast-forward merge into base, delete branch | `git merge-branch [branch] [base]` |
| Squash all commits then merge into base | `git squash-and-merge-branch [branch] [base]` |
| Squash all commits on current branch (stays on branch) | `git squash-branch [branch] [base]` |
| Delete branch locally and remotely | `git delete-branch [branch] [base]` |

All commands default `[branch]` to the current branch and `[base]` to the
remote HEAD branch (usually `main`).

## Usage guidance

- When creating any branch for a PR, always use `git create-branch <name>`.
- **Do not use branch prefixes** (e.g. `feat/`, `fix/`, `chore/`, `niels/`).
  Pass a plain descriptive name; the datestamp suffix is added automatically.
- When updating a branch with upstream changes, use `git update-branch`.
- Before merging, prefer `git squash-and-merge-branch` to keep a clean history.
