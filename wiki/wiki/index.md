---
title: KN Wiki Index
tags:
  - wiki/index
  - llm-wiki
---

# KN Wiki Index

This is the entry point for humans and agents.

## Core Workflow

- `docs/workflows/llm-wiki-codex-hermes-git.md`
- `docs/runbooks/codex-workflow.md`
- `docs/runbooks/hermes-workflow.md`
- `docs/runbooks/git-workflow.md`

## Main Areas

- Raw sources: `wiki/raw/`
- Durable notes: `wiki/wiki/`
- Decisions: `wiki/decisions/`
- Projects: `wiki/projects/`
- Meetings: `wiki/meetings/`
- Troubleshooting: `wiki/troubleshooting/`
- Prompts: `wiki/prompts/`
- Templates: `wiki/templates/`
- Reports: `wiki/reports/`
- Hermes operations: `wiki/hermes/`

## First Scenario

The first operating scenario is:

```text
Project context
-> /ingest into raw and wiki notes
-> /query before code work
-> Codex implementation
-> Git diff and test summary
-> Hermes recurring maintenance
-> Git commit
```

## Open Index Tasks

- Add the first active project note in `wiki/projects/`.
- Add the first decision note in `wiki/decisions/`.
- Add the first troubleshooting record after a real code fix.
