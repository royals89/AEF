# Command: update

**Command ID:** `update`

## Purpose

Updates AEF's own framework version, `plugins/`, and `domain-packs/`
entries within a target repository to newer compatible versions, per
[Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md), and can
apply the structural fixes a prior `doctor` run identified.

## Inputs

- `target_path` — repository root to update
- `scope` — what to update: framework core, specific plugin(s)/pack(s), or
  structural repair from a prior `doctor` report
- Target version(s), or "latest compatible" per
  [Versioning Strategy: Independent versioning for Domain Packs](../../../standards/VERSIONING_STRATEGY.md#design-decisions)

## Outputs

- Update result: what was updated, from which version to which, and any
  entries skipped due to incompatibility

## Preconditions

- A `doctor` run (implicit or explicit) confirms current state is
  understood before `update` proceeds — `update` does not blindly apply
  changes to an undiagnosed repository.

## Workflow

`update` does not invoke the Workflow Engine or agents for framework/
plugin version changes — it operates directly against `config/`,
`plugins/`, `domain-packs/`, and the Core Framework's own version
metadata. For structural repair specifically, it applies the same
scaffolding logic the [Bootstrap Engine](../../engines/BOOTSTRAP_ENGINE.md)
uses (per
[Bootstrap Engine: never overwrite, only fill gaps](../../engines/BOOTSTRAP_ENGINE.md#responsibilities)),
without re-running full bootstrap.

## Success Criteria

- Every updated component's `compatible_core_version` is verified against
  the resulting core version before the update is applied, not after.
- Structural repairs only add missing expected paths — `update` never
  deletes or overwrites existing content, mirroring
  [Bootstrap Engine: Error Handling](../../engines/BOOTSTRAP_ENGINE.md#error-handling).

## Failure Handling

- **Target version incompatible with current core**: update for that
  component is skipped and reported, not forced.
- **Update would require a MAJOR version bump with breaking changes**: per
  [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md#design-decisions),
  `update` halts and requires explicit confirmation rather than applying a
  breaking change silently.
- **Structural repair conflict** (unexpected content at a path `doctor`
  flagged): handled exactly as
  [Bootstrap Engine: Error Handling](../../engines/BOOTSTRAP_ENGINE.md#error-handling)
  — reported, not overwritten.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Versioning Strategy](../../../standards/VERSIONING_STRATEGY.md)
- [doctor](DOCTOR.md)
- [Bootstrap Engine Specification](../../engines/BOOTSTRAP_ENGINE.md)
