---
description: Draw or update an architecture/flow diagram — Mermaid in the docs as source of truth, plus an optional tldraw board with a local SVG export and a text summary kept in sync
argument-hint: <what to diagram, e.g. "billing data flow"> [--board]
---

Plugin files: the standard and templates are in `${CLAUDE_PLUGIN_ROOT}/skills/engineering-memory/` (STANDARD.md and templates/). If that path does not resolve, locate them with: `find ~/.claude/plugins -type d -path "*engineering-memory/templates" 2>/dev/null | head -1`.

Subject: $ARGUMENTS

## Rules
- **Text is the source of truth.** Every diagram exists first as Mermaid inside a Markdown doc (docs/architecture/*.md or docs/features/*.md). Claude reads and edits Mermaid; tldraw boards are visual companions.
- **Every board has a summary.** docs/architecture/boards/<slug>.tldr is always accompanied by docs/architecture/boards/<slug>.md (templates/board.md) describing in words what the board shows, and by an exported <slug>.svg for embedding.
- **Never upload client diagrams.** When exporting with tldraw-cli ALWAYS pass `--local`. Never use a remote/hosted tldraw service for a repo's architecture unless I explicitly approve it for that repo.
- Only draw what the code and docs support. Unknown connections are labelled "unconfirmed", never invented.

## Steps
1. Read the relevant docs: docs/architecture/overview.md, module CLAUDE.md files, feature docs and ADRs for the subject. Verify against the code (entry points, calls, queues, DB tables, external services).
2. Write or update the Mermaid diagram in the right Markdown doc (flowchart for flows, sequenceDiagram for calls, erDiagram for data, C4-style flowchart with subgraphs for architecture). Add a 1-3 sentence reading under it and link related ADRs.
3. If `--board` was given, or the doc already has a board, create/update the tldraw board:
   - If a tldraw MCP server is available in this session (e.g. tools from a tldraw MCP), use it to create or edit docs/architecture/boards/<slug>.tldr. Prefer a local/headless server.
   - If none is available, tell me and suggest installing a local one, e.g.
     `claude plugin marketplace add m9810223/tldraw-m9810223` then `claude plugin install tldraw-m9810223@tldraw-m9810223`.
     Do not hand-write .tldr JSON unless I ask.
   - Lay out the board to match the Mermaid diagram (same nodes, same names, same direction of arrows).
   - Export: `npx @kitschpatrol/tldraw-cli export docs/architecture/boards/<slug>.tldr --local --format svg --output docs/architecture/boards/` (check the CLI's --help for exact flags if this fails; never drop --local).
   - Write/update docs/architecture/boards/<slug>.md from templates/board.md and embed the SVG in the related doc: `![<title>](boards/<slug>.svg)`.
4. If a board was edited by a person (the .tldr changed but its .md did not), read the board and update the .md summary and the Mermaid diagram so text and picture agree; list any differences you could not reconcile.
5. Update docs/architecture/README.md (or docs/README.md) to list the diagram/board.
6. Summarise what was drawn, where, and anything marked "unconfirmed".
