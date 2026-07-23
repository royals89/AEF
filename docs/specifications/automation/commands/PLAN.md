# Command: plan

**Command ID:** `plan`

## Purpose

Turns a requirement (typically already structured by the
[Business Analyst](../../agents/teams/project/BUSINESS_ANALYST.md)) and the
current project profile into a concrete `execution_plan`, without yet
executing it.

## Inputs

- `workflow_request` — named [Workflow Library](../workflows/WORKFLOW_LIBRARY.md)
  entry (e.g., New Feature, Bug Fix) plus its required inputs
- Current `project_profile` (from Memory Manager, refreshed via `analyze`
  if stale)

## Outputs

- `execution_plan` — per
  [Planning Engine Specification](../../engines/PLANNING_ENGINE.md#outputs)
- `planning_diagnostics` — if the requested workflow cannot be planned
  against the current project (e.g., missing plugin)

## Preconditions

- A current `project_profile` exists (via `analyze`).
- The named workflow exists in the
  [Workflow Library](../workflows/WORKFLOW_LIBRARY.md).

## Workflow

Directly invokes the [Planning Engine](../../engines/PLANNING_ENGINE.md)
via the Engineering Orchestrator, using the named
[Workflow Library](../workflows/WORKFLOW_LIBRARY.md) entry as the workflow
template to bind against the current project.

## Success Criteria

- `execution_plan` is produced with every step bound to an available
  plugin or agent (feasibility validated per
  [Planning Engine lifecycle](../../engines/PLANNING_ENGINE.md#lifecycle)),
  **or**
- `planning_diagnostics` clearly states what's missing, with no partial/
  invalid plan produced in its place.

## Failure Handling

- **No current project profile**: halts, suggests `analyze`.
- **Unknown workflow name**: halts before invoking the Planning Engine.
- **Infeasible plan**: returns `planning_diagnostics`; per
  [Planning Engine error handling](../../engines/PLANNING_ENGINE.md#error-handling),
  the command never silently drops a step to force a plan to "work."

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Planning Engine Specification](../../engines/PLANNING_ENGINE.md)
- [Workflow Library](../workflows/WORKFLOW_LIBRARY.md)
- [analyze](ANALYZE.md)
- [implement](IMPLEMENT.md)
