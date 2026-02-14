#!/bin/bash
# JAZZ LOCK — encrypt your API key with a password
# Run this ONCE on your own machine. It saves the encrypted key to config/vault.

set -u

C='\033[0;36m'
G='\033[0;32m'
R='\033[0;31m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VAULT_FILE="${SCRIPT_DIR}/config/vault"

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

# Get API key
printf "  ${W}Enter your Anthropic API key:${N} "
read -rs api_key
echo
echo

if [ -z "$api_key" ]; then
  printf "  ${R}✗${N} API key can't be empty.\n\n"
  exit 1
fi

# Encrypt the API key with the password using openssl
mkdir -p "${SCRIPT_DIR}/config"
echo -n "$api_key" | openssl enc -aes-256-cbc -pbkdf2 -salt -pass "pass:${password}" -base64 -out "$VAULT_FILE" 2>/dev/null

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
