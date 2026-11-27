---
description: Record a design decision as an ADR, supersede older ADRs, and update feature docs
argument-hint: <decision topic>
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Decision topic: $ARGUMENTS

1. Read docs/adr/README.md and grep docs/adr/ for related ADRs; read the related feature docs.
2. Draft ADR with the next number using templates/adr.md: context, decision, alternatives considered, consequences/invariants. If it replaces an earlier ADR, set "Supersedes" and change the old ADR's status to "Superseded by ADR-NNNN" (do not delete its content).
3. Update docs/adr/README.md index, the Evolution table in the affected docs/features/ file, and the module CLAUDE.md if invariants changed.
4. Show me the ADR before committing if the decision has not been explicitly agreed.
