---
name: github-issues-cli
description: Workflow for editing GitHub issue bodies via gh CLI and a local file so changes can be reviewed as a diff before submitting. Use when editing the body of a GitHub issue or RFC.
---

# GitHub Issues CLI Editing Workflow

Always edit issue bodies via a local file so the diff can be reviewed before submitting. Never update an issue body directly via the MCP `github_issue_write` tool.

## 1. Fetch

```sh
gh issue view <NUMBER> --repo <OWNER/REPO> --json body -q ".body" \
  > /tmp/fence/opencode/issue-<NUMBER>.md
```

## 2. Edit

Make changes to `/tmp/fence/opencode/issue-<NUMBER>.md` using the Edit or Write tool.

## 3. Diff

```sh
diff <(gh issue view <NUMBER> --repo <OWNER/REPO> --json body -q ".body") \
     /tmp/fence/opencode/issue-<NUMBER>.md
```

Show the diff to the user and wait for explicit approval before submitting.

## 4. Submit (only after user approval)

```sh
gh issue edit <NUMBER> --repo <OWNER/REPO> \
  --body-file /tmp/fence/opencode/issue-<NUMBER>.md
```
