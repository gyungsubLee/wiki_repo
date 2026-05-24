# Codex Prompts

## Query Before Code Work

```text
Read /Users/igyeongseob/Develop/kn_wiki/AGENTS.md and CONTEXT.md.
Search this wiki for decisions, troubleshooting notes, and project context related to:

<topic>

Before editing code, summarize:
1. relevant constraints
2. prior decisions
3. known risks
4. verification commands to run
```

## Capture Code Work Into Wiki

```text
Read the latest git diff and verification output from the code repository.
Create or update a note in /Users/igyeongseob/Develop/kn_wiki.

Use the appropriate template:
- decision: wiki/templates/decision-record.md
- troubleshooting: wiki/templates/troubleshooting.md
- project update: wiki/templates/project-context.md

Include:
1. exact date
2. repository path
3. changed files summary
4. root cause or decision
5. verification evidence
6. links to related wiki notes
```

## Lint Wiki Before Commit

```text
Run:

cd /Users/igyeongseob/Develop/kn_wiki
./scripts/wiki-health-check.sh
git status --short

Then summarize unresolved warnings and propose a focused commit message.
```

