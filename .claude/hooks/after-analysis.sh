#!/usr/bin/env bash
# Hook: after-analysis
# Trigger point: immediately after project_profile is written to memory
# Can halt: NO - observation only, failures here are logged, not blocking
# Inputs available (env): AEF_PROJECT_PROFILE_REF, AEF_DISCOVERY_DIFF
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#after-analysis
#
# Default behavior: log completion. Add notification/cache-invalidation
# logic below as needed.

set -uo pipefail  # no -e: after-hooks must never block on their own failure

echo "[after-analysis] project profile updated: ${AEF_PROJECT_PROFILE_REF:-unknown}"
if [ -n "${AEF_DISCOVERY_DIFF:-}" ]; then
  echo "[after-analysis] changes since last profile: $AEF_DISCOVERY_DIFF"
fi
exit 0
