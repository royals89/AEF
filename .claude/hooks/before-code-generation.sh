#!/usr/bin/env bash
# Hook: before-code-generation
# Trigger point: immediately before an agent begins producing a code or
#   content change for a plan step
# Can halt: YES - exit non-zero to block generation from starting
# Inputs available (env): AEF_STEP_ID, AEF_AGENT_ID
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#before-generation
#
# Default behavior: enforce branch protection if AEF_PROTECTED_BRANCH is set.

set -euo pipefail

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")"
PROTECTED_BRANCH="${AEF_PROTECTED_BRANCH:-main}"

if [ "$CURRENT_BRANCH" = "$PROTECTED_BRANCH" ]; then
  echo "[before-code-generation] refusing to generate directly on protected branch '$PROTECTED_BRANCH'" >&2
  exit 1
fi

echo "[before-code-generation] ok: agent=${AEF_AGENT_ID:-unknown} step=${AEF_STEP_ID:-unknown}"
exit 0
