# Workflow: Refactoring

## Definition

| Field | Value |
|---|---|
| **Name** | `refactoring` |
| **Description** | Applies a behavior-preserving structural change, verified against existing tests rather than new requirements. |
| **Trigger** | `plan` command with a refactor target (see [plan](../commands/PLAN.md)) |
| **Inputs** | The refactor target (component, module, or pattern to change) and its rationale; current `project_profile`'s dependency graph |

## Steps

1. **Assess impact** — Solution Architect (or Enterprise Architect, for
   cross-project patterns) evaluates the refactor's blast radius using
   Discovery's dependency graph, per
   [Solution Architect: Quality Gates](../../agents/teams/architecture/SOLUTION_ARCHITECT.md#quality-gates).
2. **Establish behavior baseline** — QA Engineer confirms existing test
   coverage of the affected area is adequate to detect a behavior change;
   if not, additional tests are authored *before* the refactor, not after.
3. **Refactor** — the relevant Engineering agent(s) apply the structural
   change.
4. **Review** — Code Reviewer evaluates the change, with particular
   attention to "no duplicated logic introduced" and "no behavior change,"
   per
   [Code Reviewer: Quality Gates](../../agents/teams/quality/CODE_REVIEWER.md#quality-gates).
5. **Verify no behavior change** — QA Engineer re-runs the baseline test
   suite established in step 2; a refactor that changes observable
   behavior is a defect for this workflow, not a feature to document as a
   side effect.

## Quality Gates

- [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md) baseline at
  steps 3–4.
- Step 2's baseline test coverage is itself a gate on step 3 beginning —
  refactoring without adequate pre-existing verification is not permitted
  to proceed.
- Step 5 must show zero behavior change against the step-2 baseline, not
  merely "no new failures."

## Governance

- Mandatory Enterprise Architect review (per step 1) for any refactor
  affecting a component the dependency graph shows is shared across
  multiple projects, regardless of `config/` profile — cross-project
  blast radius is treated as inherently governance-relevant.

## Failure Behavior

- Step 2 finds inadequate coverage: workflow pauses for test authoring
  before step 3 proceeds — this is expected sequencing, not a failure.
- Step 5 detects behavior change: loops back to step 3; per this
  workflow's Quality Gate, the change is treated as a defect regardless of
  whether the new behavior seems reasonable — a refactor's contract is "no
  behavior change," full stop.

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [Solution Architect](../../agents/teams/architecture/SOLUTION_ARCHITECT.md)
- [Bug Fix](BUG_FIX.md)
