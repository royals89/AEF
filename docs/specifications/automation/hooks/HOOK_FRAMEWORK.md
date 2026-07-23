# Hook Framework

## Purpose

Defines AEF's lifecycle hooks: named points in a workflow's execution
where automation can observe or intervene without modifying the engine or
agent that owns that lifecycle stage. Hooks are how the
[Automation Rules](../AUTOMATION_RULES.md) connect events to side effects
(logging, notification, additional validation) without hardcoding that
behavior into the Engineering Orchestrator, Workflow Engine, or any agent.

## Scope

Covers the hook contract and all 12 lifecycle hooks required this sprint.
Does not cover the Event Catalog itself (see
[Event Catalog](../events/EVENT_CATALOG.md)) — hooks and events are
related but distinct: a hook is a *named point* in the lifecycle; firing
that hook *emits* an event, per
[Automation Architecture: Hooks Emit Events](../AUTOMATION_ARCHITECTURE.md#hooks-emit-events-they-are-not-events-themselves).
Does not cover runtime implementation — see
[ADR 0003](../../../decisions/0003-automation-specifications-location.md).

## Hook Contract

Every hook declares:

| Field | Description |
|---|---|
| **Hook ID** | Unique, kebab-case identifier (e.g., `before-analysis`) |
| **Trigger Point** | The exact moment in engine/agent execution this hook fires |
| **Purpose** | Why this point in the lifecycle is exposed as a hook |
| **Inputs Available** | What context a hook consumer receives when the hook fires |
| **Can Halt Workflow** | Whether a hook consumer's response can block progress past this point, or is observation-only |
| **Typical Consumers** | Which kind of automation rule/agent typically attaches here |
| **Failure Handling** | What happens if a hook consumer itself fails |

## Rules

1. **Hooks never replace the engine/agent step they wrap.** A hook fires
   before or after a step; it does not substitute for the step's own
   logic — this mirrors the Engineering Orchestrator's star-topology rule
   (see
   [Architecture Specification](../../../architecture/ARCHITECTURE.md#orchestrator)):
   hooks observe or gate, they do not become a new coordinating authority.
2. **Only "Before" hooks can halt.** Per the table below, every hook that
   can block workflow progress is a "Before" hook; every "After" hook is
   observation-only. This is a deliberate, fixed rule (see
   [Design Decisions](#design-decisions)), not decided per-hook.
3. **A hook consumer's failure never silently swallows the underlying
   step's result.** If a hook consumer errors, that error is recorded
   distinctly from the step's own success/failure (mirroring
   [Quality Gate Manager error handling's crashed-vs-failed distinction](../../engines/QUALITY_GATE_MANAGER.md#error-handling)).

## The 12 Lifecycle Hooks

| Hook ID | Trigger Point | Can Halt? | Typical Consumers |
|---|---|---|---|
| `before-analysis` | Immediately before the Discovery Engine begins a scan | Yes | Automation rules gating analysis on repository state |
| `after-analysis` | Immediately after `project_profile` is written to Memory Manager | No | Notification rules, downstream cache invalidation |
| `before-planning` | Immediately before the Planning Engine begins binding a workflow to a project profile | Yes | Automation rules validating a workflow request before planning starts |
| `after-planning` | Immediately after an `execution_plan` (or `planning_diagnostics`) is produced | No | Notification rules, plan review automation |
| `before-generation` | Immediately before an Engineering/AI-team agent begins producing a code or content change | Yes | Automation rules enforcing pre-generation constraints (e.g., branch protection) |
| `after-generation` | Immediately after an agent's output is produced, before Quality Gate evaluation | No | Automation rules queuing the output for `review`/`test` |
| `before-file-modification` | Immediately before any agent writes to a file in the target repository | Yes | Automation rules enforcing file-level policy (e.g., protected paths) |
| `after-file-modification` | Immediately after a file write completes | No | Automation rules triggering incremental `analyze` |
| `before-commit` | Immediately before a change is committed, per [Git & Branching Standards](../../../standards/GIT_BRANCHING_STANDARDS.md) | Yes | Automation rules enforcing commit-message/branch-naming compliance |
| `after-commit` | Immediately after a commit completes | No | Notification rules, workflow-history annotation |
| `before-deployment` | Immediately before the DevOps Engineer's deployment automation executes | Yes | Automation rules enforcing deployment approval gates |
| `after-deployment` | Immediately after a deployment completes (success or failure) | No | Notification rules, automated `secure`/`test` follow-up scheduling |

## Design Decisions

- **Before hooks can halt; After hooks cannot.** This is a hard rule, not
  a per-hook choice, because "after" hooks fire once the underlying action
  is already irreversible (a scan ran, a file was written, a commit
  happened) — allowing an "after" hook to retroactively block would
  require the framework to support undo semantics it does not have. Where
  gating is needed, it belongs on the corresponding "before" hook instead.
- **Twelve hooks, six before/after pairs**, matching exactly the six
  lifecycle stages named in the Sprint 4 bootstrap (Analysis, Planning,
  Generation, File Modification, Commit, Deployment) — no additional
  hooks were introduced beyond what was specified, keeping the hook
  surface exactly as scoped.
- **Hooks are fired by the Engineering Orchestrator**, not by individual
  engines or agents, consistent with the Orchestrator's role as sole
  cross-component coordinator (see
  [Engineering Orchestrator Specification](../../engines/ENGINEERING_ORCHESTRATOR.md)) —
  an engine or agent does not know or care whether a hook is attached; the
  Orchestrator fires the hook around its own call to that engine/agent.

## Future Extension Points

- Hook consumer priority/ordering, for when multiple automation rules
  attach to the same hook.
- Async ("fire and forget") hook consumers for After-hooks that shouldn't
  block workflow progress even to run their own logic.
- Hook-level Quality Gate integration once
  [Quality Gate Manager](../../engines/QUALITY_GATE_MANAGER.md) implementation
  begins, so a Before-hook's halt reason is itself a first-class gate
  result.

## Related Documents

- [Automation Architecture](../AUTOMATION_ARCHITECTURE.md)
- [Event Catalog](../events/EVENT_CATALOG.md)
- [Automation Rules](../AUTOMATION_RULES.md)
- [Engineering Orchestrator Specification](../../engines/ENGINEERING_ORCHESTRATOR.md)
