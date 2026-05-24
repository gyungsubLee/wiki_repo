# Git Workflow

This wiki is versioned memory. Keep history readable.

## Local Checks

```bash
cd /Users/igyeongseob/Develop/kn_wiki
./scripts/wiki-health-check.sh
git status --short
git diff --stat
```

## Commit Guidelines

- One topic per commit.
- Use `docs:` for wiki and runbook changes.
- Mention verification when a note depends on test output.
- Avoid mixing code repository changes with wiki repository changes.

## Push Rule

Do not push automatically. Push only after the user asks:

```bash
git push origin main
```

