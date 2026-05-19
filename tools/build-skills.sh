#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${1:-"$ROOT_DIR/dist/skills"}"
VERSION="$(tr -d '[:space:]' < "$ROOT_DIR/VERSION")"

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 command is required" >&2
  exit 1
fi

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR/individual"

stage_skill() {
  local skill_dir="$1"
  local stage_dir="$2"
  local name

  name="$(basename "$skill_dir")"
  cp -R "$skill_dir" "$stage_dir"

  case "$name" in
    cgx-baseos)
      ;;
    cgx-baseos-diagnose)
      ;;
    cgx-baseos-build)
      ;;
    cgx-baseos-repair)
      ;;
    *)
      echo "error: unknown public skill $name" >&2
      exit 1
      ;;
  esac
}

zip_dir() {
  local source_dir="$1"
  local archive_path="$2"

  python3 - "$source_dir" "$archive_path" <<'PY'
import os
import sys
import zipfile

source_dir, archive_path = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(archive_path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
    for root, _, files in os.walk(source_dir):
        for filename in sorted(files):
            path = os.path.join(root, filename)
            archive.write(path, os.path.relpath(path, source_dir))
PY
}

INNER_DIR="$(mktemp -d)"
trap 'rm -rf "$INNER_DIR"' EXIT

PUBLIC_SKILLS=(
  cgx-baseos
  cgx-baseos-diagnose
  cgx-baseos-build
  cgx-baseos-repair
)

for name in "${PUBLIC_SKILLS[@]}"; do
  skill_dir="$ROOT_DIR/skills/$name"
  stage_dir="$INNER_DIR/$name"
  stage_skill "$skill_dir" "$stage_dir"
  zip_dir "$stage_dir" "$OUT_DIR/individual/${name}.zip"
  echo "built individual/${name}.zip"
done

cat > "$INNER_DIR/README.md" <<EOF
# cgx-baseos ${VERSION}

安装顺序：

1. cgx-baseos.zip：主入口，必须先装。
2. cgx-baseos-diagnose.zip：业务数据诊断与 AI 数仓判断。
3. cgx-baseos-build.zip：四阶段构建、重构、模板资源、经营财务结构、看板新建和飞书 Base 落地。
4. cgx-baseos-repair.zip：已有系统维修排障。

模板、经营财务、看板新建和飞书 CLI 准备都是内部能力，不作为独立技能安装。
EOF

zip_dir "$INNER_DIR" "$OUT_DIR/cgx-baseos-${VERSION}.zip"
echo
echo "done: $OUT_DIR/cgx-baseos-${VERSION}.zip"
