# Event Catalog

## Purpose

Defines the standard set of events AEF emits — one event per lifecycle
hook firing, plus a small set of state-change events not tied to a hook —
so automation rules, logging, and future integrations have a single,
canonical event vocabulary rather than each hook consumer inventing its
own notification shape.

## Scope

Covers event definitions: names, producers, consumers, payload shape,
ordering guarantees, and retry strategy. Does not cover the hooks that
emit most of these events (see [Hook Framework](../hooks/HOOK_FRAMEWORK.md))
or how events connect to automation behavior (see
[Automation Rules](../AUTOMATION_RULES.md)).

## Event Contract

Every event declares:

| Field | Description |
|---|---|
| **Event Name** | `<lifecycle-stage>.<hook-timing>` (e.g., `analysis.before`) for hook-derived events, or `<subject>.<state-change>` for others |
| **Producer** | The single component that emits this event (always the Engineering Orchestrator, firing on behalf of the engine/agent whose lifecycle stage triggered it — see [Hook Framework: Design Decisions](../hooks/HOOK_FRAMEWORK.md#design-decisions)) |
| **Consumers** | Automation rules, hooks, or logging/audit subscribers that may receive this event |
| **Payload** | The structured data included with the event |
| **Ordering** | Whether this event is guaranteed to fire before/after another named event |
| **Retry Strategy** | Whether a failed consumer delivery is retried, and how |

## Hook-Derived Events

One event per lifecycle hook (see
[Hook Framework: The 12 Lifecycle Hooks](../hooks/HOOK_FRAMEWORK.md#the-12-lifecycle-hooks)),
named `<stage>.before` / `<stage>.after`:

| Event Name | Producer | Payload |
|---|---|---|
| `analysis.before` | Engineering Orchestrator | `target_path`, `resolved_config` |
| `analysis.after` | Engineering Orchestrator | `project_profile`, `discovery_diff` |
| `planning.before` | Engineering Orchestrator | `project_profile`, `workflow_request` |
| `planning.after` | Engineering Orchestrator | `execution_plan` or `planning_diagnostics` |
| `generation.before` | Engineering Orchestrator | step definition, bound agent's Agent ID |
| `generation.after` | Engineering Orchestrator | agent output artifact reference, per [Output Standards](../../agents/shared/OUTPUT_STANDARDS.md#structural-requirements) |
| `file-modification.before` | Engineering Orchestrator | target file path, change type (create/modify/delete) |
| `file-modification.after` | Engineering Orchestrator | target file path, diff reference |
| `commit.before` | Engineering Orchestrator | proposed commit message, branch name |
| `commit.after` | Engineering Orchestrator | commit hash, branch name |
| `deployment.before` | Engineering Orchestrator | deployment target, active `config/` profile |
| `deployment.after` | Engineering Orchestrator | deployment result, rollback path reference |

Consumers for hook-derived events are exactly the hook's declared Typical
Consumers (see
[Hook Framework](../hooks/HOOK_FRAMEWORK.md#the-12-lifecycle-hooks)) —
this catalog does not redefine consumers per event separately from what
the corresponding hook already specifies.

## State-Change Events (not hook-derived)

| Event Name | Producer | Consumers | Payload |
|---|---|---|---|
| `workflow.halted` | Engineering Orchestrator | Project Manager (progress tracking), notification rules | halted reason (`halted-with-failure` / `halted-for-approval`), the step at which it halted |
| `quality-gate.failed` | Quality Gate Manager (via Workflow Engine report) | the implementing agent, notification rules | `gate_result`, the step it applied to |
| `escalation.raised` | any agent, via the Orchestrator's single-write-path (see [Memory Manager Specification](../../engines/MEMORY_MANAGER.md)) | Governance Layer, Project Manager | escalating Agent ID, reason, per [Communication Rules: escalations are never silent](../../agents/shared/COMMUNICATION_RULES.md#communication-content-rules) |
| `release.tagged` | `release` command (see [release](../commands/RELEASE.md)) | Technical Writer, notification rules | version, tag reference |

## Ordering

- Every `<stage>.before` event fires strictly before its corresponding
  `<stage>.after` event, and before the underlying engine/agent call
  begins — never concurrently.
- `workflow.halted` and `escalation.raised` may fire at any point relative
  to hook-derived events, since they represent an interruption rather than
  a scheduled stage.
- Events within a single workflow invocation are ordered relative to each
  other by the sequence the Workflow Engine actually executes steps in
  (per
  [Workflow Engine Specification: Lifecycle](../../engines/WORKFLOW_ENGINE.md#lifecycle));
  AEF does not guarantee ordering *across* concurrent workflow invocations.

## Retry Strategy

- **Before-hook-derived events** (able to halt, per
  [Hook Framework](../hooks/HOOK_FRAMEWORK.md#rules)): consumer delivery
  is not retried automatically — a Before-hook consumer that fails to
  respond is treated as a halt condition itself (fail-safe, not fail-open),
  consistent with the framework's general "fail loud" posture (see
  [Coding Standards: Design Decisions](../../../standards/CODING_STANDARDS.md#design-decisions)).
- **After-hook-derived events** (observation-only): consumer delivery is
  retried up to a configurable limit (per the active `config/` profile);
  exhausting retries is logged but does not affect workflow outcome,
  since After-hooks cannot halt by design.
- **State-change events**: `escalation.raised` and `quality-gate.failed`
  follow the Before-hook retry policy (fail-safe — an undelivered
  escalation must not be silently dropped); `workflow.halted` and
  `release.tagged` follow the After-hook retry policy.

## Design Decisions

- **One producer per event, always the Engineering Orchestrator.** This
  keeps the event system consistent with the star-topology rule already
  established — no engine or agent emits events directly, exactly as none
  call each other directly (see
  [Communication Rules](../../agents/shared/COMMUNICATION_RULES.md#core-rule-agents-do-not-call-each-other-directly)).
- **Fail-safe retry for anything that can halt or represents an
  escalation; fail-open (retry, don't block) for pure observation events.**
  This mirrors the Before/After hook halt distinction directly rather than
  introducing a separate policy axis.

## Future Extension Points

- Event payload schemas (machine-readable), once hooks/events are
  implemented.
- Cross-workflow event ordering guarantees, if a future use case requires
  coordinating multiple concurrent workflow invocations.
- Additional state-change events as automation needs grow (e.g., a
  `plugin.registered` event once the Plugin Manager is implemented).

## Related Documents

- [Hook Framework](../hooks/HOOK_FRAMEWORK.md)
- [Automation Rules](../AUTOMATION_RULES.md)
- [Automation Architecture](../AUTOMATION_ARCHITECTURE.md)
- [Communication Rules](../../agents/shared/COMMUNICATION_RULES.md)
