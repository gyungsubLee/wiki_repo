# KN Wiki

## Reference

- [karpathy/442a6bf555914893e9891c11519de94f](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [karpathy/status/2015883857489522876](https://x.com/karpathy/status/2015883857489522876)
- [multica-ai/andrej-karpathy-skills/skills/karpathy-guidelines/SKILL.md](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md)

### Language Docs

- [Korean](README.md)
- [English](README.en.md)

## Project Intent

This repository is a personal LLM system that compounds knowledge over time. It is not a generic chatbot workspace or a simple RAG folder. Instead of rediscovering raw chunks on every question, the LLM maintains a Git-backed Markdown wiki that keeps summaries, links, contradictions, and follow-up questions in one place.

## Core Layers

The repository has three layers:

1. **Raw sources**: immutable source material stored in `wiki/raw/`. These are articles, meeting notes, logs, PR descriptions, documents, and other source-of-truth inputs that the LLM reads but should not rewrite.
2. **Wiki**: LLM-generated knowledge stored across `wiki/wiki/`, `wiki/decisions/`, `wiki/projects/`, `wiki/troubleshooting/`, and related folders. This layer contains summaries, concept pages, decision records, troubleshooting notes, and project context.
3. **Schema**: the operating rules in `AGENTS.md`, `CLAUDE.md`, `CONTEXT.md`, runbooks, and templates. This layer tells the LLM how to ingest, query, tag, lint, and maintain the wiki.

The operating model is organized around four command-style workflows:

- `/ingest`: read a new source and integrate it into wiki pages, decision records, and project context.
- `/query`: answer from the already-maintained wiki first instead of rediscovering everything from raw sources.
- `/tag`: maintain tags, relationships, frontmatter, and links.
- `/lint`: check stale claims, contradictions, orphan pages, missing links, and useful follow-up questions.

Codex acts as the code work agent. It queries the wiki before changing code, then writes back the diff summary, test evidence, and decision rationale after the work. Hermes acts as the operations agent. It runs recurring checks, summarizes recent changes, reviews stale notes, and writes reports. Git provides history, review, and collaboration for every meaningful knowledge change.

The result is not a saved chat transcript. It is a knowledge system that becomes more useful with every source, question, code change, and maintenance pass.

## How It Works

1. Save raw material in `wiki/raw/`.
2. Promote durable knowledge into `wiki/wiki/`, `wiki/decisions/`, `wiki/projects/`, or `wiki/troubleshooting/`.
3. Ask Codex to read `AGENTS.md`, `CONTEXT.md`, and `wiki/wiki/index.md` before code work.
4. Record the diff, tests, and decision rationale back into the wiki.
5. Let Hermes produce recurring maintenance reports under `wiki/hermes/` and `wiki/reports/`.
6. Run `scripts/wiki-health-check.sh` and commit the changes.

## Directory

| Path | Purpose |
| --- | --- |
| `wiki/inbox/` | Temporary capture before classification |
| `wiki/raw/` | Source material copied with minimal edits |
| `wiki/wiki/` | Durable concept notes and indexes |
| `wiki/decisions/` | ADR-style decisions and tradeoffs |
| `wiki/projects/` | Active project context, status, and links |
| `wiki/meetings/` | Meeting notes and action items |
| `wiki/troubleshooting/` | Bugs, incidents, fixes, and lessons learned |
| `wiki/prompts/` | Reusable Codex and Hermes prompts |
| `wiki/templates/` | Note templates |
| `wiki/reports/` | Human-readable generated reports from lint, review, and automation |
| `wiki/hermes/` | Hermes task definitions, run logs, and schedule notes |
| `docs/adr/` | Repository-level architecture and workflow decisions |
| `docs/` | Runbooks and workflow documentation |

## Start Here

Open this folder as an Obsidian vault:

```bash
open -a Obsidian /Users/igyeongseob/Develop/kn_wiki
```

Then check the repository:

```bash
cd /Users/igyeongseob/Develop/kn_wiki
./scripts/wiki-health-check.sh
git status --short
```

## Codex

Before code work, ask Codex to read this wiki first:

```text
Read /Users/igyeongseob/Develop/kn_wiki/AGENTS.md and CONTEXT.md.
Search this wiki for decisions, troubleshooting notes, and project context related to:

<work topic>

Before editing code, summarize:
1. relevant constraints
2. prior decisions
3. known risks
4. verification commands to run
```

After code work, ask Codex to write the result back:

```text
Read the latest git diff and verification output from the code repository.
Update /Users/igyeongseob/Develop/kn_wiki with the root cause, decision, changed files summary, and verification evidence.
Use the relevant template under wiki/templates/.
```

Reusable Codex prompts live in `wiki/prompts/codex.md`.

## Hermes

Use Hermes for recurring maintenance that should not depend on a human remembering to run it.

Example:

```bash
cd /Users/igyeongseob/Develop/kn_wiki
hermes -p "Read AGENTS.md and CONTEXT.md. Run scripts/wiki-health-check.sh. Review git status. Write a dated report in wiki/reports/. Do not push."
```

Recommended recurring tasks:

- Daily wiki health review
- Recent Git changes summary
- Stale note review
- Missing tag and weak-link review
- Project status rollups

Reusable Hermes prompts live in `wiki/prompts/hermes.md`. Hermes task definitions, run summaries, and schedule notes live under `wiki/hermes/`.

## Git

After wiki changes, verify and review the diff:

```bash
cd /Users/igyeongseob/Develop/kn_wiki
./scripts/wiki-health-check.sh
git status --short
git diff --stat
```

Commit example:

```bash
git add -- .
git commit -m "docs: capture auth troubleshooting"
```

Push only when remote sync is explicitly needed:

```bash
git push origin main
```

## Related Docs

- Main wiki index: `wiki/wiki/index.md`
- Codex runbook: `docs/runbooks/codex-workflow.md`
- Hermes runbook: `docs/runbooks/hermes-workflow.md`
- Git workflow: `docs/runbooks/git-workflow.md`
- End-to-end scenario: `docs/workflows/llm-wiki-codex-hermes-git.md`
