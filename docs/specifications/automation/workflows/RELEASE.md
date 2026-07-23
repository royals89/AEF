# Workflow: Release

## Definition

| Field | Value |
|---|---|
| **Name** | `release` |
| **Description** | Finalizes a version, tags it, and coordinates the release-scoped subset of deployment, documentation, and governance sign-off. |
| **Trigger** | `release` command (see [release](../commands/RELEASE.md)) |
| **Inputs** | The set of changes since the last release (via Memory Manager workflow history); target version bump classification |

## Steps

1. **Confirm readiness** — verify every change in scope has cleared
   `review`, `test`, and `secure` (where applicable) — this step queries
   Memory Manager workflow history rather than re-running those commands.
2. **Classify version** — determine MAJOR/MINOR/PATCH per
   [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md#design-decisions),
   based on the actual scope of changes since the last release.
3. **Document** — Technical Writer updates the changelog/version metadata
   (see [document](../commands/DOCUMENT.md)).
4. **Deploy** (where the active `config/` profile requires deployment
   before release is final) — DevOps Engineer executes `deploy`.
5. **Tag and finalize** — DevOps Engineer tags the release per
   [Git & Branching Standards](../../../standards/GIT_BRANCHING_STANDARDS.md#design-decisions).

## Quality Gates

- Step 1 is itself a gate: any change in scope that hasn't cleared prior
  Quality Gates blocks the release entirely, not just that one change.
- Step 2's classification must match actual scope — a breaking change
  classified as PATCH fails this workflow's Quality Gate regardless of who
  or what proposed the classification.

## Governance

- Mandatory Governance Layer approval before step 5, whenever the active
  `config/` profile requires it (e.g., `enterprise`, `trading`) — per
  [release command: Failure Handling](../commands/RELEASE.md#failure-handling).
- `escalation.raised` events from any change in scope (per the
  [Event Catalog](../events/EVENT_CATALOG.md#state-change-events-not-hook-derived))
  block step 1 from confirming readiness until resolved.

## Failure Behavior

- Step 1 finds an unverified change in scope: workflow halts; the change
  is either removed from release scope or routed back through `review`/
  `test`/`secure`.
- Step 2 classification is disputed: escalates to a human, per
  [release command: Failure Handling](../commands/RELEASE.md#failure-handling) —
  not resolved unilaterally by any single agent.
- Step 4 deployment fails: release does not proceed to step 5; rollback is
  handled per [deploy command: Failure Handling](../commands/DEPLOY.md#failure-handling).

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [release command](../commands/RELEASE.md)
- [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md)
