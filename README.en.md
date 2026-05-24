# KN Wiki

## Reference

- [karpathy/442a6bf555914893e9891c11519de94f](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [karpathy/status/2015883857489522876](https://x.com/karpathy/status/2015883857489522876)
- [multica-ai/andrej-karpathy-skills/skills/karpathy-guidelines/SKILL.md](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md)

### Language Docs

- [Korean](README.md)
- [English](README.en.md)

KN Wiki is a Git-backed Obsidian vault for the LLM Wiki + Codex + Hermes workflow.

The repository is designed for one loop:

1. Capture raw context from issues, meetings, logs, articles, and code changes.
2. Normalize it into durable wiki notes.
3. Use Codex to query the wiki before changing code.
4. Use Hermes to run recurring review, lint, and summarization tasks.
5. Commit every meaningful knowledge change through Git.

## Project Intent

This project is not meant to be a generic chatbot workspace or a simple RAG folder. Its goal is to build a personal LLM system where knowledge compounds over time.

Most chatbots and file-upload RAG systems retrieve raw chunks at question time and synthesize an answer from scratch. That can work, but the useful intermediate work often disappears: summaries, cross-references, contradictions, judgment calls, and follow-up questions stay trapped in chat history. When you ask a related question later, the LLM has to rediscover much of the same context again.

KN Wiki uses a Git-backed Markdown wiki to avoid that reset. The human curates sources and asks good questions. The LLM reads source material, writes summaries, updates related pages, creates links, flags contradictions, and keeps the wiki maintained. Obsidian is the IDE for browsing the knowledge base. The LLM is the programmer maintaining it. The wiki is treated like a codebase that evolves over time.

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

The result is not a saved chat transcript. It is a knowledge system that becomes more useful with every source, question, code change, and maintenance pass. The LLM handles the repetitive summarizing, linking, filing, and bookkeeping. The human focuses on choosing good sources, directing the analysis, and asking better questions.

## Directory Map

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

## First Run

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

## Usage Guide

This repository is not just a note folder. It is long-lived project memory that LLM agents can read, update, and reuse. The core loop is:

```text
capture source material
-> normalize it into structured notes
-> query the wiki before code work
-> write results back after verification
-> commit knowledge changes with Git
```

## 1. Use With Obsidian

Open the vault:

```bash
open -a Obsidian /Users/igyeongseob/Develop/kn_wiki
```

Use `wiki/wiki/index.md` as the main entry point. Prefer saving source-backed material in `wiki/raw/` first, then promote durable knowledge into structured wiki notes.

## 2. Capture New Material

Place new material by type:

| Situation | Path | Example |
| --- | --- | --- |
| Temporary capture | `wiki/inbox/` | Quick ideas, links waiting for triage |
| Raw source material | `wiki/raw/` | Meeting transcripts, issue bodies, PR descriptions, logs |
| Durable concepts | `wiki/wiki/` | Auth design, deploy strategy, API rules |
| Decisions | `wiki/decisions/` | Technology choices, architecture tradeoffs |
| Project state | `wiki/projects/` | Goals, current progress, next actions |
| Meetings | `wiki/meetings/` | Notes, decisions, action items |
| Bugs and fixes | `wiki/troubleshooting/` | Symptoms, root cause, fix, verification |

Use templates from `wiki/templates/` when creating structured notes.

## 3. Use With Codex

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

## 4. Use With Hermes

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

## 5. Manage With Git

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

## 6. Recommended Daily Loop

```text
1. Save meetings, issues, PRs, and logs in wiki/raw/.
2. Promote important material into wiki/wiki/, wiki/decisions/, or wiki/troubleshooting/.
3. Ask Codex to query the wiki before code work.
4. After code work, record the diff, test results, and decisions.
5. Ask Hermes to create maintenance reports in wiki/reports/.
6. Run scripts/wiki-health-check.sh.
7. Commit knowledge changes with Git.
```

## 7. Good Note Criteria

A useful wiki note answers:

- What is true?
- Why does it matter?
- What should the next agent or developer watch for?
- Which decisions or troubleshooting records are related?
- Which command or test verified the claim?

Chat history disappears from working memory quickly. If something should be reused, keep it in this repository as a note.

## Start Here

- Main wiki index: `wiki/wiki/index.md`
- Codex runbook: `docs/runbooks/codex-workflow.md`
- Hermes runbook: `docs/runbooks/hermes-workflow.md`
- Git workflow: `docs/runbooks/git-workflow.md`
- End-to-end scenario: `docs/workflows/llm-wiki-codex-hermes-git.md`
