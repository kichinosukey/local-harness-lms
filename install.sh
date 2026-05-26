#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${INSTALL_DIR:-"$HOME/.local/bin"}"
TARGET="$INSTALL_DIR/lh-lms"

mkdir -p "$INSTALL_DIR"
install -m 0755 "$ROOT_DIR/lh-lms" "$TARGET"

printf 'Installed lh-lms to %s\n' "$TARGET"
