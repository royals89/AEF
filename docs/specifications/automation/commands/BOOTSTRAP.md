# Command: bootstrap

**Command ID:** `bootstrap`

## Purpose

Initializes AEF against a target repository for the first time: creates
the expected directory structure, seeds configuration for a selected
profile, and runs the first project discovery pass.

## Inputs

- `target_path` — repository root to bootstrap
- `profile` (optional) — named `config/` profile (e.g., `enterprise`,
  `startup`); if omitted, resolved per
  [Bootstrap Engine profile resolution](../../engines/BOOTSTRAP_ENGINE.md#extension-points)

## Outputs

- `bootstrap_result` — structured report of paths created/skipped/
  conflicted, per
  [Bootstrap Engine Specification](../../engines/BOOTSTRAP_ENGINE.md#outputs)
- `initial_project_profile` — written to Memory Manager

## Preconditions

- None required for a fresh repository. For an already-bootstrapped
  repository, `bootstrap` is idempotent (see
  [Bootstrap Engine lifecycle](../../engines/BOOTSTRAP_ENGINE.md#lifecycle))
  rather than blocked by a precondition.

## Workflow

Directly invokes the [Bootstrap Engine](../../engines/BOOTSTRAP_ENGINE.md)
via the Engineering Orchestrator. Does not use the
[Workflow Library](../workflows/WORKFLOW_LIBRARY.md) — bootstrap is a
one-time setup path, not a repeatable engineering workflow, per
[Bootstrap Engine Specification: Interfaces](../../engines/BOOTSTRAP_ENGINE.md#interfaces).

## Success Criteria

- Directory structure matches
  [Repository Structure Guide](../../../architecture/REPOSITORY_STRUCTURE.md)
  expectations for paths not already present.
- Selected profile's configuration is seeded under `config/`.
- An `initial_project_profile` exists in Memory Manager (or
  `bootstrap_result` explicitly flags that Discovery did not complete, per
  [Bootstrap Engine error handling](../../engines/BOOTSTRAP_ENGINE.md#error-handling)).

## Failure Handling

- **Conflict at an expected path** (non-AEF content already present): per
  [Bootstrap Engine error handling](../../engines/BOOTSTRAP_ENGINE.md#error-handling),
  scaffolding halts for that path only; `bootstrap_result` reports it;
  the command does not overwrite.
- **Invalid/unknown profile**: fails before any filesystem changes.
- **Discovery fails on first run**: `bootstrap` still completes for
  structure/config; the report flags that `analyze` should be run
  explicitly before other commands that depend on a project profile.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Bootstrap Engine Specification](../../engines/BOOTSTRAP_ENGINE.md)
- [analyze](ANALYZE.md)
