# Command: analyze

**Command ID:** `analyze`

## Purpose

Runs (or re-runs) the Discovery Engine against the target repository to
produce or refresh the project profile — stack, conventions, dependency
graph, relevant plugins, and deployment context.

## Inputs

- `target_path` — repository root to analyze
- `scope` (optional) — narrows analysis to a subpath or specific concern
  (e.g., dependency graph only), per
  [Discovery Engine future extension points](../../engines/DISCOVERY_ENGINE.md#future-enhancements)

## Outputs

- `project_profile` — per
  [Discovery Engine Specification](../../engines/DISCOVERY_ENGINE.md#outputs)
- `discovery_diff` — what changed since the prior profile, if one existed

## Preconditions

- Repository has been bootstrapped (`bootstrap` has run at least once), so
  a `config/` profile exists for Discovery to read.

## Workflow

Directly invokes the [Discovery Engine](../../engines/DISCOVERY_ENGINE.md)
via the Engineering Orchestrator. Frequently the first step of any
[Workflow Library](../workflows/WORKFLOW_LIBRARY.md) entry, but is also
independently invocable for a standalone refresh.

## Success Criteria

- `project_profile` is written to Memory Manager with an incremented
  version.
- If a prior profile existed, `discovery_diff` accurately reflects the
  changes (verified against
  [Discovery Engine error handling](../../engines/DISCOVERY_ENGINE.md#error-handling)
  for corrupt/missing prior profiles).

## Failure Handling

- **Not bootstrapped**: command halts, reports the missing precondition,
  and suggests running `bootstrap` first.
- **Partial plugin detector failure**: per
  [Discovery Engine error handling](../../engines/DISCOVERY_ENGINE.md#error-handling),
  the command still completes, with the failure recorded against the
  specific plugin in `project_profile` rather than failing the whole
  command.
- **Corrupt prior profile**: falls back to a full scan, logged as a
  warning, not a command failure.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Discovery Engine Specification](../../engines/DISCOVERY_ENGINE.md)
- [bootstrap](BOOTSTRAP.md)
- [plan](PLAN.md)
