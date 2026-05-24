# Context

This vault stores durable knowledge for a personal LLM operating system.

The intended workflow combines:

- Obsidian for human browsing and linking
- LLM Wiki conventions for ingest, tag, lint, and query operations
- Codex for codebase-aware implementation work
- Hermes for recurring agent tasks
- GitHub for versioned memory and collaboration

## Current Scope

The first scenario is a developer knowledge loop:

1. Capture project context from a code repository, meeting, issue, PR, or incident.
2. Normalize that context into this wiki.
3. Ask Codex to use the wiki before making code changes.
4. Ask Hermes to maintain the wiki through recurring checks.
5. Commit wiki updates to Git.

## Success Criteria

- A new agent can understand the vault by reading `README.md`, `AGENTS.md`, and `wiki/wiki/index.md`.
- Raw context, durable notes, decisions, project updates, and troubleshooting records have separate homes.
- Codex and Hermes prompts are reusable without rewriting from scratch.
- Git history shows how the knowledge base changed over time.

