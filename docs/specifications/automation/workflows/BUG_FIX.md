# Workflow: Bug Fix

## Definition

| Field | Value |
|---|---|
| **Name** | `bug-fix` |
| **Description** | Reproduces, root-causes, fixes, and regression-tests a reported defect. |
| **Trigger** | `plan` command with a defect report (see [plan](../commands/PLAN.md)) |
| **Inputs** | Defect report (expected vs. actual behavior); current `project_profile` |

## Steps

1. **Reproduce and root-cause** — QA Engineer reproduces the defect and
   distinguishes its category (functional/performance/security), per
   [QA Engineer: Quality Gates](../../agents/teams/quality/QA_ENGINEER.md#quality-gates);
   routes to the relevant specialist if not functional.
2. **Fix** — the relevant Engineering agent implements a fix, scoped
   narrowly to the root cause (not a broader refactor — see
   [Refactoring](REFACTORING.md) for that distinct workflow).
3. **Review** — Code Reviewer evaluates the fix (see
   [review](../commands/REVIEW.md)).
4. **Regression-verify** — QA Engineer re-runs the original reproduction
   case plus the existing test suite, to confirm both the defect is fixed
   and nothing else broke.

## Quality Gates

- [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md) baseline at
  steps 2–3.
- Step 4 explicitly requires both the original reproduction case passing
  *and* the pre-existing test suite passing — a fix that resolves the
  reported defect but breaks existing behavior does not satisfy this
  workflow's Quality Gate.

## Governance

- No mandatory checkpoint by default for a narrowly-scoped fix. The active
  `config/` profile may require approval for fixes touching
  security-sensitive code (cross-reference with
  [Security Engineer](../../agents/teams/security/SECURITY_ENGINEER.md)
  if step 1 routes there).

## Failure Behavior

- Step 1 cannot reproduce the defect: escalates to a human — proceeding
  to a fix without confirmed reproduction risks fixing the wrong thing.
- Step 1 routes to Security/Performance specialist: this workflow's
  remaining steps still apply, but step 2's implementing agent works from
  that specialist's findings instead of a QA Engineer's functional report.
- Step 4 regression failure: loops back to step 2, per
  [test command: Failure Handling](../commands/TEST.md#failure-handling).

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [QA Engineer](../../agents/teams/quality/QA_ENGINEER.md)
- [Refactoring](REFACTORING.md)
