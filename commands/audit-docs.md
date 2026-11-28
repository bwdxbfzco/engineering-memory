---
description: Audit the project memory for gaps, stale docs and missing records, and propose fixes
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Audit this repo against the Engineering Memory Standard and report (do not change anything until I approve):
1. Modules without a CLAUDE.md, or whose CLAUDE.md is over ~150 lines or older than recent code changes (compare `git log -1` dates).
2. Features without docs/features/ files, or whose Evolution table misses recent logic changes (check `git log --since="3 months ago"` per module).
3. Commits in the last 3 months that changed logic/data model with no ADR, and fix commits with no bug record.
4. ADR hygiene: duplicate numbers, broken links, Superseded ADRs that do not name a successor, index out of date.
5. Code flagged DEPRECATED or listed in todo-debt.md that is now safe to remove.
6. Boards: .tldr files without a matching .md summary or .svg export; boards whose .tldr changed after their .md (compare git log dates); Mermaid diagrams that no longer match the code.
7. Old docs/sessions/ notes for finished work (propose archiving).
8. Contradictions between CLAUDE.md files and the code.
Output a prioritised fix list, then wait for approval.
