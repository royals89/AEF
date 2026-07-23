# Command: release

**Command ID:** `release`

## Purpose

Finalizes a version per [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md),
tags the release, and coordinates the release-facing subset of
deployment, documentation, and governance sign-off.

## Inputs

- The set of changes since the last release (via Memory Manager workflow
  history)
- Target version bump classification (MAJOR/MINOR/PATCH), per
  [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md)

## Outputs

- A tagged release, per
  [Git & Branching Standards: Sprint boundaries are tagged](../../../standards/GIT_BRANCHING_STANDARDS.md#design-decisions)
  (the same tagging convention used for sprint completions applies to
  releases)
- Updated changelog/version metadata

## Preconditions

- All changes in scope for the release have cleared `review`, `test`,
  `secure`, and (where applicable) `document`.
- `deploy` has succeeded for the target environment, where the active
  `config/` profile requires deployment before release is considered
  final.

## Workflow

Coordinates [DevOps Engineer](../../agents/teams/platform/DEVOPS_ENGINEER.md)
(release automation) and, where the active `config/` profile requires it,
a Governance Layer approval checkpoint — `release` is the command most
directly tied to
[Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md), which it
applies to classify the version bump.

## Success Criteria

- Version bump classification matches the actual scope of change (a
  breaking change is never released as a PATCH), per
  [Versioning Strategy: Design Decisions](../../../standards/VERSIONING_STRATEGY.md#design-decisions).
- Release is tagged and traceable to the exact commit/workflow history via
  Memory Manager.

## Failure Handling

- **Mandatory approval not obtained** (per active `config/` profile):
  `release` halts at `halted-for-approval` and does not tag or publish.
- **Version classification disputed** (e.g., an agent and a human
  disagree on MAJOR vs. MINOR): escalated to a human for final
  determination — `release` does not resolve this unilaterally.
- **Post-release defect discovered**: out of `release`'s own scope;
  routed to a new Bug Fix workflow (see
  [Workflow Library: Bug Fix](../workflows/BUG_FIX.md)).

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md)
- [deploy](DEPLOY.md)
- [Workflow Library: Release](../workflows/RELEASE.md)
