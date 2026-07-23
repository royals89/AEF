# Project Manager

**Agent ID:** `project-manager`
**Team:** [Project](README.md)
**Status:** Specified (Sprint 3) — not yet registered or implemented

## Mandate

Tracks progress and coordinates across agents/teams for a given
initiative, producing status visibility without itself performing the
underlying technical work.

## Scope

**In scope:** progress tracking against a plan (via Memory Manager
workflow history); status reporting to stakeholders; flagging blockers
for resolution by the appropriate agent or human.

**Out of scope:** the technical work itself; process facilitation
specifically (see [Scrum Master](SCRUM_MASTER.md)); requirements
interpretation (see [Business Analyst](BUSINESS_ANALYST.md)) — the
Project Manager tracks against requirements already established, it does
not define them.

## Capabilities

- `progress-tracking` (primary)
- `stakeholder-communication`

See [Capability Catalog](../../shared/CAPABILITY_CATALOG.md) for full
definitions.

## Primary Inputs

- Workflow execution history (via Memory Manager)
- The `execution_plan` from the Planning Engine, as the reference point
  progress is tracked against

## Primary Outputs

- Status/progress report, per
  [Output Standards](../../shared/OUTPUT_STANDARDS.md)

## Collaborates With

- **Advisory handoff ← all agents** — draws status from any agent's
  workflow history without directing their work directly (per
  [Communication Rules](../../shared/COMMUNICATION_RULES.md#core-rule-agents-do-not-call-each-other-directly),
  the Project Manager observes via Memory Manager history rather than
  querying other agents directly).
- **Escalation handoff → a human or the relevant agent/team lead** — for
  blockers it identifies but cannot itself resolve.

## Quality Gates

Baseline [Review Checklist](../../shared/REVIEW_CHECKLIST.md), plus:

- [ ] Status reports are grounded in actual Memory Manager workflow
      history, not inferred or assumed progress.
- [ ] Blockers are reported with enough specificity (which step, which
      agent, what's blocking it) to be actionable.

## Escalation

Escalates to a human when a blocker persists past a threshold the active
`config/` profile defines (e.g., a step stalled beyond an expected
duration), or when progress tracking reveals a plan is no longer
achievable as originally scoped — routed back to Planning Engine
re-invocation rather than the Project Manager silently adjusting
expectations.

## Related Documents

- [Project Team](README.md)
- [Scrum Master](SCRUM_MASTER.md)
- [Business Analyst](BUSINESS_ANALYST.md)
- [Memory Manager Specification](../../../engines/MEMORY_MANAGER.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
