#!/usr/bin/env bash
# Hook: before-deployment
# Trigger point: immediately before deployment automation executes
# Can halt: YES - exit non-zero to block the deployment
# Inputs available (env): AEF_DEPLOY_TARGET, AEF_CONFIG_PROFILE, AEF_GATES_PASSED
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#before-deployment
# Rules: docs/specifications/automation/AUTOMATION_RULES.md
#   (gate-deployment-on-quality, gate-deployment-on-approval)
#
# Default behavior: refuse to deploy unless AEF_GATES_PASSED=true, and
# require explicit approval for enterprise/trading profiles.

set -euo pipefail

if [ "${AEF_GATES_PASSED:-false}" != "true" ]; then
  echo "[before-deployment] mandatory quality gates have not passed - refusing to deploy" >&2
  exit 1
fi

PROFILE="${AEF_CONFIG_PROFILE:-startup}"
if [ "$PROFILE" = "enterprise" ] || [ "$PROFILE" = "trading" ]; then
  if [ "${AEF_APPROVAL_GRANTED:-false}" != "true" ]; then
    echo "[before-deployment] profile '$PROFILE' requires governance approval before deploy" >&2
    exit 1
  fi
fi

echo "[before-deployment] ok: deploying to ${AEF_DEPLOY_TARGET:-unknown}"
exit 0
