#!/bin/bash
# JAZZ LOCK — encrypt your API key with a password
# Run this ONCE on your own machine. It saves the encrypted key to config/vault.

set -u

JAZZ_VERSION="1.0.0"

# Secure file creation — vault should not be world-readable
umask 0077

C='\033[0;36m'
G='\033[0;32m'
R='\033[0;31m'
Y='\033[1;33m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VAULT_FILE="${SCRIPT_DIR}/config/vault"

# ── Options ──
VERBOSE=0
DRY_RUN=0

# ── Helpers ──
die() {
  printf "\n  ${R}✗${N} %s\n\n" "$1"
  exit 1
}

quiet() {
  if [ "$VERBOSE" -eq 1 ]; then
    "$@"
  else
    "$@" 2>/dev/null
  fi
}

usage() {
  cat <<'EOF'
JAZZ LOCK — encrypt your API key with a password

Usage: jazz-lock.sh [OPTIONS]

Options:
  -h, --help      Show this help message
  -v, --version   Print version
  --verbose       Show detailed output
  --dry-run       Show what would happen without saving

Run this once on your own machine to encrypt your Anthropic API key.
The encrypted vault file is safe to commit to git.
EOF
}

# ── Argument parsing ──
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)    usage; exit 0 ;;
    -v|--version) echo "JAZZ ${JAZZ_VERSION}"; exit 0 ;;
    --verbose)    VERBOSE=1 ;;
    --dry-run)    DRY_RUN=1 ;;
    *)            die "Unknown option: $1. Use --help for usage." ;;
  esac
  shift
done

echo
printf "${C}  JAZZ LOCK${N} ${D}— encrypt your API key${N}\n"
printf "${D}  ──────────────────────────────────${N}\n"
echo

# Get password
printf "  ${W}Set a password for JAZZ:${N} "
read -rs password
echo
printf "  ${W}Confirm password:${N} "
read -rs password2
echo
echo

if [ "$password" != "$password2" ]; then
  printf "  ${R}✗${N} Passwords don't match.\n\n"
  exit 1
fi

if [ -z "$password" ]; then
  printf "  ${R}✗${N} Password can't be empty.\n\n"
  exit 1
fi

if [ ${#password} -lt 8 ]; then
  printf "  ${R}✗${N} Password must be at least 8 characters.\n\n"
  exit 1
fi

# Get API key
printf "  ${W}Enter your Anthropic API key:${N} "
read -rs api_key
echo
echo

if [ -z "$api_key" ]; then
  printf "  ${R}✗${N} API key can't be empty.\n\n"
  exit 1
fi

if [ "$DRY_RUN" -eq 1 ]; then
  printf "  ${D}[dry-run]${N} Would encrypt API key and save to config/vault\n\n"
  exit 0
fi

# Encrypt the API key with the password using openssl
# Use fd:3 to avoid password appearing in process list (ps aux)
mkdir -p "${SCRIPT_DIR}/config"
echo -n "$api_key" | quiet openssl enc -aes-256-cbc -pbkdf2 -iter 600000 -salt -pass fd:3 -base64 -out "$VAULT_FILE" 3<<< "$password"

if [ $? -eq 0 ] && [ -s "$VAULT_FILE" ]; then
  printf "  ${G}✓${N} API key encrypted and saved to ${D}config/vault${N}\n"
  echo
  printf "  ${D}Now commit and push:${N}\n"
  printf "  ${W}git add config/vault && git commit -m \"update vault\" && git push${N}\n"
  echo
else
  printf "  ${R}✗${N} Encryption failed.\n\n"
  exit 1
fi
