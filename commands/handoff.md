---
description: Write a session handoff note so the next session resumes without losing context
argument-hint: [topic]
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Write docs/sessions/YYYY-MM-DD-<topic>.md (today's date) using templates/session.md (topic: $ARGUMENTS, or infer it). Include: goal, done, in progress (branch, files, state), next steps, open questions/decisions, and docs updated this session. Be specific enough that a fresh session can continue with no other context. Then confirm all decisions made this session are recorded as ADRs and any mistakes as lessons; create missing ones.
