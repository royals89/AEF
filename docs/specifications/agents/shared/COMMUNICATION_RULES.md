# Communication Rules

## Purpose

Defines how agents communicate — with each other, across teams, and with
the Orchestrator — so that 24 agents across 8 teams interact predictably
rather than each agent inventing its own handoff conventions.

## Scope

Covers communication structure and handoff rules between agents. Does not
cover the underlying transport/execution mechanism (that is runtime logic,
out of scope this sprint — see
[ADR 0002](../../../decisions/0002-agent-specifications-location.md)), nor
does it cover communication between AEF and a human requester (see
[Output Standards](OUTPUT_STANDARDS.md) for agent-to-human artifact shape).

## Core Rule: Agents Do Not Call Each Other Directly

Consistent with the Engineering Orchestrator's role as the sole
cross-component coordinator (see
[Engineering Orchestrator Specification](../../engines/ENGINEERING_ORCHESTRATOR.md)),
**agents do not invoke one another directly.** An agent's output becomes
input to another agent only via a workflow step boundary that the
Orchestrator/Workflow Engine mediates (see
[Workflow Specification](../../../workflows/WORKFLOW_SPEC.md)). This keeps
agent interaction auditable and keeps any single agent replaceable without
rippling changes through agents that "talk to" it.

This means every agent specification's "Collaborates With" field (per the
[Agent Contract](AGENT_CONTRACT.md)) describes a **workflow relationship**
— who typically precedes or follows this agent in a plan — not a direct
call relationship.

## Handoff Types

| Type | Description | Example |
|---|---|---|
| **Sequential handoff** | One agent's output is the next agent's input within the same workflow step sequence | Solution Architect's design → Backend Engineer's implementation |
| **Review handoff** | An agent's output is routed to another agent specifically for evaluation before proceeding | Backend Engineer's code → Code Reviewer |
| **Escalation handoff** | An agent halts and routes to a human or the Governance Layer per its Escalation clause (see [Agent Contract](AGENT_CONTRACT.md)) | Security Engineer identifies a critical finding → Governance Layer approval checkpoint |
| **Advisory handoff** | An agent is consulted for input without taking ownership of the next step | Compliance Engineer consulted during Solution Architect's design |

Every entry in an agent's "Collaborates With" field states which handoff
type applies.

## Cross-Team Handoff

Handoffs between agents on different teams follow the same rules as
within-team handoffs — there is no special cross-team protocol — but the
[Agent Framework Specification's capability matrix](../AGENT_FRAMEWORK_SPEC.md#capability-matrix)
is the reference for which team an agent belongs to, so a workflow's
Planning Engine binding (see
[Planning Engine Specification](../../engines/PLANNING_ENGINE.md)) can
correctly route a step regardless of team boundaries.

## Communication Content Rules

1. **Structured, not conversational.** Agent-to-agent handoff content
   follows [Output Standards](OUTPUT_STANDARDS.md) — free-form prose
   summaries are not a substitute for the structured artifact a receiving
   agent expects.
2. **Context is passed explicitly, not assumed.** A receiving agent should
   not need information that wasn't in its declared Primary Inputs (per
   the [Agent Contract](AGENT_CONTRACT.md)) — if an agent finds it needs
   something not explicitly handed to it, that is a signal the workflow
   step definition is incomplete, not that the agent should infer or
   guess.
3. **Escalations are never silent.** An escalation handoff always produces
   an explicit record (via `audit-logging`, per the
   [Capability Catalog](CAPABILITY_CATALOG.md#governance)) — an agent
   halting without a logged reason is a defect in the agent's
   specification, not acceptable behavior.

## Design Decisions

- **No direct agent-to-agent calls, ever.** This is the single most
  important rule in this document and is non-negotiable at the
  architecture level — it is what keeps the Orchestrator's star topology
  (see [Architecture Specification](../../../architecture/ARCHITECTURE.md#orchestrator))
  intact when agents are added on top of the engine layer.
- **Four handoff types, not an open-ended set.** Mirrors the fixed-
  category approach used elsewhere (plugin categories, capability
  categories) for the same reason: a small, named set of interaction
  shapes is what makes 24 agents' worth of "Collaborates With" fields
  actually comparable to each other.

## Future Extension Points

- Formal handoff schemas once agents are implemented (Sprint 4+),
  specifying exact payload shape per handoff type.
- Parallel/concurrent agent handoffs, once the Workflow Engine supports
  non-linear plans (see
  [Workflow Engine Specification](../../engines/WORKFLOW_ENGINE.md#future-enhancements)).

## Related Documents

- [Agent Contract](AGENT_CONTRACT.md)
- [Output Standards](OUTPUT_STANDARDS.md)
- [Engineering Orchestrator Specification](../../engines/ENGINEERING_ORCHESTRATOR.md)
- [Workflow Specification](../../../workflows/WORKFLOW_SPEC.md)
