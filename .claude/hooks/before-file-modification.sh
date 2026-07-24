#!/usr/bin/env bash
# Hook: before-file-modification
# Trigger point: immediately before any agent writes to a file
# Can halt: YES - exit non-zero to block the write
# Inputs available (env): AEF_TARGET_FILE, AEF_CHANGE_TYPE (create/modify/delete)
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#before-file-modification
#
# Default behavior: refuse writes to files matching a protected-paths list.

set -euo pipefail

TARGET_FILE="${AEF_TARGET_FILE:-}"
PROTECTED_PATTERNS=(".git/" ".env" "secrets/" "*.pem" "*.key")

if [ -z "$TARGET_FILE" ]; then
  echo "[before-file-modification] no target file specified" >&2
  exit 1
fi

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  case "$TARGET_FILE" in
    *"$pattern"*)
      echo "[before-file-modification] refusing to modify protected path: $TARGET_FILE" >&2
      exit 1
      ;;
  esac
done

echo "[before-file-modification] ok: ${AEF_CHANGE_TYPE:-modify} $TARGET_FILE"
exit 0
