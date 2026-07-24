#!/usr/bin/env bash
# Hook: after-file-modification
# Trigger point: immediately after a file write completes
# Can halt: NO - observation only
# Inputs available (env): AEF_TARGET_FILE, AEF_DIFF_REF
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#after-file-modification
#
# Default behavior: track cumulative modifications for staleness-triggered
# re-analysis (see AUTOMATION_RULES.md: refresh-profile-on-drift).

set -uo pipefail

echo "[after-file-modification] modified: ${AEF_TARGET_FILE:-unknown}"
exit 0
