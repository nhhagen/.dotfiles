---
name: git-workflow
description: >-
  Niels's personal git aliases and custom scripts for branch management, PR
  workflows, multi-repo operations and log visualisation. Use these commands
  instead of raw git when working in his environment.
allowed-tools:
  - bash
---

# Git workflow

## Branch and PR lifecycle

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

## Amending the last commit

```text
git amend   # stages current changes and amends without editing the message
```

## Cloning into ~/repos

```text
git clone-repo <url>   # clones into ~/repos/<host>/<org>/<repo>
```

## Log visualisation

```text
git lg    # pretty graph log for current branch (coloured, signed status, relative time)
git lga   # same but all branches
git livelog [args]  # auto-refreshing graph log, updates every second
```

## Multi-repo operations (run from a parent directory)

```text
git pull-all [dir]    # pulls all git repos under dir (default: current dir)
git status-all [dir]  # fetches and shows branch/dirty status for all repos
git remote-all [dir]  # lists remotes for all repos
```

## Diff tool

```text
git d   # alias for git difftool
```

## Generating .gitignore

```text
git ignore <language>[,<language>]   # fetches .gitignore template from gitignore.io
# e.g. git ignore go,macos
```

## Background sync / notifications

```text
git sync               # polls every 60s, sends macOS notification when commits are available to pull
git sync-submodules    # same but fetches submodules instead
```

## Usage guidance

- When creating any branch for a PR, always use `git create-branch <name>`.
- **Do not use branch prefixes** (e.g. `feat/`, `fix/`, `chore/`, `niels/`).
  Pass a plain descriptive name; the datestamp suffix is added automatically.
- When updating a branch with upstream changes, use `git update-branch`.
- Before merging, prefer `git squash-and-merge-branch` to keep a clean history.
- For multi-repo operations (e.g. pulling all services), use `git pull-all` or
  `git status-all` from the parent directory.

## Commit messages and pull request titles/descriptions

Follow the Coop Norge version control guidelines at
<https://github.com/coopnorge/guidelines/blob/main/docs/version_control/index.md#commit-messages-and-pull-request-titles-and-descriptions>.

**Before authoring any commit message or PR title/body, fetch the current
guidelines via the GitHub MCP server** (these guidelines evolve — do not rely
on cached knowledge):

- Use the `github-mcp-server-get_file_contents` tool with
  `owner: coopnorge`, `repo: guidelines`,
  `path: docs/version_control/index.md`, and read the "Commit Messages and
  pull request titles and descriptions" and "Conventional commits" sections.
- Apply those rules to every commit message, PR title, and PR body you
  produce in this environment.

Always include the Copilot co-author trailer at the bottom of commit messages:

```text
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```
