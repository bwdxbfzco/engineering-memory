---
description: Root-cause debugging using the project's memory (traps, ADRs, bugs, lessons, git history), then write the bug record
argument-hint: <bug description or symptom>
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Bug: $ARGUMENTS

If superpowers:systematic-debugging is available, use it, and also follow these steps:
1. Identify the module(s). Read their CLAUDE.md (Invariants, Known traps), related docs/features/ and ADRs, and docs/bugs/ + docs/lessons/ entries for those modules. Say which past bug or lesson this resembles, if any.
2. Reproduce and write a failing test.
3. Trace the full data flow. Use `git log -L :<func>:<file>`, `git blame`, `git log -S` to see when and why the involved logic changed.
4. State the root cause and which iteration/commit/ADR introduced it. Do not propose a fix before this.
5. Propose the fix (not a symptom patch). Wait for my approval if it is non-trivial or touches design.
6. Implement, make the test pass, run the related test suite.
7. Write docs/bugs/NNNN-<slug>.md (templates/bug.md). If the fix changes design → ADR + feature Evolution row. If an earlier change by Claude caused it → also /engineering-memory:lesson.
8. Summarise: root cause, fix, test path, docs updated.
