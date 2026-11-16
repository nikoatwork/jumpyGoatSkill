#!/bin/sh
# Install or update the skills in this repository.
#
#   curl -fsSL https://raw.githubusercontent.com/nikoatwork/jumpyGoatSkill/master/install.sh | sh -s -- --global
#   curl -fsSL https://raw.githubusercontent.com/nikoatwork/jumpyGoatSkill/master/install.sh | sh -s -- --project .
#
# Each skill is copied to <root>/.agents/skills/<name> (Codex, Pi) and linked
# from <root>/.claude/skills/<name> (Claude Code). Re-run to update; existing
# copies of these skills are replaced. Other skills are left alone.
set -eu

REPO_URL="${JUMPY_SKILLS_REPO:-https://github.com/nikoatwork/jumpyGoatSkill.git}"
REF=master
SOURCE=""
ROOT=""

usage() {
  echo "usage: install.sh (--global | --project DIR) [--ref BRANCH_OR_TAG] [--source LOCAL_CLONE]" >&2
  exit 2
}

while [ $# -gt 0 ]; do
  case "$1" in
    --global) ROOT="$HOME" ;;
    --project) [ $# -ge 2 ] || usage; ROOT="$2"; shift ;;
    --ref) [ $# -ge 2 ] || usage; REF="$2"; shift ;;
    --source) [ $# -ge 2 ] || usage; SOURCE="$2"; shift ;;
    *) usage ;;
  esac
  shift
done

[ -n "$ROOT" ] || usage
[ -d "$ROOT" ] || { echo "install.sh: no such directory: $ROOT" >&2; exit 1; }
ROOT=$(cd "$ROOT" && pwd)

if [ -z "$SOURCE" ]; then
  TMP=$(mktemp -d)
  trap 'rm -rf "$TMP"' EXIT
  git clone --quiet --depth 1 --branch "$REF" "$REPO_URL" "$TMP/src"
  SOURCE="$TMP/src"
fi
[ -d "$SOURCE/skills" ] || { echo "install.sh: no skills/ folder in $SOURCE" >&2; exit 1; }
REV=$(git -C "$SOURCE" rev-parse --short HEAD 2>/dev/null || echo unknown)

mkdir -p "$ROOT/.agents/skills" "$ROOT/.claude/skills"
for dir in "$SOURCE"/skills/*/; do
  name=$(basename "$dir")
  dest="$ROOT/.agents/skills/$name"
  link="$ROOT/.claude/skills/$name"
  rm -rf "$dest" "$link"
  cp -R "${dir%/}" "$dest"
  echo "nikoatwork/jumpyGoatSkill@$REV" > "$dest/.installed-from"
  ln -s "../../.agents/skills/$name" "$link"
  echo "installed $name @ $REV -> $dest"
done
