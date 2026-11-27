#!/usr/bin/env bash
# Stop hook: if code changed but no memory docs changed, ask Claude once to update docs
# or state that none are needed. No-op in repos that have not adopted the standard.
input=$(cat)

# Loop guard: only nudge once per stop.
if command -v jq >/dev/null 2>&1; then
  active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
else
  printf '%s' "$input" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true' && active=true || active=false
fi
[ "$active" = "true" ] && exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0
[ -d docs/adr ] || exit 0   # standard not adopted here

changed=$( { git diff --name-only HEAD 2>/dev/null; git ls-files --others --exclude-standard 2>/dev/null; } | sort -u)
[ -z "$changed" ] && exit 0

code=$(printf '%s\n' "$changed" | grep -vE '(^docs/|\.md$|^\.claude/|^\.github/|(^|/)(package-lock\.json|yarn\.lock|pnpm-lock\.yaml|go\.sum)$)')
docs=$(printf '%s\n' "$changed" | grep -E '^docs/(adr|bugs|lessons|features|algorithms|design|incidents)/|(^|/)CLAUDE\.md$|^docs/todo-debt\.md$')

if [ -n "$code" ] && [ -z "$docs" ]; then
  cat <<'JSON'
{"decision":"block","reason":"Engineering memory check: code changed but no memory docs were updated. If this changed logic, data model, flow or fixed a bug: update the ADR / feature Evolution / bug record / lesson / module CLAUDE.md as the engineering-memory skill requires. If it was trivial (formatting, rename, config), reply with 'No doc update needed: <reason>'."}
JSON
fi
exit 0
