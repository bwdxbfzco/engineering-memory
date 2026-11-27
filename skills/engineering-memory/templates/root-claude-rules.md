## Engineering memory (mandatory)
This repo follows docs/ENGINEERING-STANDARD.md (engineering-memory plugin).
- Before coding or answering "how does X work": read the module CLAUDE.md, docs/features/<x>.md and its ADRs. Cite them.
- Bugs: use superpowers:systematic-debugging (or /engineering-memory:debug). Read Known traps, docs/bugs/, docs/lessons/ first. No fix without a stated root cause and a failing test.
- Changes to logic, data model or flow: new/updated ADR, Evolution row in the feature doc, mark superseded ADRs, remove or flag old code.
- Mistakes found: docs/lessons/NNNN + one-line rule in the module Known traps.
- Past-iteration questions: feature Evolution → ADRs → git log -L / git show <tag>:<file>.
- Never delete docs content; never invent reasons ("Reason unknown, confirm with team").
- Docs ship in the same commit. Commit: <type>(<module>): <what> — <why> [ADR-NNNN].
- Before ending a long session: /engineering-memory:handoff.
