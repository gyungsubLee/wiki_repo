#!/usr/bin/env bash
set -euo pipefail

required_dirs=(
  "wiki/inbox"
  "wiki/raw"
  "wiki/wiki"
  "wiki/decisions"
  "wiki/projects"
  "wiki/meetings"
  "wiki/troubleshooting"
  "wiki/prompts"
  "wiki/templates"
  "wiki/reports"
  "wiki/hermes/tasks"
  "wiki/hermes/runs"
  "wiki/hermes/schedules"
  "docs/adr"
  "docs/runbooks"
  "docs/workflows"
)

missing=0

echo "## Required directories"
for dir in "${required_dirs[@]}"; do
  if [[ -d "$dir" ]]; then
    echo "ok  $dir"
  else
    echo "miss $dir"
    missing=1
  fi
done

echo
echo "## Markdown placeholders"
if command -v rg >/dev/null 2>&1; then
  rg -n "TODO|TBD|FIXME" --glob "*.md" . || true
else
  echo "rg not found; skipping placeholder scan"
fi

echo
echo "## Markdown files without tags frontmatter"
if command -v rg >/dev/null 2>&1; then
  rg --files-without-match "^tags:" \
    --glob "*.md" \
    --glob "!README.md" \
    wiki/wiki wiki/decisions wiki/projects wiki/meetings wiki/troubleshooting \
    || true
else
  echo "rg not found; skipping tag scan"
fi

echo
echo "## Git status"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git status --short
else
  echo "not a git repository"
fi

exit "$missing"
