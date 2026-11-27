---
description: Explain how a feature or piece of logic worked in each iteration, with evidence from docs and git
argument-hint: <feature or function name> [iteration]
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Question: $ARGUMENTS

1. Read docs/features/<feature>.md (Evolution table) and the ADRs it links.
2. Verify against git: `git log --follow -p`, `git log -L :<func>:<file>`, `git log -S "<keyword>"`, `git show <tag-or-commit>:<file>` to read the old code.
3. Answer per iteration: how the logic worked (quote key old code), when it changed (commit/tag/date), why (ADR/PR/commit message; otherwise "reason unknown").
4. If the feature doc is missing or incomplete, offer to create or fill its Evolution table from what you found.
