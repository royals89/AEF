# Command: deploy

**Command ID:** `deploy`

## Purpose

Moves a verified change into a running environment via the
[DevOps Engineer](../../agents/teams/platform/DEVOPS_ENGINEER.md)'s
deployment automation, into infrastructure the
[Cloud Engineer](../../agents/teams/platform/CLOUD_ENGINEER.md) has
provisioned.

## Inputs

- Verified code change (having cleared `review`, `test`, and `secure`
  where applicable)
- Deployment target configuration, per the active `config/` profile

## Outputs

- Deployment result (success/failure), per
  [DevOps Engineer: Primary Outputs](../../agents/teams/platform/DEVOPS_ENGINEER.md#primary-outputs)

## Preconditions

- All mandatory Quality Gates for the active `config/` profile have
  passed (per
  [DevOps Engineer: Quality Gates](../../agents/teams/platform/DEVOPS_ENGINEER.md#quality-gates)) —
  `deploy` does not proceed on an unverified change.
- Target infrastructure is provisioned (via Cloud Engineer, prior step or
  already existing).

## Workflow

Invokes [DevOps Engineer](../../agents/teams/platform/DEVOPS_ENGINEER.md)
as a Sequential-handoff step, deploying into infrastructure the
[Cloud Engineer](../../agents/teams/platform/CLOUD_ENGINEER.md) has
provisioned, per
[Platform Team: Internal Collaboration](../../agents/teams/platform/README.md#internal-collaboration).

## Success Criteria

- Deployment completes with a defined rollback path available, per
  [DevOps Engineer: Quality Gates](../../agents/teams/platform/DEVOPS_ENGINEER.md#quality-gates).

## Failure Handling

- **Mandatory Quality Gate not cleared**: `deploy` halts before invoking
  DevOps Engineer at all — this is treated as a process failure upstream,
  not something to route around.
- **Production deployment requiring approval** (per active `config/`
  profile, e.g., `enterprise`, `trading`): escalates to the Governance
  Layer before proceeding, per
  [DevOps Engineer: Escalation](../../agents/teams/platform/DEVOPS_ENGINEER.md#escalation).
- **Deployment fails mid-execution**: rollback path is invoked per the
  pre-defined plan; failure and rollback outcome are both recorded via
  Memory Manager.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [DevOps Engineer](../../agents/teams/platform/DEVOPS_ENGINEER.md)
- [Cloud Engineer](../../agents/teams/platform/CLOUD_ENGINEER.md)
- [secure](SECURE.md)
- [release](RELEASE.md)
