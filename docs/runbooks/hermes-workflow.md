# Hermes Workflow

Use Hermes for recurring maintenance that should not depend on a human remembering to run it.

## Suggested Tasks

- Daily wiki health report
- Weekly stale note review
- Project status rollup
- Recent Git changes summary
- Missing tag and weak-link report

## Manual Command Pattern

```bash
cd /Users/igyeongseob/Develop/kn_wiki
hermes -p "Read AGENTS.md and CONTEXT.md. Run scripts/wiki-health-check.sh. Review git status. Write a dated report in wiki/reports/. Do not push."
```

## Output Rules

- Use `wiki/reports/` for generated maintenance output.
- Promote durable findings to structured notes.
- Do not push to GitHub unless the user explicitly asks.

## Prompt

See `wiki/prompts/hermes.md`.

