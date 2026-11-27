---
description: Record a mistake in logic or approach (by Claude or anyone), its rectification and a prevention rule
argument-hint: <what went wrong>
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Mistake: $ARGUMENTS

1. Write docs/lessons/NNNN-<slug>.md using templates/lesson.md: what was wrong, why it happened (be honest about the reasoning error, e.g. skipped an ADR, assumed something, patched a symptom), impact, rectification and why it is correct, and a one-line prevention rule. Link commits, bugs, ADRs.
2. Add the prevention rule as one line under "## Known traps" in the affected module CLAUDE.md, linking the lesson. If it applies project-wide, add it to the root CLAUDE.md.
3. Update docs/lessons/README.md index if it exists. Never delete or soften existing lessons.
