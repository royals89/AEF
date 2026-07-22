# Workflow Engine Specification

## Purpose

The Workflow Engine executes the ordered steps of an `execution_plan`
produced by the Planning Engine, invoking the plugins and Quality Gate
checks each step calls for, in sequence, on behalf of the Orchestrator.

## Scope

Covers step execution mechanics. Does not cover deciding what the steps
should be (Planning Engine) or coordinating calls to other engines
(Orchestrator) — the Workflow Engine executes a plan it is given; it does
not modify or reinterpret it. General workflow *concepts* (definition
model, step model) are specified in
[Workflow Specification](../../workflows/WORKFLOW_SPEC.md); this document
covers the executing component's own contract.

## Responsibilities

- Execute an `execution_plan`'s steps in the order Planning specified.
- Invoke the plugin(s) each step is bound to, per the plan.
- Request Quality Gate Manager evaluation at the step boundaries the plan
  marks as gated, and apply that gate's declared failure behavior (halt,
  fallback, non-fatal).
- Propagate each step's outputs as inputs to subsequent steps per the
  plan's declared data flow.
- Report step-by-step results back to the Orchestrator as they complete,
  not only at the end of the full plan — so the Orchestrator can halt
  promptly on failure or governance checkpoint.

## Inputs

| Input | Description |
|---|---|
| `execution_plan` | From the Planning Engine, via the Orchestrator |
| `workflow_context` | Accumulated inputs/outputs as steps complete |

## Outputs

| Output | Description |
|---|---|
| `step_result` (per step) | Status, outputs, any Quality Gate outcome, emitted as each step completes |
| `execution_result` | Final aggregate: overall status and full step history, once the plan finishes or halts |

## Interfaces

- **Inbound:** invoked by the Orchestrator only, per the star-topology rule
  in [Architecture Specification](../../architecture/ARCHITECTURE.md#orchestrator).
- **Outbound:** invokes plugins (via the Plugin Manager) as directed by
  each step, and requests Quality Gate Manager evaluations at gated step
  boundaries. Does not call Discovery, Planning, or Memory Manager directly
  — those interactions belong to the Orchestrator.

## Lifecycle

1. **Receive** an `execution_plan` from the Orchestrator.
2. **For each step, in order:**
   a. Resolve step inputs from `workflow_context`.
   b. Invoke the step's bound plugin(s).
   c. If the step is gated, request Quality Gate Manager evaluation and
      apply its declared failure behavior.
   d. Record `step_result` and update `workflow_context` with the step's
      outputs.
   e. Report `step_result` to the Orchestrator.
3. **On plan completion or halt**, return the aggregate `execution_result`.

## Extension Points

- **Step types are plugin-defined**, not hardcoded in the Workflow Engine —
  adding a new kind of step (e.g., a new plugin category's action) requires
  no Workflow Engine changes, only a new or updated plugin (see
  [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md)).
- **Failure-behavior policies** (halt / fallback / non-fatal) are declared
  per step in the plan, not fixed in the engine.

## Error Handling

- **Step execution failure:** applies the step's declared failure
  behavior. If none is declared, the default is halt — the Workflow Engine
  never silently skips a failed step.
- **Quality Gate failure at a gated boundary:** same declared-behavior
  handling as step failure; a failing gate is treated as seriously as a
  failing step, not as advisory-only, unless explicitly configured as
  non-fatal.
- **Plugin invocation error (e.g., plugin missing/incompatible at
  execution time, despite passing Planning's feasibility check):** treated
  as a step failure; the Workflow Engine surfaces this distinctly so the
  Orchestrator/Memory record shows it as a runtime discrepancy from the
  plan, not an ordinary step failure.

## Future Enhancements

- Non-linear (branching, parallel) plan execution — currently plans are
  linear sequences, per [Workflow Specification](../../workflows/WORKFLOW_SPEC.md#future-extension-points).
- Mid-plan checkpoint/resume, coordinated with the Orchestrator's own
  resumability future enhancement (see
  [Engineering Orchestrator Specification](ENGINEERING_ORCHESTRATOR.md#future-enhancements)).

## Related Documents

- [Workflow Specification](../../workflows/WORKFLOW_SPEC.md)
- [Planning Engine Specification](PLANNING_ENGINE.md)
- [Engineering Orchestrator Specification](ENGINEERING_ORCHESTRATOR.md)
- [Quality Gate Manager Specification](QUALITY_GATE_MANAGER.md)
- [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md)
