#!/usr/bin/env bash
# Hook: after-planning
# Trigger point: immediately after an execution_plan (or diagnostics) is produced
# Can halt: NO - observation only
# Inputs available (env): AEF_EXECUTION_PLAN_REF, AEF_PLANNING_DIAGNOSTICS
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#after-planning

set -uo pipefail

if [ -n "${AEF_PLANNING_DIAGNOSTICS:-}" ]; then
  echo "[after-planning] planning could not produce a full plan: $AEF_PLANNING_DIAGNOSTICS"
else
  echo "[after-planning] plan produced: ${AEF_EXECUTION_PLAN_REF:-unknown}"
fi
exit 0
