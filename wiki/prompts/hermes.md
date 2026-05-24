# Hermes Prompts

## Daily Wiki Maintenance

```text
You are maintaining /Users/igyeongseob/Develop/kn_wiki.

Read AGENTS.md, CONTEXT.md, and wiki/wiki/index.md.
Run scripts/wiki-health-check.sh.
Review git status and recent commits.

Create a dated report in wiki/reports/ with:
1. changed notes
2. stale or weak notes
3. missing links or missing tags
4. suggested next actions

Do not push to GitHub unless explicitly requested.
```

## Project Change Capture

```text
Given a project repository path:

<project_repo_path>

Inspect recent git commits, open changes, and test results if available.
Update /Users/igyeongseob/Develop/kn_wiki with:
1. raw captured context in wiki/raw/
2. durable notes in wiki/wiki/
3. decisions in wiki/decisions/
4. troubleshooting records in wiki/troubleshooting/

End with a git status summary for the wiki repository.
```

