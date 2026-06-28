#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VAULT="${1:-"$HOME/Documents/obsidian"}"
CONTENT="$ROOT/content"

if [[ ! -d "$VAULT" ]]; then
  echo "Vault not found: $VAULT" >&2
  exit 1
fi

mkdir -p "$CONTENT"

rsync -a --delete \
  --exclude '.git/' \
  --exclude '.obsidian/' \
  --exclude '.DS_Store' \
  --exclude 'node_modules/' \
  --exclude '.trash/' \
  "$VAULT"/ "$CONTENT"/

cat > "$CONTENT/index.md" <<'MARKDOWN'
---
title: Notes
---

# Notes

这是这个 Obsidian vault 的网页浏览版。左侧可以按文件夹浏览，顶部可以搜索，右侧会显示关系图、目录和反链。

## Index Notes

MARKDOWN

find "$CONTENT" -type f -name '*Index.md' | sort | while IFS= read -r file; do
  rel="${file#"$CONTENT"/}"
  note="${rel%.md}"
  title="${rel##*/}"
  title="${title%.md}"
  printf -- '- [[%s|%s]]\n' "$note" "$title" >> "$CONTENT/index.md"
done

echo "Synced vault to $CONTENT"
