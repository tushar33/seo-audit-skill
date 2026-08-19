#!/usr/bin/env bash
# Installs the seo-audit Claude Code skill into the current project.
# Usage (from your project's repo root):
#   curl -sL https://raw.githubusercontent.com/tushar33/seo-audit-skill/main/install.sh | bash
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/tushar33/seo-audit-skill/main"
DEST="skills/seo-audit"

if [ -f "$DEST/seo-audit.md" ]; then
  echo "skills/seo-audit already exists here — remove it first if you want to reinstall." >&2
  exit 1
fi

mkdir -p "$DEST" .claude/commands

for f in seo-audit.md categories.md; do
  curl -sL "$REPO_RAW/skills/seo-audit/$f" -o "$DEST/$f"
done

ln -sf "../../$DEST/seo-audit.md" .claude/commands/seo-audit.md

echo "Installed. Run /seo-audit in Claude Code to start your first audit."
