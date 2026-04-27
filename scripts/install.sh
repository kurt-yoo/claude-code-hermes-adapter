#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE=""
PROJECT_DIR=""
FORCE=0

usage() {
  cat <<'USAGE'
Usage:
  install.sh --global [--force]
  install.sh --project /path/to/project [--force]

Options:
  --global              Install into ~/.claude
  --project PATH        Install into PATH/.claude
  --force               Overwrite existing files
  -h, --help            Show help
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global)
      MODE="global"
      shift
      ;;
    --project)
      MODE="project"
      PROJECT_DIR="${2:-}"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

copy_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && "$FORCE" != "1" ]]; then
    echo "skip existing: $dst"
    return 0
  fi
  cp "$src" "$dst"
  echo "installed: $dst"
}

install_common() {
  local dest="$1"
  mkdir -p "$dest/skills" "$dest/agents"
  for f in "$ROOT_DIR"/skills/*.md; do
    copy_file "$f" "$dest/skills/$(basename "$f")"
  done
  for f in "$ROOT_DIR"/agents/*.md; do
    copy_file "$f" "$dest/agents/$(basename "$f")"
  done
}

if [[ "$MODE" == "global" ]]; then
  DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
  mkdir -p "$DEST"
  copy_file "$ROOT_DIR/templates/CLAUDE.md" "$DEST/CLAUDE.md"
  install_common "$DEST"
  echo "Done. Start Claude Code with: claude"
elif [[ "$MODE" == "project" ]]; then
  if [[ -z "$PROJECT_DIR" ]]; then
    echo "--project requires a path" >&2
    exit 1
  fi
  mkdir -p "$PROJECT_DIR"
  DEST="$PROJECT_DIR/.claude"
  mkdir -p "$DEST/rules"
  copy_file "$ROOT_DIR/templates/project-rules/hermes-operating-rules.md" "$DEST/rules/hermes-operating-rules.md"
  install_common "$DEST"
  echo "Done. Start Claude Code in project: cd $PROJECT_DIR && claude"
else
  usage
  exit 1
fi
