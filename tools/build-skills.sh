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

copy_ref() {
  local stage_dir="$1"
  local rel_path="$2"

  mkdir -p "$stage_dir/$(dirname "$rel_path")"
  cp "$ROOT_DIR/$rel_path" "$stage_dir/$rel_path"
}

stage_skill() {
  local skill_dir="$1"
  local stage_dir="$2"
  local name

  name="$(basename "$skill_dir")"
  mkdir -p "$stage_dir"
  cp "$skill_dir/SKILL.md" "$stage_dir/SKILL.md"

  case "$name" in
    cgx-baseos)
      ;;
    cgx-baseos-diagnose)
      copy_ref "$stage_dir" references/business-classifier.md
      copy_ref "$stage_dir" references/high-frequency-scenarios.md
      copy_ref "$stage_dir" references/system-design-rules.md
      ;;
    cgx-baseos-build)
      copy_ref "$stage_dir" references/business-classifier.md
      copy_ref "$stage_dir" references/high-frequency-scenarios.md
      copy_ref "$stage_dir" references/build-playbook.md
      copy_ref "$stage_dir" references/system-design-rules.md
      copy_ref "$stage_dir" references/dashboard-build-rules.md
      copy_ref "$stage_dir" references/finance-scenarios.md
      copy_ref "$stage_dir" references/feishu-cli-setup.md
      copy_ref "$stage_dir" references/official-template-design-patterns.md
      copy_ref "$stage_dir" references/official-template-execution-patterns.md
      copy_ref "$stage_dir" references/official-template-reference-library.md
      copy_ref "$stage_dir" templates/sales-system/schema.md
      copy_ref "$stage_dir" templates/solo-business/schema.md
      copy_ref "$stage_dir" templates/service-business/schema.md
      copy_ref "$stage_dir" templates/finance-ops/schema.md
      ;;
    cgx-baseos-repair)
      copy_ref "$stage_dir" references/repair-playbook.md
      copy_ref "$stage_dir" references/dashboard-troubleshooting.md
      copy_ref "$stage_dir" references/dashboard-filter-slicer-case.md
      copy_ref "$stage_dir" references/field-modeling-antipatterns.md
      copy_ref "$stage_dir" references/system-design-rules.md
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
