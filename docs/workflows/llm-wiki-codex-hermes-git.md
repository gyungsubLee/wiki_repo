# LLM Wiki + Codex + Hermes + Git Workflow

This workflow turns project activity into durable, queryable knowledge.

## Roles

| Tool | Role |
| --- | --- |
| LLM Wiki | Structure and retrieval conventions |
| Obsidian | Human reading, editing, and graph navigation |
| Codex | Codebase-aware implementation and wiki updates |
| Hermes | Recurring maintenance and reporting |
| Git | Versioned history and collaboration |

## Scenario

Use this scenario when working on a real code repository.

1. Capture context in `wiki/raw/`.
2. Normalize reusable knowledge into `wiki/wiki/`.
3. Record durable tradeoffs in `wiki/decisions/`.
4. Track the active work in `wiki/projects/`.
5. Ask Codex to query this wiki before changing code.
6. After code work, store the diff summary, test evidence, and root cause.
7. Ask Hermes to run recurring maintenance, store task metadata under `wiki/hermes/`, and write human-readable reports to `wiki/reports/`.
8. Commit the wiki update.

## Example Codex Session

```text
Read /Users/igyeongseob/Develop/kn_wiki/AGENTS.md and CONTEXT.md.
Search the wiki for authentication decisions and refresh-token troubleshooting.
Then inspect /path/to/project, fix the refresh-token rotation bug, run tests,
and update the wiki with the root cause and verification evidence.
```

## Example Hermes Session

```bash
hermes -p "Maintain /Users/igyeongseob/Develop/kn_wiki. Read AGENTS.md, run scripts/wiki-health-check.sh, review git status, and write a dated report in wiki/reports/. Do not push."
```

## Commit Pattern

Use focused commits:

```text
docs: initialize llm wiki operating structure
docs: capture auth refresh-token troubleshooting
docs: add project status rollup for <project>
```

## Quality Bar

A useful note should answer:

- What happened?
- Why does it matter?
- What decision or lesson should survive?
- Where is the source?
- What should an agent do differently next time?

