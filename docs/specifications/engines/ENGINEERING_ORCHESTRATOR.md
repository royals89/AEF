# Engineering Orchestrator Specification

## Purpose

The Engineering Orchestrator is the sole coordinator across Discovery,
Planning, Workflow Engine, Quality Gate Manager, and Memory Manager. It
sequences their calls for a given workflow invocation and is the only
component permitted to call across those boundaries — see
[Architecture Specification](../../architecture/ARCHITECTURE.md#orchestrator).

## Scope

Covers coordination and sequencing only. Does not cover generating a plan
(Planning Engine), executing plan steps (Workflow Engine), evaluating
quality checkpoints (Quality Gate Manager), or persisting state (Memory
Manager) — the Orchestrator calls each of these but implements none of
their logic itself.

## Responsibilities

- Receive a workflow invocation (from a Runtime Adapter or, in Sprint 3+, a
  `.claude/commands/` command) and drive it end-to-end.
- Call the Discovery Engine to obtain a current `project_profile`.
- Call the Planning Engine to obtain an `execution_plan`.
- Call the Workflow Engine to execute the plan's steps in order.
- Call the Quality Gate Manager at each step boundary that requires it, per
  the plan.
- Call the Memory Manager to persist results, decisions, and updated
  project-profile information — the single write path described in the
  [Architecture Specification](../../architecture/ARCHITECTURE.md#memory).
- Surface governance checkpoints at the correct point in execution and halt
  progress until they are satisfied.
- Report final workflow outcome (success, halted-with-failure, halted-for-
  approval) back to the invoking Runtime Adapter.

## Inputs

| Input | Description |
|---|---|
| `workflow_request` | Named workflow plus inputs, from a Runtime Adapter |
| `runtime_context` | Identifies the invoking Runtime Adapter |

## Outputs

| Output | Description |
|---|---|
| `workflow_result` | Final outcome: status, step-by-step results, any halted-for-approval state |
| Memory writes | Project profile updates, workflow execution history, decisions — all written via the Memory Manager |

## Interfaces

- **Inbound:** invoked by a Runtime Adapter, or (Sprint 3+) by a
  `.claude/commands/` command that itself calls into a Runtime Adapter.
- **Outbound:** the Orchestrator is the only component that calls
  Discovery, Planning, Workflow Engine, Quality Gate Manager, and Memory
  Manager directly. None of those five call each other directly — every
  cross-component interaction goes through the Orchestrator. This is
  unchanged from Sprint 1 and remains the star-topology design that keeps
  each engine independently replaceable.

## Lifecycle

1. **Receive** a `workflow_request`.
2. **Discover** — call the Discovery Engine for the current
   `project_profile` (incremental if a prior profile exists in Memory).
3. **Plan** — call the Planning Engine with the `project_profile` and
   `workflow_request` to obtain an `execution_plan`; halt and report if
   Planning returns `planning_diagnostics` instead.
4. **Execute** — call the Workflow Engine to run the plan's steps in
   order, invoking Quality Gate Manager checks and governance checkpoints
   at the step boundaries the plan specifies.
5. **Persist** — call the Memory Manager to write results, updated project
   profile, and any decisions made, on both success and halted-failure
   paths.
6. **Report** — return `workflow_result` to the invoking Runtime Adapter.

## Extension Points

- **New workflow types** require no Orchestrator changes — they are
  resolved entirely within Planning and Workflow Engine (see
  [Workflow Specification](../../workflows/WORKFLOW_SPEC.md)).
- **New Runtime Adapters** invoke the Orchestrator through the same
  contract regardless of which AI coding runtime they wrap (see
  [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md)) —
  the Orchestrator has no runtime-specific logic.

## Error Handling

- **Any engine call fails:** the Orchestrator halts the workflow at that
  point, writes the partial state and failure reason to Memory via the
  Memory Manager, and returns a `workflow_result` with status
  `halted-with-failure` rather than silently continuing.
- **Governance checkpoint not satisfied:** the Orchestrator halts and
  returns `halted-for-approval`, resumable once the checkpoint is
  satisfied — it does not retry or bypass the checkpoint itself.
- **Quality Gate failure:** treated per that gate's declared failure
  behavior in the plan (halt, fallback step, or non-fatal) — the
  Orchestrator enforces this declared behavior rather than applying a
  single fixed policy.

## Future Enhancements

- Resumable workflow execution from a persisted mid-workflow checkpoint
  (currently, halted workflows require re-invocation).
- Parallel execution of independent plan steps, once the Workflow Engine
  supports non-linear plans (see
  [Workflow Specification](../../workflows/WORKFLOW_SPEC.md#future-extension-points)).

## Related Documents

- [Architecture Specification](../../architecture/ARCHITECTURE.md)
- [Discovery Engine Specification](DISCOVERY_ENGINE.md)
- [Planning Engine Specification](PLANNING_ENGINE.md)
- [Workflow Engine Specification](WORKFLOW_ENGINE.md)
- [Quality Gate Manager Specification](QUALITY_GATE_MANAGER.md)
- [Memory Manager Specification](MEMORY_MANAGER.md)
