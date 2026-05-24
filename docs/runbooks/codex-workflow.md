# Codex Workflow

Use Codex as the implementation agent that reads the wiki before editing code and writes back durable knowledge after verification.

## Before Code Work

1. Read `AGENTS.md`, `CONTEXT.md`, and `wiki/wiki/index.md`.
2. Query related notes in `wiki/wiki/`, `wiki/decisions/`, and `wiki/troubleshooting/`.
3. Summarize constraints, risks, and verification commands.
4. Work in the target code repository.

## During Code Work

- Keep unrelated edits out of the diff.
- Run the relevant tests or checks.
- Save exact command output when it matters for later debugging.

## After Code Work

1. Summarize the git diff.
2. Summarize verification evidence.
3. Update this wiki:
   - bug fix: `wiki/troubleshooting/`
   - architecture choice: `wiki/decisions/`
   - reusable concept: `wiki/wiki/`
   - status update: `wiki/projects/`
4. Run `./scripts/wiki-health-check.sh`.
5. Commit the wiki update separately unless instructed otherwise.

## Prompt

See `wiki/prompts/codex.md`.

