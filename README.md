# JAZZ

One command. Any laptop. Claude Code ready.

```bash
curl -sL jauz256.github.io/jazz/s | bash
```

## What it does

- Installs Claude Code (idempotent — skips if already installed)
- Decrypts your API key from the encrypted vault
- Deploys your full config: skills, commands, GSD, agents, hooks, memory
- Launches Claude Code
- Ghost mode: wipes everything when you're done (no trace left)

## Flags

Run locally with flags:

```bash
# Verbose output (show stderr, debug info)
./setup.sh --verbose

# Persistent install (skip ghost mode cleanup)
./setup.sh --no-ghost

# Dry run (preview without changes)
./setup.sh --dry-run

# Health check on existing installation
./setup.sh --verify

# Show help
./setup.sh --help

# Show version
./setup.sh --version
```

All three scripts (`setup.sh`, `jazz-sync.sh`, `jazz-lock.sh`) support `--help`, `--version`, `--verbose`, and `--dry-run`.

## Scripts

| Script | Purpose |
|--------|---------|
| `setup.sh` | Bootstrap — install, configure, launch, clean up |
| `jazz-lock.sh` | Encrypt your API key into `config/vault` |
| `jazz-sync.sh` | Package `~/.claude/` config and push to GitHub |

## Setup your vault

```bash
./jazz-lock.sh
# Enter a password (min 8 characters) and your Anthropic API key
# Commit and push the encrypted vault
```

## Sync your config

After changing skills, commands, or settings locally:

```bash
./jazz-sync.sh
```
