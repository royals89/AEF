#!/usr/bin/env bash
# Hook: before-commit
# Trigger point: immediately before a change is committed
# Can halt: YES - exit non-zero to block the commit
# Inputs available (env): AEF_COMMIT_MESSAGE, AEF_BRANCH_NAME
# Spec: docs/specifications/automation/hooks/HOOK_FRAMEWORK.md#before-commit
# Standard: docs/standards/GIT_BRANCHING_STANDARDS.md
#
# Default behavior: enforce Conventional Commits format.

set -euo pipefail

MESSAGE="${AEF_COMMIT_MESSAGE:-}"
PATTERN='^(feat|fix|docs|chore|refactor|test|build|ci)(\([a-z0-9-]+\))?: .+'

if [ -z "$MESSAGE" ]; then
  echo "[before-commit] no commit message supplied" >&2
  exit 1
fi

if ! echo "$MESSAGE" | grep -qE "$PATTERN"; then
  echo "[before-commit] commit message does not follow Conventional Commits (type(scope): summary)" >&2
  echo "[before-commit] got: $MESSAGE" >&2
  exit 1
fi

echo "[before-commit] ok: message follows convention"
exit 0
