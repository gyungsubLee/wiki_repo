# KN Wiki Setup Design

Date: 2026-05-24

## Goal

Initialize `/Users/igyeongseob/Develop/kn_wiki` as a Git-backed Obsidian vault for the LLM Wiki + Codex + Hermes + Git workflow.

## Design

The vault separates raw capture, durable notes, decisions, projects, meetings, troubleshooting, prompts, templates, and reports. This keeps agent-generated memory auditable and reusable.

The root files define the shared contract:

- `README.md` explains how to start.
- `AGENTS.md` defines agent rules.
- `CLAUDE.md` keeps Claude Code compatible with the same workflow.
- `CONTEXT.md` describes the purpose and success criteria.

Runbooks and prompts make the workflow repeatable without requiring the user to rewrite instructions for every Codex or Hermes session.

## Verification

The setup includes `scripts/wiki-health-check.sh` to check required directories, missing tags, unresolved placeholders, and Git status.

