# Claude Warm-up

Tiny manual and scheduled warm-up for Claude Code usage windows.

The goal is to send one minimal Claude Code request before or during work so the 5-hour usage window is already active when you need it.

## Important

This uses your Claude Code subscription login token, not an Anthropic API key, when `CLAUDE_CODE_OAUTH_TOKEN` is set. Using an API key would use API billing instead and may not affect the Claude Code subscription window.

## Schedule

The workflow runs on weekdays at:

- 6:00 AM Vancouver during PDT → anchors a window until ~11:00 AM
- 11:00 AM Vancouver during PDT → anchors a window until ~4:00 PM
- 4:00 PM Vancouver during PDT → anchors a window until ~9:00 PM

GitHub Actions uses UTC. During PDT (UTC-7) the workflow uses:

```yaml
- cron: "0 13 * * 1-5" # 6:00 AM PDT
- cron: "0 18 * * 1-5" # 11:00 AM PDT
- cron: "0 23 * * 1-5" # 4:00 PM PDT
```

During PST (UTC-8), shift each cron +1 hour UTC if exact local time matters.

Each successful run starts (or restarts) your ~5-hour Claude Code session for the same subscription account as `CLAUDE_CODE_OAUTH_TOKEN`. It does not keep Current session permanently “on” in Settings — after ~5 hours the UI goes back to “Starts when a message is sent” until the next counted message.

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
