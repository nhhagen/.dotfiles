---
name: github-org
description: >-
  Discover teams, list members, find team repos, and manage org structure in
  coopnorge via the GitHub MCP server and gh CLI fallbacks.
allowed-tools:
  - bash
---

# GitHub org structure

## Discovering teams

The `get_teams` MCP tool only returns teams the **authenticated user is a
member of**. To list all teams in the `coopnorge` org, use the `gh` CLI:

```bash
gh api /orgs/coopnorge/teams --paginate --jq '.[] | {slug: .slug, name: .name, description: .description, members_url: .members_url}'
```

For a simple slug list:

```bash
gh api /orgs/coopnorge/teams --paginate --jq '.[].slug'
```

## Listing members of a team

Use the MCP `get_team_members` tool:

- `org: coopnorge`
- `team_slug: <slug>`

Or via `gh` CLI:

```bash
gh api /orgs/coopnorge/teams/<slug>/members --paginate --jq '.[].login'
```

## Finding which teams a user belongs to

```bash
gh api /orgs/coopnorge/teams --paginate --jq '.[] | select(.slug) | .slug' \
  | xargs -I{} sh -c 'gh api /orgs/coopnorge/teams/{}/members --jq ".[].login" | grep -q "<username>" && echo {}'
```

Or use `get_teams` with the `user` parameter for the target GitHub login.

## Listing repositories owned/accessible by a team

```bash
gh api /orgs/coopnorge/teams/<slug>/repos --paginate --jq '.[] | {name: .name, permission: .permissions}'
```

## Limitations and CLI fallbacks

| Limitation | MCP workaround | `gh` CLI fallback |
|---|---|---|
| `get_teams` only returns teams the authed user belongs to | None | `gh api /orgs/coopnorge/teams --paginate` |
| No org-level member list tool | Search by user | `gh api /orgs/coopnorge/members --paginate` |
| No team permission management | N/A | `gh api` PATCH endpoints |

When using `gh api` for write operations, confirm with the user before
executing — these calls mutate org state and cannot be undone via the MCP.
