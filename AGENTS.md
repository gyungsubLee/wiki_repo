# Agent Instructions

This repository is a Git-backed LLM Wiki vault. Treat it as long-lived project memory.

## Operating Principles

- Preserve source context in `wiki/raw/` before rewriting it into durable notes.
- Put reusable knowledge in `wiki/wiki/`, not in one-off chat summaries.
- Put durable tradeoffs in `wiki/decisions/`.
- Put bug investigations and fixes in `wiki/troubleshooting/`.
- Keep each note narrow enough that another agent can reuse it without reading the entire vault.
- Cross-link related notes with Obsidian wiki links.
- Prefer concrete dates over relative words like today or yesterday.

## Required Read Order

Before changing wiki structure or writing project memory, read:

1. `CONTEXT.md`
2. `wiki/wiki/index.md`
3. The relevant runbook under `docs/runbooks/`
4. The matching template under `wiki/templates/`

## LLM Wiki Commands

Use these command meanings consistently, even when the concrete tool is a prompt, Codex plugin, or Hermes task:

| Command | Meaning |
| --- | --- |
| `/ingest` | Convert raw input into a structured note with source links |
| `/tag` | Add stable frontmatter tags and relationships |
| `/lint` | Check broken structure, vague claims, missing links, and stale notes |
| `/query` | Answer using wiki context first, then identify gaps |

## Codex Workflow

When Codex is asked to work with another code repository:

1. Query this wiki for prior decisions and troubleshooting notes.
2. State the constraints that affect the code change.
3. Edit the code repository.
4. Run relevant verification commands.
5. Add or update a note in this wiki with the diff summary, tests, and decision.
6. Keep code commits and wiki commits separate unless the user asks otherwise.

## Hermes Workflow

Hermes should be used for recurring maintenance:

- daily git-diff summaries
- stale note review
- broken-link and missing-tag reports
- project status rollups
- issue or PR knowledge capture

Put generated human-readable reports in `wiki/reports/`. Put Hermes task definitions in `wiki/hermes/tasks/`, run summaries in `wiki/hermes/runs/`, and schedule notes in `wiki/hermes/schedules/`. Promote durable findings into `wiki/wiki/`, `wiki/decisions/`, or `wiki/troubleshooting/`.

## Git Rules

- Do not rewrite history unless the user explicitly asks.
- Do not push unless the user explicitly asks.
- Keep commits focused: one topic per commit.
- Include verification evidence in commit messages or PR notes when useful.

