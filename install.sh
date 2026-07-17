#!/usr/bin/env sh
set -eu

RAW_BASE="https://raw.githubusercontent.com/Zlz0612/aquabox-codex-pet/main"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_HOME/pets/aquabox"
TEMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT INT TERM

command -v curl >/dev/null 2>&1 || {
  printf '%s\n' 'curl is required to install this pet.' >&2
  exit 1
}

curl -fsSL --retry 2 "$RAW_BASE/pet.json" -o "$TEMP_DIR/pet.json"
curl -fsSL --retry 2 "$RAW_BASE/spritesheet.webp" -o "$TEMP_DIR/spritesheet.webp"

grep -q '"id"[[:space:]]*:[[:space:]]*"aquabox"' "$TEMP_DIR/pet.json" || {
  printf '%s\n' 'Downloaded pet.json is not Huashi Weilai.' >&2
  exit 1
}
grep -q '"spriteVersionNumber"[[:space:]]*:[[:space:]]*2' "$TEMP_DIR/pet.json" || {
  printf '%s\n' 'Downloaded pet.json is not sprite version 2.' >&2
  exit 1
}

[ -s "$TEMP_DIR/spritesheet.webp" ] || {
  printf '%s\n' 'Downloaded spritesheet.webp is empty.' >&2
  exit 1
}

mkdir -p "$TARGET_DIR"
cp "$TEMP_DIR/pet.json" "$TARGET_DIR/pet.json"
cp "$TEMP_DIR/spritesheet.webp" "$TARGET_DIR/spritesheet.webp"

printf 'Installed 华世未来 to %s\n' "$TARGET_DIR"
printf '%s\n' 'Fully quit and reopen Codex, then use Settings > Pets > Refresh.'
