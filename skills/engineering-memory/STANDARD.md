# Engineering Memory Standard

Every project keeps its memory in the repository, as plain Markdown next to the code, so that people and Claude Code can recover what was built, how it works, why it changed and what went wrong — years later.

## 1. Principles

1. **Repo is the source of truth.** Chats, tickets and emails are inputs, never the record.
2. **Record the why, not just the what.** Git records what changed; docs record why.
3. **Append, never erase.** Decisions and lessons are superseded, not deleted.
4. **Write it in the same change.** A change without its record is incomplete.
5. **One home per fact.** Each kind of knowledge has exactly one place; others link to it.
6. **Short and current beats long and stale.** Context files stay lean and point to detail.
7. **Root cause before fix.** No fix without a stated root cause and a regression test.
8. **Unknown is written as unknown.** "Reason unknown, confirm with team" — never invent.

## 2. Practices this standard adopts

| Practice | Origin | Adopted as |
|---|---|---|
| Design docs / RFCs | Google, Uber, Rust | docs/design/ |
| Architecture Decision Records | Michael Nygard; ThoughtWorks | docs/adr/ |
| Blameless postmortems | Google SRE | docs/incidents/ |
| Bug root-cause records | High-reliability teams | docs/bugs/ |
| Runbooks | SRE / ops | docs/runbooks/ |
| C4 architecture diagrams | Simon Brown | docs/architecture/ |
| Conventional Commits + changelog | Open source, semver | commit convention, CHANGELOG.md |
| Code ownership | CODEOWNERS | CODEOWNERS |
| Docs-as-code | Large engineering orgs | everything in repo, checked in CI |
| Tests as specification | TDD / BDD | regression test per bug |

## 3. Repository structure

```text
CLAUDE.md                     # lean root context: purpose, map, rules, pointers
CODEOWNERS
CHANGELOG.md
<module>/CLAUDE.md            # design, Invariants, Known traps
docs/
  README.md                   # map of all docs
  ENGINEERING-STANDARD.md     # this file
  glossary.md
  architecture/               # overview.md with Mermaid diagrams
    boards/                   # <slug>.tldr + <slug>.svg + <slug>.md summary
  features/<feature>.md       # how it works + Evolution table
  algorithms/<name>.md
  adr/                        # NNNN-title.md, README.md index, template.md
  design/
  bugs/
  lessons/
  incidents/
  runbooks/
  sessions/
  todo-debt.md
```

## 4. Lifecycle — what gets written when

| Event | Read first | Write / update | Same commit |
|---|---|---|---|
| Large feature | glossary, architecture, ADRs | design doc → ADR(s), feature doc, module CLAUDE.md | tests, feature doc |
| Small feature | module CLAUDE.md, feature doc | Evolution row | tests |
| Change to existing logic | Evolution, ADRs | new ADR; old one Superseded; Evolution row; remove/flag old code | tests updated |
| Non-trivial algorithm | glossary, feature doc | algorithms/<name>.md | edge-case tests |
| Bug fix | traps, bugs, lessons, ADRs, git log -p | bugs/NNNN | failing→passing test |
| Mistake found | lessons | lessons/NNNN + Known traps line | correcting change |
| Production incident | runbooks | incidents/ postmortem | — |
| Shortcut accepted | — | todo-debt.md | — |
| Release | CHANGELOG | CHANGELOG entry, git tag | — |
| Session ends mid-task | — | sessions/ handoff | — |
| Architecture or flow changes | architecture/, boards/*.md | Mermaid diagram; redraw affected boards (/diagram) | — |
| Board edited by a person | the board | its .md summary and the Mermaid diagram | — |

### Debugging protocol
1. Reproduce; write a failing test.
2. Read Known traps, ADRs, past bugs and lessons for the module.
3. Trace the full data flow; `git log -L`, `git blame`, `git log -S`.
4. State the root cause and the iteration that introduced it.
5. Propose the fix; wait for approval if non-trivial.
6. Fix, pass the test, write the bug record, update design docs if needed.

A workaround is allowed only with an ADR or todo-debt entry explaining why the real fix is deferred.

### Diagrams
- Mermaid inside Markdown is the source of truth: it diffs cleanly, renders on GitHub, and Claude can read it.
- tldraw boards (docs/architecture/boards/) are for whiteboarding and reviews. Each `.tldr` has an exported `.svg` and a `.md` summary (templates/board.md).
- Export only with `@kitschpatrol/tldraw-cli export <file> --local`; without `--local` the file is uploaded to tldraw.com.
- The tldraw desktop app does not merge external changes into an open file: close boards before `git pull` or switching branches.

## 5. Claude Code integration

- **Layer 1 — CLAUDE.md:** root file under ~150 lines with the mandatory rules block (templates/root-claude-rules.md); a module CLAUDE.md per major folder.
- **Layer 2 — commands:** /engineering-memory:bootstrap, :debug, :decide, :feature-history, :lesson, :handoff, :audit-docs, :diagram.
- **Layer 3 — hooks:** Stop hook blocks "done" once when code changed without doc updates; SessionStart hook shows the latest handoff note. Both are no-ops in repos without docs/adr/.
- **Habits:** plan mode for investigation; /handoff before /compact; subagents for wide searches.

## 6. Governance

| Check | Cadence |
|---|---|
| PR checkbox: docs updated or "not needed because…" | every PR |
| Commit convention `<type>(<module>): <what> — <why> [ADR-NNNN]` | every commit |
| CI: unique ADR/bug numbers, links resolve, Superseded ADRs name successor | every PR |
| CODEOWNERS review for module and its docs | every PR |
| /engineering-memory:audit-docs | monthly |
| Trim CLAUDE.md files | quarterly |
| Review todo-debt.md | quarterly |
| Tag each major logic iteration (`billing-v2`) | each major change |
| Runbook drill | quarterly |

Never rewrite history on main. Keep secrets out of docs: name the vault/variable, never the value.
