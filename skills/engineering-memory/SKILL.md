---
name: engineering-memory
description: Use in any repo that has docs/adr/ or docs/ENGINEERING-STANDARD.md, whenever you debug a bug, change logic, data model or flow, make a design decision, answer how a feature works or worked in an earlier iteration, correct a mistake, or finish a task. Keeps the project's decision trail (ADRs, feature evolution, bug and lesson records) complete and uses it before coding.
---

# Engineering Memory Standard

The repository is the project's memory. Before acting, read it. After acting, update it in the same change.
Full standard: `STANDARD.md` in this skill folder. Templates: `templates/` in this skill folder.

## Where things live (in the project repo)

| Path | Holds |
|---|---|
| CLAUDE.md (root) | Purpose, module map, rules, pointers (under ~150 lines) |
| <module>/CLAUDE.md | Current design, Invariants, Known traps, related ADRs |
| docs/glossary.md | Domain terms and business rules |
| docs/architecture/ | Overview, diagrams, data model, integrations |
| docs/features/<f>.md | How a feature works now + Evolution table (v1, v2, ...) |
| docs/algorithms/<a>.md | Non-trivial logic step by step, edge cases, tests |
| docs/adr/NNNN-*.md | Decisions: context, decision, alternatives, consequences, status |
| docs/design/ | Design docs before large changes |
| docs/bugs/NNNN-*.md | Root-cause records with regression test path |
| docs/lessons/NNNN-*.md | Mistakes in logic/approach and their prevention rule |
| docs/incidents/ | Production postmortems |
| docs/runbooks/ | Deploy, rollback, recovery |
| docs/sessions/ | Handoff notes between sessions |
| docs/todo-debt.md | Accepted shortcuts and deferred cleanups |

If the repo has not adopted the standard (no docs/adr/), suggest running `/engineering-memory:bootstrap` and otherwise work normally.

## Before acting (always)

1. Read the module CLAUDE.md (Invariants, Known traps).
2. Read docs/features/<feature>.md and the ADRs it links.
3. For bugs, also read docs/bugs/ and docs/lessons/ entries for that module.
4. In answers and plans, cite the docs you relied on (e.g. "per ADR-0012").

## Debugging protocol

Use superpowers:systematic-debugging if installed. In all cases:
1. Reproduce; write a failing test.
2. Read traps, ADRs, past bugs and lessons for the module.
3. Trace the full data flow; use `git log -L :func:file`, `git blame`, `git log -S`.
4. State the root cause and the iteration/commit/ADR that introduced it.
5. Propose the fix; wait for approval if non-trivial.
6. Fix, pass the test, write docs/bugs/NNNN. Update design docs if the design changed.
No fix without a stated root cause. A workaround needs an ADR or a todo-debt entry explaining why.

## Changing logic, data model or flow

- Write a new ADR (next number, templates/adr.md). Mark the replaced ADR `Status: Superseded by ADR-NNNN`.
- Add an Evolution row to docs/features/<feature>.md.
- Update the module CLAUDE.md if invariants or design changed.
- Delete the replaced code, or flag it `// DEPRECATED: see ADR-NNNN` and list it in docs/todo-debt.md.
- Non-trivial algorithm → docs/algorithms/<name>.md.

## Past-iteration questions

Check feature Evolution → ADRs → `git log -L`, `git show <tag-or-commit>:<file>`. Answer with commit or tag references and quote the old logic.

## Mistakes

When you (or a reviewer or a test) find that earlier logic or approach was wrong: write docs/lessons/NNNN (templates/lesson.md) with what was wrong, why it happened, impact, rectification, and a one-line prevention rule. Add that rule to the module CLAUDE.md "Known traps". Never delete or soften lessons.

## Rules that never bend

- Never delete docs content. Supersede it, or move it and leave a pointer.
- Never invent a reason. Write "Reason unknown, confirm with team".
- Docs ship in the same commit as the code.
- Commit format: `<type>(<module>): <what> — <why> [ADR-NNNN]`.
- Before saying done, list which docs you updated, or state "no doc update needed" with the reason.
- Before ending or compacting a long session, write docs/sessions/YYYY-MM-DD-<topic>.md (templates/session.md).
