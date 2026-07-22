# Workflow Specification

## Purpose

Defines what an AEF "workflow" is, how it's structured, and how it's
executed by the Workflow Engine — the contract that both the Workflow Engine
implementation (Sprint 2+) and individual workflow definitions must satisfy.

## Scope

Covers the workflow definition model and execution semantics. Does not
cover the internal implementation of the Workflow Engine itself (see
[Architecture Specification](../architecture/ARCHITECTURE.md#workflow-engine))
or specific individual workflows, which are added as configuration in
Sprint 2+.

## Concept

A **workflow** is a configuration-driven, named, repeatable sequence of
steps that accomplishes a defined class of engineering task — e.g.,
"implement feature," "fix bug," "refactor module," "onboard new project."
Workflows are data (configuration), not code: adding a new workflow should
not require modifying the Workflow Engine itself, per the "Configuration
over Hardcoding" principle.

## Workflow Definition Model

A workflow definition declares:

| Field | Purpose |
|---|---|
| `name` | Unique workflow identifier |
| `description` | Human-readable purpose |
| `trigger` | How the workflow is invoked (command, hook, direct call) |
| `inputs` | Required/optional inputs (e.g., feature description, target files) |
| `steps` | Ordered list of steps (see below) |
| `quality_gates` | Which Quality Gates apply, and at which step boundaries |
| `governance` | Which steps require a Governance Layer approval checkpoint |

## Step Model

Each step in a workflow declares:

- **What it does** — an action, which may invoke a Domain Pack, request
  analysis from the Project Analyzer, or request a Quality Gate evaluation.
- **Inputs** — drawn from workflow inputs or prior step outputs.
- **Outputs** — written to the workflow's execution context and, where
  relevant, to Memory (via the Orchestrator — see
  [Architecture Specification](../architecture/ARCHITECTURE.md#memory)).
- **Failure behavior** — whether failure halts the workflow, triggers a
  defined fallback step, or is non-fatal.

## Execution Semantics

1. The Orchestrator receives a workflow invocation and resolves the named
   workflow definition.
2. The Orchestrator requests a current project profile from the Project
   Analyzer (see
   [Architecture Specification](../architecture/ARCHITECTURE.md#project-analyzer)).
3. Steps execute in order. A step that fails per its declared failure
   behavior either halts the workflow, runs its fallback, or is logged as
   non-fatal and skipped.
4. Quality Gates declared for a step boundary must pass before the next
   step proceeds.
5. Governance checkpoints declared for a step fire before that step
   executes; the step does not proceed without the required approval.
6. On completion (success or halted failure), results are written to Memory
   via the Orchestrator.

## Design Decisions

- **Steps are the unit of checkpointing.** Quality Gates and governance
  approvals attach to step boundaries, not to the workflow as a whole, so a
  long workflow can be checkpointed and, if needed, resumed rather than
  rerun from scratch.
- **Workflows do not call each other directly.** A workflow that needs the
  effect of another workflow invokes it through the Orchestrator as a new,
  trackable invocation — this keeps workflow execution history in Memory
  accurate and avoids hidden coupling between workflow definitions.

## Future Extension Points

- Conditional/branching steps (beyond simple linear sequences).
- Parallel step execution where steps have no interdependency.
- Workflow composition (one workflow referencing another as a sub-step,
  with clear execution-history semantics).

## Related Documents

- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Testing Standards](../standards/TESTING_STANDARDS.md)
- [Security Standards](../standards/SECURITY_STANDARDS.md)
