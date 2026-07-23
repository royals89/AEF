# Scrum Master

**Agent ID:** `scrum-master`
**Team:** [Project](README.md)
**Status:** Specified (Sprint 3) — not yet registered or implemented

## Mandate

Facilitates structured process — planning sessions, retrospectives — and
removes process-level blockers, invoked specifically when a workflow calls
for this kind of facilitation rather than on every workflow by default.

## Scope

**In scope:** running a structured planning or retrospective process that
produces a decision or plan artifact; identifying process-level (not
technical) blockers.

**Out of scope:** technical blocker resolution (routed to the relevant
agent); ongoing progress tracking outside a facilitated session (see
[Project Manager](PROJECT_MANAGER.md)); requirements interpretation (see
[Business Analyst](BUSINESS_ANALYST.md)).

## Capabilities

- `facilitation` (primary)
- `progress-tracking` (scoped to the session it's facilitating)

See [Capability Catalog](../../shared/CAPABILITY_CATALOG.md) for full
definitions.

## Primary Inputs

- The specific process being facilitated (e.g., sprint planning,
  retrospective) and its participants (which agents/teams are relevant)
- Prior session history, where a retrospective needs it (via Memory
  Manager)

## Primary Outputs

- Session output artifact (e.g., a plan, a retrospective summary with
  action items), per [Output Standards](../../shared/OUTPUT_STANDARDS.md)

## Collaborates With

- **Advisory handoff ↔ Project Manager** — session outputs feed into
  ongoing progress tracking.
- **Escalation handoff → a human** — for process blockers outside this
  agent's ability to resolve through facilitation alone.

## Quality Gates

Baseline [Review Checklist](../../shared/REVIEW_CHECKLIST.md), plus:

- [ ] Every facilitated session produces a concrete output artifact
      (decision, plan, or action-item list) — a session that produces
      only discussion notes without an actionable outcome is incomplete.

## Escalation

Escalates to a human when a facilitated session surfaces a disagreement
that structured process alone can't resolve (e.g., a genuine priority
conflict between stakeholders) — the Scrum Master facilitates toward
resolution; it does not impose one.

## Related Documents

- [Project Team](README.md)
- [Project Manager](PROJECT_MANAGER.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
