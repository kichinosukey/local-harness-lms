#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cd "$ROOT_DIR"

INSTALL_DIR="$tmp_dir/bin" ./install.sh

installed="$tmp_dir/bin/lh-lms"
[[ -x "$installed" ]]
cmp -s "$ROOT_DIR/lh-lms" "$installed"
"$installed" list harnesses | grep -F "claude" >/dev/null

printf 'ok - install.sh installs lh-lms into INSTALL_DIR\n'
