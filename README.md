# Claude Warm-up

Tiny manual and scheduled warm-up for Claude Code usage windows.

The goal is to send one minimal Claude Code request before or during work so the 5-hour usage window is already active when you need it.

## Important

This uses your Claude Code subscription login token, not an Anthropic API key, when `CLAUDE_CODE_OAUTH_TOKEN` is set. Using an API key would use API billing instead and may not affect the Claude Code subscription window.

## Schedule

The workflow runs on weekdays at:

- 6:00 AM Vancouver during PDT
- 11:00 AM Vancouver during PDT
- 4:00 PM Vancouver during PDT

GitHub Actions uses UTC, so the workflow currently uses:

```yaml
- cron: "0 13 * * 1-5"
```

You can also run it manually from GitHub Actions with `Run workflow`.

## Prepare the secret

From your local machine:

```bash
cd /Users/rauloptix/OptixHelp/claude-warmup
./scripts/print-auth-secret.sh
claude setup-token
```

Copy the token into your private GitHub repo as:

```text
CLAUDE_CODE_OAUTH_TOKEN
```

Keep this secret private. It contains your Claude Code subscription login token.

## Local test

```bash
CLAUDE_CODE_OAUTH_TOKEN="token-from-claude-setup-token" ./scripts/warmup.sh
```

Expected output is just:

```text
OK
```
