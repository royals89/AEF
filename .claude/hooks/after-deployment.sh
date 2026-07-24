#!/usr/bin/env bash
# Hook: after-deployment
# Trigger point: immediately after a deployment completes (success or failure)
# Can halt: NO - observation only
# Inputs available (env): AEF_DEPLOY_TARGET, AEF_DEPLOY_RESULT, AEF_ROLLBACK_REF
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#after-deployment
# Rules: docs/specifications/automation/AUTOMATION_RULES.md
#   (schedule-post-deploy-verification)
#
# Default behavior: log result; schedule follow-up /secure and/or /test
# when the active profile requires post-deploy verification.

set -uo pipefail

echo "[after-deployment] target=${AEF_DEPLOY_TARGET:-unknown} result=${AEF_DEPLOY_RESULT:-unknown}"

if [ "${AEF_DEPLOY_RESULT:-}" = "failed" ] && [ -n "${AEF_ROLLBACK_REF:-}" ]; then
  echo "[after-deployment] rollback available: $AEF_ROLLBACK_REF"
fi

exit 0
