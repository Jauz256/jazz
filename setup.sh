#!/bin/bash
# JAZZ — one command, anywhere, any laptop
#
# Bulletproof bootstrap script for Claude Code.
# Works on macOS and Linux. Idempotent. No Node.js required.
# Uses the official Anthropic installer.
#
# Compatible with macOS bash 3.2 and curl | bash piping.
# No set -e, no set -u. Errors handled manually.

JAZZ_VERSION="1.0.0"

# ── Colors ──
R='\033[0;31m'
G='\033[0;32m'
B='\033[0;34m'
C='\033[0;36m'
Y='\033[1;33m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

# ── Options (defaults) ──
VERBOSE=0
DRY_RUN=0
NO_GHOST=0
VERIFY_MODE=0

# ── Secure file creation ──
umask 0077

# ── Helpers ──
die() {
  printf "\n  ${R}✗${N} %s\n\n" "$1"
  exit 1
}

has() {
  command -v "$1" >/dev/null 2>&1
}

quiet() {
  if [ "$VERBOSE" -eq 1 ]; then
    "$@"
  else
    "$@" 2>/dev/null
  fi
}

# ── Audit log ──
JAZZ_LOG="$HOME/.claude/.jazz-install.log"
JAZZ_MANIFEST="$HOME/.claude/.jazz-manifest"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$JAZZ_LOG" 2>/dev/null
}

# ── Usage ──
usage() {
  cat <<'EOF'
JAZZ — Claude Code bootstrap tool

Usage: setup.sh [OPTIONS]
       curl -sL <URL> | bash -s -- [OPTIONS]

Options:
  -h, --help      Show this help message
  -v, --version   Print version
  --verbose       Show detailed output (don't suppress stderr)
  --dry-run       Show what would happen without making changes
  --no-ghost      Skip ghost mode cleanup after Claude exits
  --verify        Run health check on existing installation

Examples:
  curl -sL <URL> | bash                    # Standard install
  curl -sL <URL> | bash -s -- --verbose    # Verbose install
  curl -sL <URL> | bash -s -- --no-ghost   # Persistent install
  ./setup.sh --verify                      # Check installation health
  ./setup.sh --dry-run                     # Preview without changes
EOF
}

# ── Typing effect ──
type_text() {
  local text="$1"
  local delay="${2:-0.03}"
  local i=0
  local len=${#text}
  while [ "$i" -lt "$len" ]; do
    printf "%s" "${text:$i:1}"
    sleep "$delay"
    i=$((i + 1))
  done
  echo
}

# ── Progress spinner (animated) ──
spin() {
  local msg="$1"
  local pid="$2"
  local i=0
  local frame=""
  while kill -0 "$pid" 2>/dev/null; do
    case $((i % 4)) in
      0) frame='/' ;;
      1) frame='-' ;;
      2) frame='\' ;;
      3) frame='|' ;;
    esac
    printf "\r  ${C}${frame}${N} ${msg}"
    i=$((i + 1))
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

# ── Detect platform ──
detect_platform() {
  local os arch
  os="$(uname -s)"
  arch="$(uname -m)"

  case "$os" in
    Darwin) PLATFORM_OS="macOS" ;;
    Linux)  PLATFORM_OS="Linux" ;;
    *)      die "Unsupported operating system: $os (macOS and Linux only)" ;;
  esac

  case "$arch" in
    x86_64|amd64) PLATFORM_ARCH="x64" ;;
    arm64|aarch64) PLATFORM_ARCH="arm64" ;;
    *)             PLATFORM_ARCH="$arch" ;;
  esac
}

# ── URL fetch wrapper (curl with wget fallback) ──
fetch_url() {
  local url="$1"
  local output="$2"
  if has curl; then
    if [ "$VERBOSE" -eq 1 ]; then
      curl -fSL --connect-timeout 15 --max-time 120 "$url" -o "$output"
    else
      curl -fsSL --connect-timeout 15 --max-time 120 "$url" -o "$output" 2>/dev/null
    fi
  elif has wget; then
    quiet wget -q --timeout=120 -O "$output" "$url"
  else
    return 1
  fi
}

# ── Fetch with retry (3 attempts, configurable backoff) ──
fetch_with_retry() {
  local url="$1"
  local output="$2"
  local max_attempts="${3:-3}"
  local delay="${4:-2}"
  local attempt=1

  while [ "$attempt" -le "$max_attempts" ]; do
    if fetch_url "$url" "$output"; then
      return 0
    fi
    if [ "$attempt" -lt "$max_attempts" ]; then
      printf "  ${Y}⚠${N}  Download attempt ${attempt} failed, retrying...\n"
      log "Download attempt ${attempt} failed for ${url}"
      sleep "$delay"
    fi
    attempt=$((attempt + 1))
  done
  return 1
}

# ── Step counter ──
TOTAL_STEPS=4
CURRENT_STEP=0

step() {
  CURRENT_STEP=$((CURRENT_STEP + 1))
  printf "\n  ${C}[${CURRENT_STEP}/${TOTAL_STEPS}]${N} ${W}$1${N}\n"
  log "Step ${CURRENT_STEP}/${TOTAL_STEPS}: $1"
}

# ── Pre-flight dependency checks ──
require_tools() {
  # curl or wget required for downloads
  if ! has curl && ! has wget; then
    die "Neither curl nor wget found. Please install one and retry."
  fi

  # tar required for config extraction
  if ! has tar; then
    die "tar is required but not found. Please install tar and retry."
  fi

  # sed required for path fixups
  if ! has sed; then
    die "sed is required but not found. Please install sed and retry."
  fi

  # openssl needed for vault decryption (warn only — not fatal if no vault)
  if ! has openssl; then
    printf "  ${Y}⚠${N}  openssl not found — vault decryption will be unavailable\n"
    log "Warning: openssl not found"
  fi
}

# ── Health check (--verify) ──
verify_install() {
  echo
  printf "${C}  JAZZ VERIFY${N} ${D}— health check${N}\n"
  printf "${D}  ──────────────────────────────────${N}\n"
  echo

  local issues=0

  # Claude binary
  if has claude; then
    local ver
    ver=$(claude --version 2>/dev/null || echo "unknown")
    printf "  ${G}✓${N} Claude Code binary found ${D}(${ver})${N}\n"
  else
    printf "  ${R}✗${N} Claude Code binary not found\n"
    issues=$((issues + 1))
  fi

  # Config directory
  if [ -d "$HOME/.claude" ]; then
    printf "  ${G}✓${N} ~/.claude/ directory exists\n"
  else
    printf "  ${R}✗${N} ~/.claude/ directory missing\n"
    issues=$((issues + 1))
  fi

  # settings.json
  if [ -f "$HOME/.claude/settings.json" ]; then
    printf "  ${G}✓${N} settings.json present\n"
  else
    printf "  ${R}✗${N} settings.json missing\n"
    issues=$((issues + 1))
  fi

  # CLAUDE.md
  if [ -f "$HOME/.claude/CLAUDE.md" ]; then
    printf "  ${G}✓${N} CLAUDE.md present\n"
  else
    printf "  ${Y}○${N} CLAUDE.md not found\n"
  fi

  # Skills
  if [ -d "$HOME/.claude/skills" ]; then
    local scount
    scount=$(ls "$HOME/.claude/skills" 2>/dev/null | wc -l | tr -d ' ')
    printf "  ${G}✓${N} ${scount} skills installed\n"
  else
    printf "  ${R}✗${N} No skills directory\n"
    issues=$((issues + 1))
  fi

  # Commands
  if [ -d "$HOME/.claude/commands" ]; then
    local ccount
    ccount=$(ls "$HOME/.claude/commands" 2>/dev/null | wc -l | tr -d ' ')
    printf "  ${G}✓${N} ${ccount} command sets installed\n"
  else
    printf "  ${Y}○${N} No commands directory\n"
  fi

  # API key
  if [ -n "${ANTHROPIC_API_KEY:-}" ]; then
    printf "  ${G}✓${N} API key set in environment\n"
  else
    printf "  ${Y}○${N} No API key in environment ${D}(will need vault or manual setup)${N}\n"
  fi

  echo
  if [ "$issues" -eq 0 ]; then
    printf "  ${G}█${N} ${W}All checks passed.${N}\n"
  else
    printf "  ${Y}█${N} ${W}${issues} issue(s) found.${N}\n"
  fi
  echo
}

# ── Snapshot pre-existing state (for manifest-aware ghost mode) ──
snapshot_pre_state() {
  # Record what existed before JAZZ touched anything.
  # Ghost mode uses this to only remove what JAZZ created.
  # Idempotency: skip if manifest already exists (second run).

  if [ -f "$JAZZ_MANIFEST" ]; then
    log "Manifest already exists — skipping snapshot (idempotent)"
    return 0
  fi

  # Write to temp file first, then atomic mv
  local m_tmp="${JAZZ_MANIFEST}.tmp.$$"

  # Manifest version for forward compatibility
  echo "JAZZ_MANIFEST_VERSION=1" > "$m_tmp"

  # Claude binary on PATH (not one we're about to install)
  if has claude; then
    echo "PRE_CLAUDE_BINARY=1" >> "$m_tmp"
  else
    echo "PRE_CLAUDE_BINARY=0" >> "$m_tmp"
  fi

  # Config files
  [ -f "$HOME/.claude/settings.json" ] \
    && echo "PRE_SETTINGS_JSON=1" >> "$m_tmp" \
    || echo "PRE_SETTINGS_JSON=0" >> "$m_tmp"

  [ -f "$HOME/.claude/CLAUDE.md" ] \
    && echo "PRE_CLAUDE_MD=1" >> "$m_tmp" \
    || echo "PRE_CLAUDE_MD=0" >> "$m_tmp"

  # Directories deployed by the kit
  [ -d "$HOME/.claude/skills" ] \
    && echo "PRE_SKILLS=1" >> "$m_tmp" \
    || echo "PRE_SKILLS=0" >> "$m_tmp"

  [ -d "$HOME/.claude/commands" ] \
    && echo "PRE_COMMANDS=1" >> "$m_tmp" \
    || echo "PRE_COMMANDS=0" >> "$m_tmp"

  [ -d "$HOME/.claude/agents" ] \
    && echo "PRE_AGENTS=1" >> "$m_tmp" \
    || echo "PRE_AGENTS=0" >> "$m_tmp"

  [ -d "$HOME/.claude/get-shit-done" ] \
    && echo "PRE_GSD=1" >> "$m_tmp" \
    || echo "PRE_GSD=0" >> "$m_tmp"

  [ -d "$HOME/.claude/hooks" ] \
    && echo "PRE_HOOKS=1" >> "$m_tmp" \
    || echo "PRE_HOOKS=0" >> "$m_tmp"

  [ -d "$HOME/.claude/plugins" ] \
    && echo "PRE_PLUGINS=1" >> "$m_tmp" \
    || echo "PRE_PLUGINS=0" >> "$m_tmp"

  [ -d "$HOME/.claude/memory" ] \
    && echo "PRE_MEMORY=1" >> "$m_tmp" \
    || echo "PRE_MEMORY=0" >> "$m_tmp"

  # User data directories
  [ -d "$HOME/.claude/local" ] \
    && echo "PRE_LOCAL=1" >> "$m_tmp" \
    || echo "PRE_LOCAL=0" >> "$m_tmp"

  [ -d "$HOME/.claude/projects" ] \
    && echo "PRE_PROJECTS=1" >> "$m_tmp" \
    || echo "PRE_PROJECTS=0" >> "$m_tmp"

  [ -d "$HOME/.claude/cache" ] \
    && echo "PRE_CACHE=1" >> "$m_tmp" \
    || echo "PRE_CACHE=0" >> "$m_tmp"

  # Credentials
  [ -f "$HOME/.claude/.credentials.json" ] \
    && echo "PRE_CREDENTIALS=1" >> "$m_tmp" \
    || echo "PRE_CREDENTIALS=0" >> "$m_tmp"

  # GSD manifest file
  [ -f "$HOME/.claude/gsd-file-manifest.json" ] \
    && echo "PRE_GSD_MANIFEST=1" >> "$m_tmp" \
    || echo "PRE_GSD_MANIFEST=0" >> "$m_tmp"

  # Atomic move into place
  mv "$m_tmp" "$JAZZ_MANIFEST" 2>/dev/null || {
    rm -f "$m_tmp" 2>/dev/null
    log "Warning: failed to write manifest"
    return 1
  }

  log "Pre-state snapshot written to ${JAZZ_MANIFEST}"
}

# ── Temp file tracking ──
TMPFILE_INSTALLER=""
TMPFILE_KIT=""
TMPFILE_VAULT=""
EXTRACT_TMP=""

cleanup() {
  [ -n "$TMPFILE_INSTALLER" ] && rm -f "$TMPFILE_INSTALLER" 2>/dev/null
  [ -n "$TMPFILE_KIT" ] && rm -f "$TMPFILE_KIT" 2>/dev/null
  [ -n "$TMPFILE_VAULT" ] && rm -f "$TMPFILE_VAULT" 2>/dev/null
  [ -n "$EXTRACT_TMP" ] && rm -rf "$EXTRACT_TMP" 2>/dev/null
}
trap cleanup EXIT INT TERM

# ── Argument parsing ──
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)    usage; exit 0 ;;
    -v|--version) echo "JAZZ ${JAZZ_VERSION}"; exit 0 ;;
    --verbose)    VERBOSE=1 ;;
    --dry-run)    DRY_RUN=1 ;;
    --no-ghost)   NO_GHOST=1 ;;
    --verify)     VERIFY_MODE=1 ;;
    *)            die "Unknown option: $1. Use --help for usage." ;;
  esac
  shift
done

# ── Early exit: --verify ──
if [ "$VERIFY_MODE" -eq 1 ]; then
  verify_install
  exit 0
fi

# ── Initialize audit log ──
mkdir -p "$HOME/.claude" || die "Failed to create $HOME/.claude/ directory"
log "=== JAZZ ${JAZZ_VERSION} install started ==="
log "Platform: $(uname -s) $(uname -m)"
log "Options: verbose=${VERBOSE} dry_run=${DRY_RUN} no_ghost=${NO_GHOST}"

# ── Snapshot what already exists (before we modify anything) ──
snapshot_pre_state

# ── Pre-flight checks ──
require_tools

# ──────────────────────────────────────────────
#  MAIN
# ──────────────────────────────────────────────

# ASCII art intro
echo
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
printf "${D}    if you're not jazz, close this terminal.${N}\n"
printf "${D}    seriously. don't touch what you can't handle.${N}\n"
echo
sleep 0.5

# ════════════════════════════════════════════
#  Step 1: Password gate
# ════════════════════════════════════════════
step "Authentication"

REPO_URL="https://raw.githubusercontent.com/Jauz256/jazz/main/config"
VAULT_DATA=""

# Fetch vault with retry
TMPFILE_VAULT="$(mktemp "${TMPDIR:-/tmp}/jazz-vault-XXXXXX")"
if fetch_with_retry "${REPO_URL}/vault" "$TMPFILE_VAULT" 3 2 && [ -s "$TMPFILE_VAULT" ]; then
  VAULT_DATA=$(cat "$TMPFILE_VAULT")
fi
rm -f "$TMPFILE_VAULT" 2>/dev/null
TMPFILE_VAULT=""

if [ -n "$VAULT_DATA" ]; then
  # Vault exists — require password
  if ! has openssl; then
    die "Vault found but openssl is not installed. Cannot decrypt API key."
  fi

  printf "  ${D}▸${N} ${W}password:${N} "

  # Hide input: use stty with /dev/tty for curl|bash compatibility
  stty -echo < /dev/tty 2>/dev/null
  jazz_password=""
  read jazz_password < /dev/tty
  stty echo < /dev/tty 2>/dev/null
  echo

  if [ "$DRY_RUN" -eq 1 ]; then
    printf "  ${D}[dry-run]${N} Would decrypt vault with provided password\n"
  else
    # Try to decrypt — use fd:3 to avoid password appearing in process list (ps aux)
    # Try 600k iterations first (new vaults), fall back to default iterations (legacy vaults)
    DECRYPTED_KEY=$(echo "$VAULT_DATA" | openssl enc -aes-256-cbc -pbkdf2 -iter 600000 -salt -d -pass fd:3 -base64 3<<< "$jazz_password" 2>/dev/null || echo "")

    if [ -z "$DECRYPTED_KEY" ]; then
      log "600k-iter decrypt failed, trying legacy (default iterations, fd:3)"
      DECRYPTED_KEY=$(echo "$VAULT_DATA" | openssl enc -aes-256-cbc -pbkdf2 -salt -d -pass fd:3 -base64 3<<< "$jazz_password" 2>/dev/null || echo "")
    fi

    if [ -z "$DECRYPTED_KEY" ]; then
      log "fd:3 decrypt failed, trying legacy pass: method"
      DECRYPTED_KEY=$(echo "$VAULT_DATA" | openssl enc -aes-256-cbc -pbkdf2 -salt -d -pass "pass:${jazz_password}" -base64 2>/dev/null || echo "")
    fi

    if [ -z "$DECRYPTED_KEY" ]; then
      echo
      printf "  ${R}✗${N} ${W}Decryption failed${N} ${D}(wrong password or corrupted vault)${N}\n"
      echo
      log "Vault decryption failed"
      sleep 1
      exit 1
    fi

    export ANTHROPIC_API_KEY="$DECRYPTED_KEY"
    printf "  ${G}✓${N} Unlocked ${D}(welcome back, jazz)${N}\n"
    log "Vault decrypted successfully"
  fi
  echo
else
  printf "  ${Y}○${N} No vault found ${D}(run jazz-lock.sh to set one up)${N}\n"
  log "No vault found"
  echo
fi

sleep 0.3

type_text "  Hijacking this laptop real quick..." 0.02
echo
sleep 0.3

# ════════════════════════════════════════════
#  Step 2: Environment
# ════════════════════════════════════════════
step "Environment"

detect_platform
printf "  ${D}▸${N} Victim's machine: ${W}${PLATFORM_OS} (${PLATFORM_ARCH})${N}\n"
log "Platform: ${PLATFORM_OS} (${PLATFORM_ARCH})"
sleep 0.2

if has curl; then
  printf "  ${G}✓${N} curl available\n"
elif has wget; then
  printf "  ${G}✓${N} wget available ${D}(curl fallback)${N}\n"
fi
printf "  ${G}✓${N} tar available\n"
printf "  ${G}✓${N} sed available\n"
if has openssl; then
  printf "  ${G}✓${N} openssl available\n"
fi
sleep 0.1

# ════════════════════════════════════════════
#  Step 3: Install Claude Code (idempotent)
# ════════════════════════════════════════════
step "Claude Code"

if has claude; then
  CLAUDE_V=$(claude --version 2>/dev/null || echo "installed")
  printf "  ${G}✓${N} Claude Code already here ${D}(${CLAUDE_V}) — jazz was here before${N}\n"
  log "Claude Code already installed: ${CLAUDE_V}"
elif [ "$DRY_RUN" -eq 1 ]; then
  printf "  ${D}[dry-run]${N} Would install Claude Code\n"
else
  echo
  printf "  ${D}▸${N} No Claude Code? Amateurs. Installing...\n"
  echo

  # Download the installer to a temp file instead of piping to bash.
  INSTALLER_URL="https://claude.ai/install.sh"
  TMPFILE_INSTALLER="$(mktemp "${TMPDIR:-/tmp}/claude-install-XXXXXX.sh")"

  if ! fetch_with_retry "$INSTALLER_URL" "$TMPFILE_INSTALLER" 3 2; then
    die "Failed to download Claude Code installer from ${INSTALLER_URL}"
  fi

  # Verify the file is non-empty and looks like a shell script
  if [ ! -s "$TMPFILE_INSTALLER" ]; then
    die "Downloaded installer is empty. Check your network connection."
  fi

  FIRST_LINE=$(head -c 32 "$TMPFILE_INSTALLER")
  case "$FIRST_LINE" in
    '#!/'*|'#!'*) ;; # looks like a script — good
    *)
      die "Downloaded file does not appear to be a valid shell script. Aborting for safety."
      ;;
  esac

  chmod +x "$TMPFILE_INSTALLER"

  # Run the installer
  bash "$TMPFILE_INSTALLER" >/dev/null 2>&1 &
  if ! spin "Installing Claude Code" $!; then
    echo
    printf "  ${Y}⚠${N}  Installer returned an error. Trying fallback...\n"
    # Fallback: run non-silently so the user can see what happened
    bash "$TMPFILE_INSTALLER"
    echo
    if ! has claude; then
      die "Claude Code installation failed. Please install manually: https://docs.anthropic.com/en/docs/claude-code/getting-started"
    fi
  fi

  # The official installer may place the binary in ~/.claude/local/bin or similar.
  # Source profile updates so `claude` is on PATH in this session.
  for rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile" "$HOME/.bash_profile"; do
    if [ -f "$rc" ]; then
      # shellcheck disable=SC1090
      . "$rc" 2>/dev/null || true
    fi
  done

  # Also check common install locations directly
  for bindir in "$HOME/.claude/local/bin" "$HOME/.local/bin" "/usr/local/bin"; do
    if [ -x "$bindir/claude" ]; then
      export PATH="$bindir:$PATH"
      break
    fi
  done

  if has claude; then
    printf "  ${G}✓${N} Claude Code installed successfully\n"
    log "Claude Code installed"
  else
    die "Claude Code binary not found on PATH after install. You may need to restart your shell or add it to PATH."
  fi
fi
sleep 0.2

# ════════════════════════════════════════════
#  Step 4: Deploy configuration
# ════════════════════════════════════════════
step "Configuration"

KIT_URL="https://raw.githubusercontent.com/Jauz256/jazz/main/config/claude-kit.tar.gz"

echo
printf "  ${D}▸${N} Loading jazz's brain...\n"

mkdir -p "$HOME/.claude" 2>/dev/null

if [ "$DRY_RUN" -eq 1 ]; then
  printf "  ${D}[dry-run]${N} Would download and deploy config from GitHub\n"
else
  TMPFILE_KIT="$(mktemp "${TMPDIR:-/tmp}/claude-kit-XXXXXX.tar.gz")"

  # Download config with retry (3 attempts, 2s backoff)
  KIT_OK=0
  if fetch_with_retry "$KIT_URL" "$TMPFILE_KIT" 3 2 && [ -s "$TMPFILE_KIT" ]; then
    KIT_OK=1
  fi

  if [ "$KIT_OK" -eq 1 ]; then
    # Backup existing config before overwrite
    if [ -f "$HOME/.claude/settings.json" ] || [ -f "$HOME/.claude/CLAUDE.md" ]; then
      BACKUP_DIR="$HOME/.claude/.backup-$(date '+%Y%m%d-%H%M%S')"
      mkdir -p "$BACKUP_DIR"
      [ -f "$HOME/.claude/settings.json" ] && cp "$HOME/.claude/settings.json" "$BACKUP_DIR/"
      [ -f "$HOME/.claude/CLAUDE.md" ] && cp "$HOME/.claude/CLAUDE.md" "$BACKUP_DIR/"
      log "Backed up existing config to ${BACKUP_DIR}"
      printf "  ${G}✓${N} Existing config backed up ${D}(${BACKUP_DIR})${N}\n"
    fi

    # Safe extraction: extract to temp dir first, copy into ~/.claude/ only on success
    EXTRACT_TMP="$(mktemp -d "${TMPDIR:-/tmp}/jazz-extract-XXXXXX")"

    if quiet tar -xzf "$TMPFILE_KIT" -C "$EXTRACT_TMP"; then
      cp -R "$EXTRACT_TMP"/* "$HOME/.claude/" 2>/dev/null
      rm -rf "$EXTRACT_TMP"
      EXTRACT_TMP=""
      log "Config extracted successfully"
    else
      rm -rf "$EXTRACT_TMP"
      EXTRACT_TMP=""
      log "Config extraction failed"
      die "Config extraction failed (corrupted archive)"
    fi

    # Fix hardcoded paths in settings.json (replace /Users/aungkyawmin with actual $HOME)
    if [ -f "$HOME/.claude/settings.json" ]; then
      SETTINGS_TMP="$(mktemp "${TMPDIR:-/tmp}/jazz-settings-XXXXXX")"
      # Escape sed special chars in $HOME (handles &, \, |)
      ESCAPED_HOME=$(printf '%s\n' "$HOME" | sed 's/[&/\]/\\&/g')
      sed "s|/Users/aungkyawmin|${ESCAPED_HOME}|g" "$HOME/.claude/settings.json" > "$SETTINGS_TMP"
      if [ -s "$SETTINGS_TMP" ]; then
        mv "$SETTINGS_TMP" "$HOME/.claude/settings.json"
        printf "  ${G}✓${N} settings.json restored ${D}(paths adjusted)${N}\n"
        log "settings.json paths adjusted"
      else
        rm -f "$SETTINGS_TMP" 2>/dev/null
        printf "  ${Y}⚠${N}  Path substitution failed — settings.json unchanged\n"
        log "Warning: sed path substitution produced empty file, skipped"
      fi
    fi

    # If Node.js is not available, strip hooks/statusLine from settings.json
    # (hooks require node to execute — gracefully degrade instead of failing)
    if [ -f "$HOME/.claude/settings.json" ] && ! has node; then
      if has python3; then
        python3 -c "
import json, sys
try:
    with open(sys.argv[1], 'r') as f:
        data = json.load(f)
    changed = False
    if 'hooks' in data:
        del data['hooks']
        changed = True
    if 'statusLine' in data:
        del data['statusLine']
        changed = True
    if changed:
        with open(sys.argv[1], 'w') as f:
            json.dump(data, f, indent=2)
            f.write('\n')
except Exception:
    pass
" "$HOME/.claude/settings.json" 2>/dev/null
        printf "  ${Y}⚠${N}  Node.js not found — hooks/statusLine removed from settings.json\n"
        log "Node.js not found — stripped hooks/statusLine from settings.json"
      elif has python; then
        python -c "
import json, sys
try:
    with open(sys.argv[1], 'r') as f:
        data = json.load(f)
    changed = False
    if 'hooks' in data:
        del data['hooks']
        changed = True
    if 'statusLine' in data:
        del data['statusLine']
        changed = True
    if changed:
        with open(sys.argv[1], 'w') as f:
            json.dump(data, f, indent=2)
            f.write('\n')
except Exception:
    pass
" "$HOME/.claude/settings.json" 2>/dev/null
        printf "  ${Y}⚠${N}  Node.js not found — hooks/statusLine removed from settings.json\n"
        log "Node.js not found — stripped hooks/statusLine from settings.json (python2)"
      else
        printf "  ${Y}⚠${N}  Node.js not found — hooks may not work ${D}(no python to fix settings.json)${N}\n"
        log "Warning: Node.js and Python not found — hooks may not work"
      fi
    fi

    SKILL_COUNT=0
    CMD_COUNT=0
    AGENT_COUNT=0
    if [ -d "$HOME/.claude/skills" ]; then
      SKILL_COUNT=$(ls "$HOME/.claude/skills" 2>/dev/null | wc -l | tr -d ' ')
    fi
    if [ -d "$HOME/.claude/commands" ]; then
      CMD_COUNT=$(ls "$HOME/.claude/commands" 2>/dev/null | wc -l | tr -d ' ')
    fi
    if [ -d "$HOME/.claude/agents" ]; then
      AGENT_COUNT=$(ls "$HOME/.claude/agents" 2>/dev/null | wc -l | tr -d ' ')
    fi

    printf "  ${G}✓${N} Playbook loaded\n"
    printf "  ${G}✓${N} ${W}${SKILL_COUNT}${N} skills deployed ${D}(the full arsenal)${N}\n"
    printf "  ${G}✓${N} ${W}${CMD_COUNT}${N} command sets loaded ${D}(GSD + Ralph Loop)${N}\n"
    printf "  ${G}✓${N} ${W}${AGENT_COUNT}${N} agent definitions loaded\n"
    if [ -d "$HOME/.claude/get-shit-done" ]; then
      printf "  ${G}✓${N} GSD engine loaded\n"
    fi
    if [ -d "$HOME/.claude/hooks" ] && has node; then
      printf "  ${G}✓${N} Hooks active\n"
    fi
    printf "  ${G}✓${N} Memories intact ${D}(jazz never forgets)${N}\n"
    log "Config deployed: ${SKILL_COUNT} skills, ${CMD_COUNT} commands, ${AGENT_COUNT} agents"
  else
    printf "  ${Y}○${N} Config unavailable ${D}(continuing without skills/commands)${N}\n"
    log "Config download failed — continuing without config"
  fi
fi

sleep 0.2

# ── Ready ──
echo
printf "${D}  ─────────────────────────────────${N}\n"
echo
printf "  ${G}█${N} ${W}This laptop belongs to jazz now.${N}\n"
echo
type_text "  Let's build something stupid fast..." 0.03
echo
sleep 0.5

log "Setup complete — launching Claude"

if [ "$DRY_RUN" -eq 1 ]; then
  printf "  ${D}[dry-run]${N} Would launch claude\n"
  echo
  printf "  ${D}[dry-run]${N} Dry run complete. No changes made.\n"
  echo
  exit 0
fi

# ── Launch Claude, then clean up when done ──
# Don't use exec — we need control back after claude exits.
# Pass API key only to claude's env so it doesn't persist in parent shell on crash.
# Register trap so ghost mode runs even if terminal is closed (INT/TERM/HUP).
JAZZ_GHOST_NEEDED=1
ghost_on_signal() {
  if [ "${JAZZ_GHOST_NEEDED:-0}" -eq 1 ] && [ "${NO_GHOST}" -eq 0 ]; then
    log "Ghost mode triggered by signal"
    # Minimal emergency cleanup: wipe credentials and API key
    rm -f "$HOME/.claude/.credentials.json" 2>/dev/null
    unset ANTHROPIC_API_KEY 2>/dev/null
    rm -f "$JAZZ_MANIFEST" 2>/dev/null
    rm -f "$JAZZ_LOG" 2>/dev/null
    if [ "$(uname -s)" = "Darwin" ]; then
      security delete-generic-password -s "claude-code" 2>/dev/null || true
    fi
  fi
  exit 1
}
trap ghost_on_signal INT TERM HUP

# Redirect stdin from /dev/tty so claude gets terminal input, not the pipe from curl
claude < /dev/tty

# ── Ghost mode: leave no trace ──
if [ "$NO_GHOST" -eq 1 ]; then
  echo
  printf "  ${D}▸${N} Ghost mode skipped ${D}(--no-ghost)${N}\n"
  log "Ghost mode skipped (--no-ghost)"
  echo
  exit 0
fi

echo
echo
printf "${D}  ──────────────────────────────────${N}\n"
printf "${C}"
cat << 'GHOST'

     ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
    ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
    ██║  ███╗███████║██║   ██║███████╗   ██║
    ██║   ██║██╔══██║██║   ██║╚════██║   ██║
    ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║
     ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝

GHOST
printf "${N}"
printf "${D}  ──────────────────────────────────${N}\n"
printf "${W}    CLEANING UP  ${D}•${N}  ${Y}leaving no trace${N}\n"
printf "${D}  ──────────────────────────────────${N}\n"
echo
sleep 0.3

log "Ghost mode started"

# ── Safe manifest value lookup (no eval) ──
# Returns "1" if the key was marked as pre-existing, "0" otherwise.
# Uses case statement instead of eval to avoid code injection.
manifest_val() {
  local key="$1"
  case "$key" in
    PRE_CLAUDE_BINARY)  echo "$PRE_CLAUDE_BINARY" ;;
    PRE_SETTINGS_JSON)  echo "$PRE_SETTINGS_JSON" ;;
    PRE_CLAUDE_MD)      echo "$PRE_CLAUDE_MD" ;;
    PRE_SKILLS)         echo "$PRE_SKILLS" ;;
    PRE_COMMANDS)       echo "$PRE_COMMANDS" ;;
    PRE_AGENTS)         echo "$PRE_AGENTS" ;;
    PRE_GSD)            echo "$PRE_GSD" ;;
    PRE_GSD_MANIFEST)   echo "$PRE_GSD_MANIFEST" ;;
    PRE_HOOKS)          echo "$PRE_HOOKS" ;;
    PRE_PLUGINS)        echo "$PRE_PLUGINS" ;;
    PRE_MEMORY)         echo "$PRE_MEMORY" ;;
    PRE_LOCAL)          echo "$PRE_LOCAL" ;;
    PRE_PROJECTS)       echo "$PRE_PROJECTS" ;;
    PRE_CACHE)          echo "$PRE_CACHE" ;;
    PRE_CREDENTIALS)    echo "$PRE_CREDENTIALS" ;;
    *)                  echo "0" ;;  # Unknown keys default to "not pre-existed"
  esac
}

# ── Helpers: manifest-aware removal ──
# ghost_dir <dir_path> <manifest_key> <label>
#   If pre-existed → leave intact. If not → delete.
ghost_dir() {
  local dirpath="$1" key="$2" label="$3"
  if [ -d "$dirpath" ]; then
    if [ "${GHOST_HAS_MANIFEST}" -eq 1 ] && [ "$(manifest_val "$key")" = "1" ]; then
      printf "  ${Y}○${N} ${label} left intact ${D}(pre-existed)${N}\n"
      log "Ghost: kept ${dirpath} (pre-existed)"
    else
      rm -rf "$dirpath" 2>/dev/null
      printf "  ${G}✓${N} ${label} removed\n"
      log "Ghost: removed ${dirpath}"
    fi
  fi
}

# ghost_file <file_path> <manifest_key> <label>
#   If pre-existed → restore from most recent backup if available, else leave. If not → delete.
ghost_file() {
  local filepath="$1" key="$2" label="$3"
  local filename
  filename="$(basename "$filepath")"
  if [ -f "$filepath" ]; then
    if [ "${GHOST_HAS_MANIFEST}" -eq 1 ] && [ "$(manifest_val "$key")" = "1" ]; then
      # Try to restore from most recent backup (sorted reverse-chronologically)
      local restored=0
      local sorted_backups
      sorted_backups=$(ls -1d "$HOME/.claude/.backup-"* 2>/dev/null | sort -r)
      if [ -n "$sorted_backups" ]; then
        echo "$sorted_backups" | while IFS= read -r bdir; do
          if [ -f "$bdir/$filename" ] && [ -s "$bdir/$filename" ]; then
            cp "$bdir/$filename" "$filepath" 2>/dev/null
            printf "  ${G}✓${N} ${label} restored from backup\n"
            log "Ghost: restored ${filepath} from ${bdir}"
            return 0
          fi
        done
        # Check if subshell succeeded (return 0 means restored)
        if [ $? -eq 0 ]; then
          restored=1
        fi
      fi
      if [ "$restored" -eq 0 ]; then
        printf "  ${Y}○${N} ${label} left intact ${D}(pre-existed, no backup found)${N}\n"
        log "Ghost: kept ${filepath} (pre-existed, no backup)"
      fi
    else
      rm -f "$filepath" 2>/dev/null
      printf "  ${G}✓${N} ${label} removed\n"
      log "Ghost: removed ${filepath}"
    fi
  fi
}

# ── Load manifest (with validation) ──
GHOST_HAS_MANIFEST=0
JAZZ_MANIFEST_VERSION=0
PRE_CLAUDE_BINARY=0
PRE_SETTINGS_JSON=0
PRE_CLAUDE_MD=0
PRE_SKILLS=0
PRE_COMMANDS=0
PRE_AGENTS=0
PRE_GSD=0
PRE_GSD_MANIFEST=0
PRE_HOOKS=0
PRE_PLUGINS=0
PRE_MEMORY=0
PRE_LOCAL=0
PRE_PROJECTS=0
PRE_CACHE=0
PRE_CREDENTIALS=0

if [ -f "$JAZZ_MANIFEST" ]; then
  # Validate manifest: only allow lines matching KEY=0|1 or JAZZ_MANIFEST_VERSION=N
  MANIFEST_VALID=1
  while IFS= read -r line; do
    case "$line" in
      JAZZ_MANIFEST_VERSION=[0-9]*) ;;
      PRE_*=[01]) ;;
      "") ;;  # empty lines ok
      *) MANIFEST_VALID=0; break ;;
    esac
  done < "$JAZZ_MANIFEST"

  if [ "$MANIFEST_VALID" -eq 1 ]; then
    . "$JAZZ_MANIFEST"
    GHOST_HAS_MANIFEST=1
    log "Ghost: manifest v${JAZZ_MANIFEST_VERSION} loaded from ${JAZZ_MANIFEST}"
  else
    printf "  ${Y}⚠${N}  Manifest appears corrupted — falling back to full cleanup\n"
    log "Ghost: manifest validation failed, full cleanup"
  fi
else
  printf "  ${Y}⚠${N}  No manifest found — falling back to full cleanup\n"
  log "Ghost: no manifest found, full cleanup"
fi

# ── Credentials: ALWAYS wipe (security — never leave tokens behind) ──
if [ -f "$HOME/.claude/.credentials.json" ]; then
  rm -f "$HOME/.claude/.credentials.json" 2>/dev/null
  printf "  ${G}✓${N} Credentials wiped\n"
  log "Ghost: credentials wiped"
fi

# Remove OAuth tokens from keychain (macOS) — always
if [ "$(uname -s)" = "Darwin" ]; then
  security delete-generic-password -s "claude-code" 2>/dev/null && \
    printf "  ${G}✓${N} Keychain tokens removed\n" || true
fi

# Remove API key from environment — always
unset ANTHROPIC_API_KEY 2>/dev/null

# ── Config files: restore if pre-existed, delete if not ──
ghost_file "$HOME/.claude/settings.json" "PRE_SETTINGS_JSON" "Settings"
ghost_file "$HOME/.claude/CLAUDE.md" "PRE_CLAUDE_MD" "CLAUDE.md"

# ── Kit directories: leave if pre-existed, delete if not ──
ghost_dir "$HOME/.claude/skills" "PRE_SKILLS" "Skills"
ghost_dir "$HOME/.claude/commands" "PRE_COMMANDS" "Commands"
ghost_dir "$HOME/.claude/agents" "PRE_AGENTS" "Agents"
ghost_dir "$HOME/.claude/get-shit-done" "PRE_GSD" "GSD engine"
ghost_dir "$HOME/.claude/hooks" "PRE_HOOKS" "Hooks"
ghost_dir "$HOME/.claude/plugins" "PRE_PLUGINS" "Plugins"
ghost_dir "$HOME/.claude/memory" "PRE_MEMORY" "Memory"

# GSD manifest file
if [ -f "$HOME/.claude/gsd-file-manifest.json" ]; then
  if [ "${GHOST_HAS_MANIFEST}" -eq 1 ] && [ "$PRE_GSD_MANIFEST" = "1" ]; then
    printf "  ${Y}○${N} GSD manifest left intact ${D}(pre-existed)${N}\n"
  else
    rm -f "$HOME/.claude/gsd-file-manifest.json" 2>/dev/null
    printf "  ${G}✓${N} GSD manifest removed\n"
  fi
fi

# ── User data: leave if pre-existed, delete if not ──
ghost_dir "$HOME/.claude/local" "PRE_LOCAL" "Local data"
ghost_dir "$HOME/.claude/projects" "PRE_PROJECTS" "Project data"
ghost_dir "$HOME/.claude/cache" "PRE_CACHE" "Cache"

# ── Claude binary: only remove if we installed it ──
if [ "${GHOST_HAS_MANIFEST}" -eq 0 ] || [ "$PRE_CLAUDE_BINARY" = "0" ]; then
  for binpath in "$HOME/.local/bin/claude" "$HOME/.claude/local/bin/claude"; do
    if [ -f "$binpath" ]; then
      rm -f "$binpath" 2>/dev/null
      printf "  ${G}✓${N} Claude binary removed ${D}(${binpath})${N}\n"
      log "Ghost: removed binary ${binpath}"
    fi
  done
else
  printf "  ${Y}○${N} Claude binary left intact ${D}(pre-installed)${N}\n"
  log "Ghost: kept Claude binary (pre-installed)"
fi

# ── Shell history scrubbing: only if Claude wasn't pre-installed ──
# Uses precise patterns to avoid destroying unrelated history (e.g., "claude monet")
if [ "${GHOST_HAS_MANIFEST}" -eq 0 ] || [ "$PRE_CLAUDE_BINARY" = "0" ]; then
  for histfile in "$HOME/.zsh_history" "$HOME/.bash_history"; do
    if [ -f "$histfile" ]; then
      HIST_TMP="$(mktemp "${TMPDIR:-/tmp}/jazz-hist-XXXXXX")"
      # Only scrub lines that look like JAZZ invocations or API key setup
      grep -v 'setup\.sh\|jazz-lock\|jazz-sync\|ANTHROPIC_API_KEY\|claude-bootstrap\|Jauz256/jazz\|curl.*jazz' "$histfile" > "$HIST_TMP" 2>/dev/null
      if [ -s "$HIST_TMP" ]; then
        mv "$HIST_TMP" "$histfile" 2>/dev/null
      else
        rm -f "$HIST_TMP" 2>/dev/null
      fi
    fi
  done
  printf "  ${G}✓${N} Shell history scrubbed\n"
  log "Ghost: shell history scrubbed"
else
  printf "  ${Y}○${N} Shell history left intact ${D}(Claude pre-installed)${N}\n"
  log "Ghost: kept shell history (Claude pre-installed)"
fi

# ── Shell profile PATH cleanup: only if Claude wasn't pre-installed ──
# Only removes PATH lines pointing to .claude/local/bin (the Claude installer's PATH entry),
# not arbitrary lines that happen to mention ".claude"
if [ "${GHOST_HAS_MANIFEST}" -eq 0 ] || [ "$PRE_CLAUDE_BINARY" = "0" ]; then
  for profile in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.profile"; do
    if [ -f "$profile" ]; then
      PROF_TMP="$(mktemp "${TMPDIR:-/tmp}/jazz-prof-XXXXXX")"
      grep -v '\.claude/local/bin\|\.claude/bin' "$profile" > "$PROF_TMP" 2>/dev/null
      if [ -s "$PROF_TMP" ]; then
        mv "$PROF_TMP" "$profile" 2>/dev/null
      else
        rm -f "$PROF_TMP" 2>/dev/null
      fi
    fi
  done
  printf "  ${G}✓${N} Shell profile PATH entries cleaned\n"
  log "Ghost: shell profiles cleaned"
else
  printf "  ${Y}○${N} Shell profile PATH entries left intact ${D}(Claude pre-installed)${N}\n"
  log "Ghost: kept shell profile PATH entries (Claude pre-installed)"
fi

# ── Keychain/keyring: only if Claude wasn't pre-installed ──
if [ "${GHOST_HAS_MANIFEST}" -eq 0 ] || [ "$PRE_CLAUDE_BINARY" = "0" ]; then
  if [ "$(uname -s)" = "Linux" ] && has secret-tool; then
    secret-tool clear service claude-code 2>/dev/null && \
      printf "  ${G}✓${N} Linux keyring entry removed\n" || true
  fi
fi

# ── Always clean up: manifest, audit log, backup dirs ──
rm -f "$JAZZ_MANIFEST" 2>/dev/null
rm -f "$JAZZ_LOG" 2>/dev/null

for bdir in "$HOME/.claude/.backup-"*; do
  if [ -d "$bdir" ]; then
    rm -rf "$bdir" 2>/dev/null
  fi
done

# Signal trap no longer needed — ghost mode completed normally
JAZZ_GHOST_NEEDED=0

# Clear terminal history for this session
history -c 2>/dev/null || true

sleep 0.3
echo
printf "  ${D}jazz was never here.${N}\n"
echo
printf "${D}  ──────────────────────────────────${N}\n"
echo
