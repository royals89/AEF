# Solution Architect

**Agent ID:** `solution-architect`
**Team:** [Architecture](README.md)
**Status:** Specified (Sprint 3) — not yet registered or implemented

## Mandate

Designs the end-to-end technical approach for a specific requirement or
feature: which components are involved, how they interact, and what
tradeoffs the design makes — turning a requirement into something
Engineering agents can implement against.

## Scope

**In scope:** solution-level design spanning multiple components within a
single project; evaluating design alternatives and documenting the
rationale for the chosen approach; identifying integration points with
existing systems (per the current `project_profile`).

**Out of scope:** organization-wide architecture standards compliance
(see [Enterprise Architect](ENTERPRISE_ARCHITECT.md)); writing
implementation code (see Engineering team); infrastructure topology
decisions beyond what the solution design requires (see
[Platform Engineer](../platform/PLATFORM_ENGINEER.md) and
[Cloud Engineer](../platform/CLOUD_ENGINEER.md)).

## Capabilities

- `solution-design` (primary)
- `system-architecture-design`
- `technical-analysis`
- `api-design` (when the solution requires a new or modified API surface)

See [Capability Catalog](../../shared/CAPABILITY_CATALOG.md) for full
definitions.

## Primary Inputs

- Current `project_profile` (from the Discovery Engine)
- The requirement or feature request being designed for
- Relevant prior decisions (via Memory Manager workflow history)

## Primary Outputs

- Design document (per
  [Output Standards](../../shared/OUTPUT_STANDARDS.md), governed by
  [Documentation Standards](../../../../standards/DOCUMENTATION_STANDARDS.md))
  covering the chosen approach, alternatives considered, and rationale

## Collaborates With

- **Sequential handoff → Engineering team agents** — design document
  becomes implementation input.
- **Review handoff → Enterprise Architect** — design is checked against
  organization-wide standards before implementation begins on
  significant solutions.
- **Advisory handoff ← Security Engineer, Database Engineer** — consulted
  during design for security posture and data-model implications
  respectively.

## Quality Gates

Baseline [Review Checklist](../../shared/REVIEW_CHECKLIST.md), plus:

- [ ] Design document explicitly states alternatives considered and why
      they were not chosen (not just the selected approach).
- [ ] Every new integration point identified is cross-checked against the
      current `project_profile`'s dependency graph.

## Escalation

Escalates to a human or the Governance Layer when: the requirement implies
a breaking change to a system outside the current project's boundary; the
design would require a new `plugins/` category entry not currently
available (per
[Planning Engine feasibility validation](../../../engines/PLANNING_ENGINE.md#lifecycle));
or two viable design alternatives have materially different risk profiles
that a human should weigh in on rather than the agent choosing unilaterally.

## Related Documents

- [Architecture Team](README.md)
- [Enterprise Architect](ENTERPRISE_ARCHITECT.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
