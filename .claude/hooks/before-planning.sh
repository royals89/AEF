#!/usr/bin/env bash
# Hook: before-planning
# Trigger point: immediately before the Planning step begins binding a
#   workflow to the current project profile
# Can halt: YES - exit non-zero to block planning from starting
# Inputs available (env): AEF_PROJECT_PROFILE_REF, AEF_WORKFLOW_REQUEST
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#before-planning
#
# Default behavior: require a project profile to exist before planning.

set -euo pipefail

if [ -z "${AEF_PROJECT_PROFILE_REF:-}" ]; then
  echo "[before-planning] no project profile available - run /analyze first" >&2
  exit 1
fi

if [ -z "${AEF_WORKFLOW_REQUEST:-}" ]; then
  echo "[before-planning] no workflow request supplied" >&2
  exit 1
fi

echo "[before-planning] ok: planning may proceed for '$AEF_WORKFLOW_REQUEST'"
exit 0
