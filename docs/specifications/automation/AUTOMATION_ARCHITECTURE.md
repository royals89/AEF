# Automation Architecture

## Purpose

Defines how AEF's automation layer — commands, hooks, events, and the
workflow library — connects users, workflows, runtime engines, and
engineering agents. This document is the anchor for
`docs/specifications/automation/` in the same way the
[Agent Framework Specification](../agents/AGENT_FRAMEWORK_SPEC.md) anchors
the agent layer and the [Architecture Specification](../../architecture/ARCHITECTURE.md)
anchors the engine layer.

## Scope

Covers how the four automation concepts (commands, hooks, events,
workflows) relate to each other and to the engine/agent layers beneath
them. Does not cover any one concept's full detail — see
[Command Contract](commands/COMMAND_CONTRACT.md),
[Hook Framework](hooks/HOOK_FRAMEWORK.md),
[Event Catalog](events/EVENT_CATALOG.md), and
[Workflow Library](workflows/WORKFLOW_LIBRARY.md) respectively. Does not
cover runtime implementation — see
[ADR 0003](../../decisions/0003-automation-specifications-location.md).

## The Four Layers, and How They Compose

AEF now has four layers, each built on the one below it:

```
┌─────────────────────────────────────────────────────┐
│  Automation Layer (Sprint 4)                          │
│  Commands · Hooks · Events · Workflow Library          │
├─────────────────────────────────────────────────────┤
│  Agent Layer (Sprint 3)                                │
│  24 agents across 8 teams, invoked as Workflow steps    │
├─────────────────────────────────────────────────────┤
│  Engine Layer (Sprint 2)                                │
│  Bootstrap · Discovery · Planning · Orchestrator ·        │
│  Workflow · Memory · Quality Gate                         │
├─────────────────────────────────────────────────────┤
│  Core Framework (Sprint 1–2)                             │
│  Config, lifecycle, extension points, Runtime Abstraction  │
└─────────────────────────────────────────────────────┘
```

A person (or a future `.claude/commands/` invocation) interacts with a
**command**. A command triggers a **workflow** from the
[Workflow Library](workflows/WORKFLOW_LIBRARY.md). That workflow is
executed by the Engineering Orchestrator, Planning Engine, and Workflow
Engine exactly as specified in Sprint 2, invoking **agents** exactly as
specified in Sprint 3. As the Orchestrator moves through a workflow's
lifecycle stages, it fires **hooks**, and each hook firing emits an
**event** that automation rules can react to.

Nothing in this layer changes how the engine or agent layers work — it
sits on top of them, using their existing contracts (the Orchestrator's
star-topology coordination, the Workflow Engine's step execution, the
Agent Contract's handoff model) rather than introducing parallel
mechanisms.

## Commands Trigger Workflows; They Are Not Workflows

A command (see [Command Contract](commands/COMMAND_CONTRACT.md)) is a
named entry point a user or future runtime invokes. Its "Workflow" field
names which [Workflow Library](workflows/WORKFLOW_LIBRARY.md) entry it
triggers (or, for `bootstrap`, `doctor`, and `update`, which engine it
invokes directly — these three are the exceptions that don't route through
the Workflow Library, since they operate on AEF's own management of a
repository rather than on the repository's engineering work). A command
never redefines workflow steps inline; doing so would create two places
workflow logic could live, which is exactly what
[Workflow Specification](../../workflows/WORKFLOW_SPEC.md) and the
[Planning Engine](../engines/PLANNING_ENGINE.md) already exist to prevent.

## Hooks Emit Events; They Are Not Events Themselves

A hook (see [Hook Framework](hooks/HOOK_FRAMEWORK.md)) is a *named point*
in the Orchestrator's execution of a workflow. When the Orchestrator
reaches that point, it fires the hook, and firing the hook emits the
corresponding entry in the [Event Catalog](events/EVENT_CATALOG.md). This
two-step relationship (named point → emitted event) is what lets
[Automation Rules](AUTOMATION_RULES.md) attach behavior to *either* the
lifecycle concept (a hook, when writing a rule about "before deployment")
or the event stream (when writing a rule about "any event of type
`*.after`") without those being two competing designs.

## Events Are the Connective Tissue

Every hook firing produces exactly one event (see
[Event Catalog: Hook-Derived Events](events/EVENT_CATALOG.md#hook-derived-events)).
A small set of additional state-change events (`workflow.halted`,
`quality-gate.failed`, `escalation.raised`, `release.tagged`) are emitted
outside the hook lifecycle, for state changes that don't correspond to a
scheduled lifecycle stage. Automation Rules are, mechanically, event
subscriptions — see [Automation Rules](AUTOMATION_RULES.md).

## Why This Layering, Not a Simpler One

A simpler design — commands calling engines/agents directly, with no hook/
event layer — was considered and rejected, because it would mean any new
automation behavior (notifications, additional validation, audit logging
beyond what Memory Manager already captures) would require modifying
commands or engines directly, violating "Configuration over Hardcoding"
(see [Architecture Principles](../../architecture/ARCHITECTURE.md#architecture-principles)).
The hook/event layer exists specifically so automation behavior is
addable via [Automation Rules](AUTOMATION_RULES.md) — configuration — 
rather than by editing the Command Framework, Hook Framework, or engine
layer themselves.

## Design Decisions

- **Four layers, strictly ordered.** Automation depends on Agents depends
  on Engines depends on Core Framework — never the reverse. This is the
  same "no upward dependency" discipline already implicit in the engine
  layer's star topology, extended one layer further.
- **Three commands bypass the Workflow Library by design.**
  `bootstrap`, `doctor`, and `update` operate on AEF's own management
  surface (structure, diagnostics, versions) rather than on engineering
  work product, so routing them through the Workflow Library would add
  indirection without benefit — see each command's own "Workflow" field
  for the direct engine invocation it uses instead.
- **Hooks and events are deliberately two different vocabularies for the
  same underlying moments**, not two redundant systems — a hook names
  *where in execution*; an event is *what gets published* when execution
  reaches there. See
  [Hook Framework: Scope](hooks/HOOK_FRAMEWORK.md#scope) for the
  boundary statement from the other side.

## Future Extension Points

- Command composition (a command that itself triggers more than one
  workflow in sequence) — deferred until a real use case demonstrates it's
  needed beyond what chaining commands manually already provides.
- Custom, project-defined hooks beyond the 12 specified this sprint, once
  the Plugin Manager (Sprint 7+, per [Roadmap](../../roadmap/ROADMAP.md))
  can register them safely.

## Related Documents

- [Command Contract](commands/COMMAND_CONTRACT.md)
- [Hook Framework](hooks/HOOK_FRAMEWORK.md)
- [Event Catalog](events/EVENT_CATALOG.md)
- [Workflow Library](workflows/WORKFLOW_LIBRARY.md)
- [Automation Rules](AUTOMATION_RULES.md)
- [Agent Framework Specification](../agents/AGENT_FRAMEWORK_SPEC.md)
- [Architecture Specification](../../architecture/ARCHITECTURE.md)
- [ADR 0003: Automation specifications location](../../decisions/0003-automation-specifications-location.md)
