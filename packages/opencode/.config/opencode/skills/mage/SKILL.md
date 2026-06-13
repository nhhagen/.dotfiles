---
name: mage
description: >-
  Skill for running Mage commands. Mage is a Make-like build tool written in
  Go, and is used in many of our repos for build and test automation.

  When a repository contains a `magefile.go` or a `magefiles` directory, you
  can use this skill to run Mage targets defined in that repository.
allowed-tools:
  - bash
---

# Mage

## Listing available Mage targets

```bash
go tool mage -l
```

## Running a target

```bash
go tool mage <target>
```
