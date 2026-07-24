#!/usr/bin/env bash
# Hook: before-analysis
# Trigger point: immediately before /analyze begins scanning the repository
# Can halt: YES - exit non-zero to block analysis from starting
# Inputs available (env): AEF_TARGET_PATH, AEF_RESOLVED_CONFIG
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#before-analysis
#
# Default behavior: no-op pass-through. Add project-specific gating below
# (e.g., refuse to analyze if required config is missing).

set -euo pipefail

TARGET_PATH="${AEF_TARGET_PATH:-.}"

if [ ! -d "$TARGET_PATH" ]; then
  echo "[before-analysis] target path does not exist: $TARGET_PATH" >&2
  exit 1
fi

echo "[before-analysis] ok: analysis may proceed for $TARGET_PATH"
exit 0
