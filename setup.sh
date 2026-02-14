#!/bin/bash
# JAZZ — one command, anywhere, any laptop

set -e

# Colors
R='\033[0;31m'
G='\033[0;32m'
B='\033[0;34m'
C='\033[0;36m'
Y='\033[1;33m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

# Typing effect
type_text() {
  local text="$1"
  local delay="${2:-0.03}"
  for ((i=0; i<${#text}; i++)); do
    printf "%s" "${text:$i:1}"
    sleep "$delay"
  done
  echo
}

# Progress spinner
spin() {
  local msg="$1"
  local pid="$2"
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r  ${C}${frames[$i]}${N} ${msg}"
    i=$(( (i + 1) % ${#frames[@]} ))
    sleep 0.1
  done
  wait "$pid" 2>/dev/null
  local exit_code=$?
  if [ $exit_code -eq 0 ]; then
    printf "\r  ${G}✓${N} ${msg}\n"
  else
    printf "\r  ${R}✗${N} ${msg}\n"
    return $exit_code
  fi
}

clear

# ASCII art intro
echo
printf "${C}"
cat << 'BANNER'

         ██╗ █████╗ ███████╗███████╗
         ██║██╔══██╗╚══███╔╝╚══███╔╝
         ██║███████║  ███╔╝   ███╔╝
    ██   ██║██╔══██║ ███╔╝   ███╔╝
    ╚█████╔╝██║  ██║███████╗███████╗
     ╚════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

BANNER
printf "${N}"
printf "${D}    ──────────────────────────────────${N}\n"
printf "${W}    CLAUDE CODE  ${D}•${N}  ${Y}deploy anywhere${N}\n"
printf "${D}    ──────────────────────────────────${N}\n"
echo
sleep 0.5

type_text "  Initializing secure environment..." 0.02
echo
sleep 0.3

# ── Step 1: Detect OS ──
OS="$(uname -s)"
printf "  ${D}▸${N} System detected: ${W}${OS}${N}\n"
sleep 0.2

# ── Step 2: Check Node.js ──
if command -v node &>/dev/null; then
  NODE_V=$(node -v)
  printf "  ${G}✓${N} Node.js ${W}${NODE_V}${N} found\n"
else
  echo
  printf "  ${Y}⚠${N}  Node.js not found. Installing...\n"
  echo

  if [[ "$OS" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
      brew install node 2>/dev/null &
      spin "Installing Node.js via Homebrew" $!
    else
      printf "  ${R}✗${N} Homebrew not found. Install Node.js first:\n"
      printf "    ${C}https://nodejs.org${N}\n"
      exit 1
    fi
  elif [[ "$OS" == "Linux" ]]; then
    if command -v apt-get &>/dev/null; then
      (curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs) &>/dev/null &
      spin "Installing Node.js" $!
    elif command -v dnf &>/dev/null; then
      sudo dnf install -y nodejs &>/dev/null &
      spin "Installing Node.js" $!
    else
      printf "  ${R}✗${N} Install Node.js manually: ${C}https://nodejs.org${N}\n"
      exit 1
    fi
  fi
fi
sleep 0.2

# ── Step 3: Install Claude Code ──
if command -v claude &>/dev/null; then
  printf "  ${G}✓${N} Claude Code already installed\n"
else
  npm install -g @anthropic-ai/claude-code &>/dev/null &
  spin "Installing Claude Code" $!
fi
sleep 0.2

# ── Step 4: Pull config from GitHub ──
REPO_URL="https://raw.githubusercontent.com/Jauz256/jazz/main/config"

echo
printf "  ${D}▸${N} Syncing personal config...\n"

mkdir -p ~/.claude/projects ~/.claude/memory 2>/dev/null

# Try to pull config — skip silently if repo doesn't exist yet
if curl -sf "${REPO_URL}/CLAUDE.md" -o ~/.claude/CLAUDE.md 2>/dev/null; then
  printf "  ${G}✓${N} CLAUDE.md synced\n"
else
  printf "  ${Y}○${N} No remote config found — using local auth\n"
fi

if curl -sf "${REPO_URL}/memory/MEMORY.md" -o ~/.claude/memory/MEMORY.md 2>/dev/null; then
  printf "  ${G}✓${N} Memory synced\n"
fi

sleep 0.2

# ── Step 5: Authentication ──
echo
printf "${D}  ─────────────────────────────────${N}\n"
echo

# Check if API key is provided via env or needs login
if [ -n "$ANTHROPIC_API_KEY" ]; then
  printf "  ${G}✓${N} API key detected\n"
else
  printf "  ${W}Choose auth method:${N}\n"
  echo
  printf "    ${C}1${N} │ Claude Pro login (opens browser)\n"
  printf "    ${C}2${N} │ Enter API key\n"
  echo
  printf "  ${D}▸${N} "
  read -r auth_choice

  case "$auth_choice" in
    2)
      echo
      printf "  ${D}▸${N} API key: "
      read -rs api_key
      echo
      export ANTHROPIC_API_KEY="$api_key"
      printf "  ${G}✓${N} API key set for this session\n"
      ;;
    *)
      echo
      printf "  ${D}▸${N} Browser will open for login...\n"
      sleep 1
      ;;
  esac
fi

sleep 0.3

# ── Ready ──
echo
printf "${D}  ─────────────────────────────────${N}\n"
echo
printf "  ${G}█${N} ${W}Ready.${N}\n"
echo
type_text "  Launching Claude Code..." 0.03
echo
sleep 0.5

# Launch
exec claude
