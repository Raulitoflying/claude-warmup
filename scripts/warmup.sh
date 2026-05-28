#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${CLAUDE_CODE_OAUTH_TOKEN:-}" && -z "${ANTHROPIC_API_KEY:-}" ]]; then
  echo "Missing Claude auth. Set CLAUDE_CODE_OAUTH_TOKEN or ANTHROPIC_API_KEY." >&2
  exit 1
fi

if [[ -n "${CLAUDE_CODE_OAUTH_TOKEN:-}" ]]; then
  export CLAUDE_CODE_OAUTH_TOKEN
  CLAUDE_CODE_OAUTH_TOKEN="$(printf '%s' "$CLAUDE_CODE_OAUTH_TOKEN" | tr -d '[:space:]')"
fi

PROMPT="${CLAUDE_WARMUP_PROMPT:-Reply with exactly: OK.}"

if command -v claude >/dev/null 2>&1; then
  CLAUDE_BIN="claude"
else
  CLAUDE_BIN="./node_modules/.bin/claude"
fi

printf '%s\n' "$PROMPT" | "$CLAUDE_BIN" \
  --print \
  --no-session-persistence \
  --permission-mode dontAsk \
  --tools ""
