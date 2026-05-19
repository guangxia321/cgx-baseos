#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_ROOT="${CODEX_HOME:-"$HOME/.codex"}/skills"
BUILD_DIR="$ROOT_DIR/dist/install-stage"

"$ROOT_DIR/tools/build-skills.sh" "$ROOT_DIR/dist/skills" >/dev/null

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

python3 - "$ROOT_DIR/dist/skills" "$BUILD_DIR" <<'PY'
import sys
import zipfile
from pathlib import Path

dist_dir, build_dir = map(Path, sys.argv[1:3])
for archive_path in sorted((dist_dir / "individual").glob("*.zip")):
    target = build_dir / archive_path.stem
    target.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(archive_path) as archive:
        archive.extractall(target)
PY

mkdir -p "$TARGET_ROOT"
for stale in cgx-baseos-finance cgx-baseos-templates cgx-baseos-feishu; do
  rm -rf "$TARGET_ROOT/$stale"
done

for skill_dir in "$BUILD_DIR"/*; do
  [ -d "$skill_dir" ] || continue
  rm -rf "$TARGET_ROOT/$(basename "$skill_dir")"
  cp -R "$skill_dir" "$TARGET_ROOT/"
  echo "installed $(basename "$skill_dir")"
done

echo
echo "installed all cgx-baseos skills to $TARGET_ROOT"
