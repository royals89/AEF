#!/usr/bin/env bash
# Hook: after-code-generation
# Trigger point: immediately after an agent's output is produced, before
#   Quality Gate evaluation
# Can halt: NO - observation only
# Inputs available (env): AEF_AGENT_ID, AEF_OUTPUT_REF
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#after-generation
#
# Default behavior: queue the output for /review.

set -uo pipefail

echo "[after-code-generation] output produced by ${AEF_AGENT_ID:-unknown}: ${AEF_OUTPUT_REF:-unknown}"
echo "[after-code-generation] queuing for /review"
exit 0
