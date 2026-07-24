#!/usr/bin/env bash
# Hook: after-commit
# Trigger point: immediately after a commit completes
# Can halt: NO - observation only
# Inputs available (env): AEF_COMMIT_HASH, AEF_BRANCH_NAME
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#after-commit
#
# Default behavior: annotate workflow history with the commit reference
# (see AUTOMATION_RULES.md: annotate-commit-with-workflow).

set -uo pipefail

echo "[after-commit] recorded commit ${AEF_COMMIT_HASH:-unknown} on ${AEF_BRANCH_NAME:-unknown}"
exit 0
