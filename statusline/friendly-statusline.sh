#!/bin/bash
# ABOUTME: Beginner-friendly Claude Code status line with traffic light context indicator.
# ABOUTME: Shows context health, model warnings, and project name using plain emoji — no special fonts needed.

input=$(cat)

# Parse JSON — try jq first, fall back to python3
if command -v jq &>/dev/null; then
  pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | awk '{printf "%d", $1}')
  raw_model=$(echo "$input" | jq -r 'if .model | type == "object" then .model.display_name else .model end // "unknown"')
  cwd=$(echo "$input" | jq -r '.workspace.current_dir // "."')
elif command -v python3 &>/dev/null; then
  eval "$(echo "$input" | python3 -c "
import sys, json
d = json.load(sys.stdin)
m = d.get('model', 'unknown')
if isinstance(m, dict): m = m.get('display_name', 'unknown')
pct = int(d.get('context_window', {}).get('used_percentage', 0))
cwd = d.get('workspace', {}).get('current_dir', '.')
print(f'pct={pct}')
print(f'raw_model=\"{m}\"')
print(f'cwd=\"{cwd}\"')
")"
else
  # No JSON parser available — show minimal fallback
  printf "📁 Claude Code\n"
  exit 0
fi

project=$(basename "$cwd")

# Context traffic light — lower thresholds to encourage early compacting
if (( pct >= 60 )); then
  context="🔴 Running low on context — type /compact now"
elif (( pct >= 40 )); then
  context="🟡 Context filling up — type /compact"
else
  context="🟢 Plenty of context"
fi

# Model warning — only shown when not on the best model
model_warn=""
if echo "$raw_model" | grep -qi "haiku\|sonnet"; then
  model_warn=" · ⚡ Fast mode"
fi

printf "%s · %s%s\n" "$context" "$project" "$model_warn"
