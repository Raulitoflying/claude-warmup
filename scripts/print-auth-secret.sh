#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
Create a GitHub Actions secret named CLAUDE_CODE_OAUTH_TOKEN.

Generate the token locally with:

  claude setup-token

Then paste the token value into:

  GitHub repo -> Settings -> Secrets and variables -> Actions

Keep this secret private. It contains your Claude Code subscription login token.
EOF
