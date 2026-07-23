# Workflow: New Feature

## Definition

| Field | Value |
|---|---|
| **Name** | `new-feature` |
| **Description** | Takes a feature requirement from interpretation through design, implementation, verification, and documentation. |
| **Trigger** | `plan` command with a feature requirement (see [plan](../commands/PLAN.md)) |
| **Inputs** | The raw feature request; current `project_profile` |

## Steps

1. **Interpret requirement** — Business Analyst structures the request
   into testable requirements (see
   [Business Analyst](../../agents/teams/project/BUSINESS_ANALYST.md)).
2. **Design** — Solution Architect produces a design; Enterprise Architect
   reviews it (Review handoff, per
   [Architecture Team: Internal Collaboration](../../agents/teams/architecture/README.md#internal-collaboration)).
3. **Implement** — the Planning Engine binds design output to the
   appropriate Engineering agent(s) (Backend, Frontend, Full Stack, API,
   Database, per feature shape); executed via `implement` (see
   [implement](../commands/IMPLEMENT.md)).
4. **Review** — Code Reviewer evaluates the implementation (see
   [review](../commands/REVIEW.md)).
5. **Verify** — QA Engineer (and Performance Engineer, where the active
   `config/` profile requires it) tests the implementation (see
   [test](../commands/TEST.md)).
6. **Document** — Technical Writer (and API Documentation Engineer, where
   applicable) documents the completed feature (see
   [document](../commands/DOCUMENT.md)).

## Quality Gates

- [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md) baseline at
  every agent-produced step.
- Step 4's verdict (approve) is a precondition for step 5 to begin.
- Step 5's clean test report is a precondition for step 6 (documenting an
  unverified feature is out of order).

## Governance

- Mandatory approval checkpoint before step 3 begins, when the active
  `config/` profile requires design sign-off (e.g., `enterprise`,
  `trading`) — mirrors
  [Solution Architect: Collaborates With](../../agents/teams/architecture/SOLUTION_ARCHITECT.md#collaborates-with).
- No mandatory checkpoint after step 6 by default; `release` (a separate
  workflow) owns release-level governance.

## Failure Behavior

- Step 1 ambiguity: escalates to the original requester, per
  [Business Analyst: Escalation](../../agents/teams/project/BUSINESS_ANALYST.md#escalation) —
  workflow pauses rather than proceeding on a guess.
- Step 4 request-changes verdict: loops back to step 3 (not a workflow
  failure — a normal iteration), per
  [review command: Failure Handling](../commands/REVIEW.md#failure-handling).
- Step 5 defect found: loops back to step 3, per
  [test command: Failure Handling](../commands/TEST.md#failure-handling).

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [plan](../commands/PLAN.md), [implement](../commands/IMPLEMENT.md),
  [review](../commands/REVIEW.md), [test](../commands/TEST.md),
  [document](../commands/DOCUMENT.md)
