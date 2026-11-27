# engineering-memory — Claude Code plugin

Engineering Memory Standard for long-lived projects: Claude Code keeps and uses a decision trail (ADRs, feature evolution, algorithm docs, bug and lesson records, session handoffs) and debugs from root cause instead of patching.

## What's inside

| Part | Path | Does |
|---|---|---|
| Skill | skills/engineering-memory/SKILL.md | Auto-loads when debugging, changing logic, or answering how a feature works/worked |
| Standard | skills/engineering-memory/STANDARD.md | Full standard; copied to docs/ENGINEERING-STANDARD.md on bootstrap |
| Templates | skills/engineering-memory/templates/ | ADR, feature, algorithm, bug, lesson, design, incident, runbook, session, module CLAUDE.md, root rules, todo-debt |
| Commands | commands/ | /engineering-memory:bootstrap, :debug, :decide, :feature-history, :lesson, :handoff, :audit-docs |
| Hooks | hooks/hooks.json + scripts/ | Stop: blocks "done" once if code changed without doc updates. SessionStart: shows latest handoff. Both do nothing in repos without docs/adr/ |

## Install

**Option A — from a GitHub repo (recommended, for the whole team)**

1. Push this folder to a repo, e.g. `github.com/<org>/engineering-memory` (private is fine if your git can access it).
2. In Claude Code:
   ```
   /plugin marketplace add <org>/engineering-memory
   /plugin install engineering-memory@engineering-memory-marketplace
   ```
3. Restart Claude Code.

**Option B — from a local folder (just you)**

```
/plugin marketplace add /path/to/engineering-memory
/plugin install engineering-memory@engineering-memory-marketplace
```

Requirements: git, bash; `jq` recommended (the hook falls back to grep without it). Works best alongside the Superpowers plugin.

## Use in an existing project

1. Commit or stash open work.
2. Switch to plan mode (Shift+Tab), then run:
   ```
   /engineering-memory:bootstrap
   ```
3. Review the Phase 2 report, correct the timeline, answer "Reason unknown" items, approve.
4. If a session breaks mid-way, run `/engineering-memory:bootstrap` again — it resumes from docs/sessions/bootstrap-progress.md.

## Daily use

| Situation | Command |
|---|---|
| A bug comes in | `/engineering-memory:debug <symptom>` |
| A design choice is made | `/engineering-memory:decide <topic>` |
| "How did X work before?" | `/engineering-memory:feature-history <feature>` |
| Claude got something wrong | `/engineering-memory:lesson <what went wrong>` |
| Ending a long session / before /compact | `/engineering-memory:handoff` |
| Monthly | `/engineering-memory:audit-docs` |

The skill and hooks also apply the rules automatically, without commands.

## Updating the standard

Edit the files, bump `version` in .claude-plugin/plugin.json, push. Users run `/plugin marketplace update engineering-memory-marketplace`.
