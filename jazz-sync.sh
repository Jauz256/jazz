#!/bin/bash
# JAZZ SYNC — package your Claude Code setup and push to GitHub
#
# Run this on YOUR machine after making changes to skills, commands,
# memory, or config. It copies from ~/.claude/ into the repo, rebuilds
# the tar.gz, and pushes to GitHub.
#
# No set -e or set -u — macOS bash 3.2 chokes on empty arrays with set -u

# ── Colors (JAZZ theme) ──
C='\033[0;36m'
G='\033[0;32m'
R='\033[0;31m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${SCRIPT_DIR}/config"
CLAUDE_DIR="$HOME/.claude"

# ── Fail with message ──
die() {
  printf "\n  ${R}✗${N} %s\n\n" "$1"
  exit 1
}

# ── Header ──
echo
printf "${C}  JAZZ SYNC${N} ${D}— package & push your Claude setup${N}\n"
printf "${D}  ──────────────────────────────────────${N}\n"
echo
sleep 0.2

# ── Verify source exists ──
if [ ! -d "$CLAUDE_DIR" ]; then
  die "No ~/.claude/ directory found. Nothing to sync."
fi

# ── Ensure config directory ──
mkdir -p "$CONFIG_DIR"

# ── Track counts ──
SKILL_COUNT=0
CMD_COUNT=0
SYNCED_FILES=0

# ═══════════════════════════════════════
#  1. Copy latest files from ~/.claude/
# ═══════════════════════════════════════

printf "  ${D}▸${N} ${W}Syncing from ~/.claude/${N}\n"
echo
sleep 0.2

# ── CLAUDE.md ──
if [ -f "${CLAUDE_DIR}/CLAUDE.md" ]; then
  cp "${CLAUDE_DIR}/CLAUDE.md" "${CONFIG_DIR}/CLAUDE.md"
  printf "  ${G}✓${N} CLAUDE.md\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} CLAUDE.md ${D}(not found, skipping)${N}\n"
fi

# ── Skills directory ──
if [ -d "${CLAUDE_DIR}/skills" ]; then
  rm -rf "${CONFIG_DIR}/skills"
  cp -R "${CLAUDE_DIR}/skills" "${CONFIG_DIR}/skills"
  SKILL_COUNT=$(ls "${CONFIG_DIR}/skills" 2>/dev/null | wc -l | tr -d ' ')
  printf "  ${G}✓${N} ${W}${SKILL_COUNT}${N} skills synced ${D}(the full arsenal)${N}\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} skills/ ${D}(not found, skipping)${N}\n"
fi

# ── Commands directory ──
if [ -d "${CLAUDE_DIR}/commands" ]; then
  rm -rf "${CONFIG_DIR}/commands"
  cp -R "${CLAUDE_DIR}/commands" "${CONFIG_DIR}/commands"
  CMD_COUNT=$(ls "${CONFIG_DIR}/commands" 2>/dev/null | wc -l | tr -d ' ')
  printf "  ${G}✓${N} ${W}${CMD_COUNT}${N} command sets synced ${D}(GSD + Ralph Loop)${N}\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} commands/ ${D}(not found, skipping)${N}\n"
fi

# ── settings.json ──
if [ -f "${CLAUDE_DIR}/settings.json" ]; then
  cp "${CLAUDE_DIR}/settings.json" "${CONFIG_DIR}/settings.json"
  printf "  ${G}✓${N} settings.json\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} settings.json ${D}(not found, skipping)${N}\n"
fi

# ── keybindings.json ──
if [ -f "${CLAUDE_DIR}/keybindings.json" ]; then
  cp "${CLAUDE_DIR}/keybindings.json" "${CONFIG_DIR}/keybindings.json"
  printf "  ${G}✓${N} keybindings.json\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} keybindings.json ${D}(not found, skipping)${N}\n"
fi

# ── Memory directory ──
# Check project-specific memory first, then global memory
MEMORY_SRC=""
if [ -d "${CLAUDE_DIR}/projects/-Users-aungkyawmin/memory" ]; then
  MEMORY_ENTRY_COUNT=$(ls "${CLAUDE_DIR}/projects/-Users-aungkyawmin/memory" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$MEMORY_ENTRY_COUNT" -gt 0 ]; then
    MEMORY_SRC="${CLAUDE_DIR}/projects/-Users-aungkyawmin/memory"
  fi
fi
if [ -z "$MEMORY_SRC" ] && [ -d "${CLAUDE_DIR}/memory" ]; then
  MEMORY_ENTRY_COUNT=$(ls "${CLAUDE_DIR}/memory" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$MEMORY_ENTRY_COUNT" -gt 0 ]; then
    MEMORY_SRC="${CLAUDE_DIR}/memory"
  fi
fi

if [ -n "$MEMORY_SRC" ]; then
  rm -rf "${CONFIG_DIR}/memory"
  cp -R "$MEMORY_SRC" "${CONFIG_DIR}/memory"
  MEM_COUNT=$(ls "${CONFIG_DIR}/memory" 2>/dev/null | wc -l | tr -d ' ')
  printf "  ${G}✓${N} ${W}${MEM_COUNT}${N} memory files synced ${D}(jazz never forgets)${N}\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} memory/ ${D}(empty or not found, skipping)${N}\n"
fi

# ── Agents directory (GSD agent definitions) ──
if [ -d "${CLAUDE_DIR}/agents" ]; then
  rm -rf "${CONFIG_DIR}/agents"
  cp -R "${CLAUDE_DIR}/agents" "${CONFIG_DIR}/agents"
  AGENT_COUNT=$(ls "${CONFIG_DIR}/agents" 2>/dev/null | wc -l | tr -d ' ')
  printf "  ${G}✓${N} ${W}${AGENT_COUNT}${N} agent definitions synced\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} agents/ ${D}(not found, skipping)${N}\n"
fi

# ── Get-Shit-Done core toolkit ──
if [ -d "${CLAUDE_DIR}/get-shit-done" ]; then
  rm -rf "${CONFIG_DIR}/get-shit-done"
  cp -R "${CLAUDE_DIR}/get-shit-done" "${CONFIG_DIR}/get-shit-done"
  printf "  ${G}✓${N} get-shit-done/ synced ${D}(the engine)${N}\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} get-shit-done/ ${D}(not found, skipping)${N}\n"
fi

# ── GSD file manifest ──
if [ -f "${CLAUDE_DIR}/gsd-file-manifest.json" ]; then
  cp "${CLAUDE_DIR}/gsd-file-manifest.json" "${CONFIG_DIR}/gsd-file-manifest.json"
  printf "  ${G}✓${N} gsd-file-manifest.json\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} gsd-file-manifest.json ${D}(not found, skipping)${N}\n"
fi

# ── Hooks directory ──
if [ -d "${CLAUDE_DIR}/hooks" ]; then
  rm -rf "${CONFIG_DIR}/hooks"
  cp -R "${CLAUDE_DIR}/hooks" "${CONFIG_DIR}/hooks"
  printf "  ${G}✓${N} hooks/ synced\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} hooks/ ${D}(not found, skipping)${N}\n"
fi

# ── Plugins directory ──
if [ -d "${CLAUDE_DIR}/plugins" ]; then
  rm -rf "${CONFIG_DIR}/plugins"
  cp -R "${CLAUDE_DIR}/plugins" "${CONFIG_DIR}/plugins"
  printf "  ${G}✓${N} plugins/ synced\n"
  SYNCED_FILES=$(expr $SYNCED_FILES + 1)
else
  printf "  ${D}○${N} plugins/ ${D}(not found, skipping)${N}\n"
fi

echo
sleep 0.2

# ── Bail if nothing was synced ──
if [ "$SYNCED_FILES" -eq 0 ]; then
  die "Nothing to sync. Your ~/.claude/ is empty."
fi

# ═══════════════════════════════════════
#  2. Re-create the tar.gz archive
# ═══════════════════════════════════════

printf "  ${D}▸${N} ${W}Rebuilding archive${N}\n"
echo
sleep 0.2

# Build the list of items to include (everything in config/ EXCEPT vault)
TAR_ITEMS=""
for item in "${CONFIG_DIR}"/*; do
  basename_item=$(basename "$item")
  if [ "$basename_item" = "vault" ]; then
    continue
  fi
  if [ "$basename_item" = "claude-kit.tar.gz" ]; then
    continue
  fi
  TAR_ITEMS="$TAR_ITEMS $basename_item"
done

# Create tar.gz from within config dir
(cd "$CONFIG_DIR" && tar -czf claude-kit.tar.gz $TAR_ITEMS 2>/dev/null)

if [ $? -eq 0 ] && [ -s "${CONFIG_DIR}/claude-kit.tar.gz" ]; then
  ARCHIVE_SIZE=$(ls -lh "${CONFIG_DIR}/claude-kit.tar.gz" | awk '{print $5}')
  printf "  ${G}✓${N} claude-kit.tar.gz ${D}(${ARCHIVE_SIZE})${N}\n"
else
  die "Failed to create archive."
fi

echo
sleep 0.2

# ═══════════════════════════════════════
#  3. Git add, commit, push
# ═══════════════════════════════════════

printf "  ${D}▸${N} ${W}Pushing to GitHub${N}\n"
echo
sleep 0.2

cd "$SCRIPT_DIR"

# Stage everything
git add -A 2>/dev/null
if [ $? -ne 0 ]; then
  die "git add failed. Are you in a git repo?"
fi

# Check if there are changes to commit
CHANGES=$(git status --porcelain 2>/dev/null)
if [ -z "$CHANGES" ]; then
  printf "  ${D}○${N} No changes to commit ${D}(already up to date)${N}\n"
  echo
  printf "${D}  ──────────────────────────────────────${N}\n"
  echo
  printf "  ${G}█${N} ${W}Already in sync. Nothing to push.${N}\n"
  echo
  exit 0
fi

# Commit
git commit -m "jazz sync" 2>/dev/null
if [ $? -ne 0 ]; then
  die "git commit failed."
fi
printf "  ${G}✓${N} Committed ${D}(jazz sync)${N}\n"

# Push
git push 2>/dev/null
if [ $? -eq 0 ]; then
  printf "  ${G}✓${N} Pushed to remote ${D}(live everywhere)${N}\n"
else
  printf "  ${R}✗${N} Push failed ${D}(check your remote / auth)${N}\n"
  echo
  exit 1
fi

# ── Summary ──
echo
printf "${D}  ──────────────────────────────────────${N}\n"
echo
printf "  ${G}█${N} ${W}Synced.${N} ${D}${SKILL_COUNT} skills, ${CMD_COUNT} command sets packaged.${N}\n"
printf "  ${D}  Any machine running setup.sh gets this instantly.${N}\n"
echo
printf "${D}  ──────────────────────────────────────${N}\n"
echo
