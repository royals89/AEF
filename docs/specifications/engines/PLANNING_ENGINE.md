# Planning Engine Specification

## Purpose

The Planning Engine turns a `project_profile` (from Discovery) plus a
requested workflow into a concrete, ordered **execution plan** — the
specific steps, in the specific order, with the specific plugins and
Quality Gates attached, that the Orchestrator will carry out via the
Workflow Engine. It is new in Sprint 2 — see
[ADR 0001](../../decisions/0001-sprint-2-structural-evolution.md) for why
planning was split out from the Orchestrator.

## Scope

Covers plan generation only. Does not cover plan *execution* — that is the
Workflow Engine's responsibility (see
[Workflow Specification](../../workflows/WORKFLOW_SPEC.md)) — and does not
cover discovering the underlying project facts a plan is based on (see
[Discovery Engine Specification](DISCOVERY_ENGINE.md)).

## Responsibilities

- Resolve a requested workflow (by name, per
  [Workflow Specification](../../workflows/WORKFLOW_SPEC.md)) against the
  current `project_profile` to produce a concrete, project-specific
  execution plan — the same named workflow can yield different concrete
  plans on different projects, depending on detected stack and configured
  profile.
- Select which `plugins/` entries a given plan's steps will invoke, based
  on Discovery's plugin mapping.
- Attach the Quality Gates and governance checkpoints that apply to the
  resolved plan's steps, per the active `config/` profile.
- Detect when a requested workflow cannot be planned against the current
  project profile (e.g., missing a required plugin) and report this rather
  than producing an invalid plan.

## Inputs

| Input | Description |
|---|---|
| `project_profile` | Current Discovery output |
| `workflow_request` | Named workflow plus any user-supplied inputs (see [Workflow Specification](../../workflows/WORKFLOW_SPEC.md)) |
| `resolved_config` | Active `config/` profile, governing which Quality Gates/governance checkpoints are mandatory |
| `plugin_registry` | Available plugins from the Plugin Manager |

## Outputs

| Output | Description |
|---|---|
| `execution_plan` | Ordered steps, each bound to concrete plugins, inputs/outputs, and attached Quality Gates/governance checkpoints |
| `planning_diagnostics` | Any workflow requirements that could not be satisfied (e.g., missing plugin), returned instead of a partial/invalid plan |

## Interfaces

- **Inbound:** invoked by the Orchestrator after Discovery completes, at
  the start of a workflow invocation.
- **Outbound:** reads from the Plugin Manager (available plugins) and
  Configuration (active profile); does not invoke the Workflow Engine,
  Quality Gate Manager, or any plugin directly — Planning produces a plan;
  it does not execute one. This mirrors the Orchestrator's role as the sole
  cross-component coordinator (see
  [Architecture Specification](../../architecture/ARCHITECTURE.md#orchestrator)):
  Planning is consulted by the Orchestrator, not a peer that calls other
  engines itself.

## Lifecycle

1. **Resolve workflow definition** — look up the named workflow template.
2. **Bind to project** — combine the workflow template with
   `project_profile` to determine concrete steps (e.g., a generic "run
   tests" step becomes "run pytest" for a detected Python project).
3. **Attach gates and checkpoints** — apply the Quality Gates and
   governance checkpoints mandated by `resolved_config` for this workflow
   type.
4. **Validate feasibility** — confirm every step's required plugin is
   present in `plugin_registry`; if not, produce `planning_diagnostics`
   instead of an incomplete plan.
5. **Return** — hand `execution_plan` (or `planning_diagnostics` on
   failure) back to the Orchestrator.

## Extension Points

- **Workflow-to-plan binding rules** are supplied per workflow definition
  (see [Workflow Specification](../../workflows/WORKFLOW_SPEC.md)), not
  hardcoded in the Planning Engine — new workflows are addable without
  Planning Engine code changes.
- **Profile-driven gate/checkpoint attachment** means a new `config/`
  profile can change what gets attached to plans without touching Planning
  Engine logic (see [Configuration Specification](../CONFIGURATION_SPEC.md)).

## Error Handling

- **Infeasible plan (missing plugin, unsupported stack):** Planning returns
  `planning_diagnostics` describing exactly what's missing; it never
  silently drops a step to make a plan "work."
- **Ambiguous binding** (e.g., two plugins both claim the same step):
  resolved by explicit priority declared in the plugin manifest (see
  [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md));
  if priority is unresolved, Planning fails with a diagnostic rather than
  guessing.

## Future Enhancements

- Cost/impact estimation attached to plans (e.g., estimated blast radius
  from Discovery's dependency graph).
- Plan simulation/dry-run output for human review before execution.
- Multi-plan comparison when more than one valid plan satisfies a workflow
  request.

## Related Documents

- [ADR 0001: Sprint 2 structural evolution](../../decisions/0001-sprint-2-structural-evolution.md)
- [Discovery Engine Specification](DISCOVERY_ENGINE.md)
- [Engineering Orchestrator Specification](ENGINEERING_ORCHESTRATOR.md)
- [Workflow Engine Specification](WORKFLOW_ENGINE.md)
- [Configuration Specification](../CONFIGURATION_SPEC.md)
