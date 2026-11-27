#!/usr/bin/env bash
# SessionStart hook: remind Claude of the standard and surface the latest handoff note.
root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0
[ -d docs/adr ] || exit 0

echo "This repo follows the Engineering Memory Standard (engineering-memory skill). Read module CLAUDE.md, feature docs and ADRs before coding; update them in the same change."
latest=$(ls -1t docs/sessions/*.md 2>/dev/null | grep -v template.md | head -1)
if [ -n "$latest" ]; then
  echo "Latest session handoff: $latest"
  echo "----"
  head -n 40 "$latest"
fi
exit 0
