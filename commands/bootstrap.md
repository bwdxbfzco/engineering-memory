---
description: Apply the Engineering Memory Standard to this repo — investigate code and git history, report, then create and backfill all memory docs after approval
argument-hint: [optional: module to start with]
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Set up this repo to the Engineering Memory Standard. Work in phases and STOP for my approval after Phase 2. Prefer plan mode for Phases 1–2. Optional focus: $ARGUMENTS

## Phase 0 — Preconditions
- Check `git status` is clean; if not, ask me to commit or stash.
- Check history depth (`git rev-parse --is-shallow-repository`); if shallow, ask me to run `git fetch --unshallow`.
- Check whether `gh` is authenticated (merged PR descriptions are a source of "why").
- Create docs/sessions/bootstrap-progress.md and update it after every module so work survives context loss. If it already exists, RESUME from it.

## Phase 1 — Investigate (read-only)
- Find all CLAUDE.md files, .claude/ config, and existing docs.
- Map modules, entry points, data flow, stack, how tests run.
- Per module (one at a time; use subagents for wide searches), reconstruct the iterations of the logic from: code, `git log --stat`, `git log -p`, `git log -L` on core functions, reverts, merged PR descriptions (`gh pr list --state merged`, `gh pr view`), code comments, existing docs.
- Find dead or half-replaced logic, symptom-level patches, and past reverts/corrections (candidate lessons).

## Phase 2 — Report and propose (no changes)
- Current state of CLAUDE.md files and docs: missing, stale, contradictory, too long.
- Iteration timeline per module (v1 → v2 → …) with commit refs; dead code; suspicious patches; past mistakes.
- Proposed root CLAUDE.md (include templates/root-claude-rules.md), module CLAUDE.md files, docs/ structure per STANDARD.md, git tags for iteration boundaries.
- List every "Reason unknown" item. Then STOP.

## Phase 3 — Implement (after approval)
- Branch `chore/project-memory`.
- NEVER delete existing information: move it, park anything uncertain under "## To review", and show what moved where.
- Copy STANDARD.md to docs/ENGINEERING-STANDARD.md. Create every docs/ folder with its template.md (from templates/) and a README.md index where useful.
- Backfill: ADRs per major decision (old ones marked Superseded), feature docs with Evolution tables, algorithm docs for non-trivial logic, bug records for significant past fixes, lessons for past corrections, glossary, architecture overview. Evidence only; unknown reasons → "Reason unknown, confirm with team".
- Write root CLAUDE.md (under ~150 lines) and module CLAUDE.md files (templates/module-claude.md).
- Create docs/todo-debt.md listing dead code and deferred cleanups. Do NOT remove code yet.
- Create approved git tags.

## Phase 4 — Verify
- Simulate a bug fix and a past-iteration question; show which files you would read first.
- Confirm the plugin Stop hook fires once on code-without-docs, then allows.
- Commit: `docs(memory): adopt engineering memory standard`. Summarise what was created and list "Reason unknown" items for me to confirm.
