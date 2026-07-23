# Review Checklist

## Purpose

The single checklist referenced by every agent's "Quality Gates" field
(per the [Agent Contract](AGENT_CONTRACT.md)) as the baseline bar its
output must clear, before any agent-specific additions.

## Scope

Covers the universal review checklist applied to all agent output. Does
not cover capability-specific or team-specific additional checks — those
are declared in each agent's own specification, as extensions to (never
replacements of) this baseline.

## Baseline Checklist

Every agent output is checked against:

- [ ] **Provenance present** — output declares which agent, which Agent
      ID, and which workflow invocation produced it (see
      [Output Standards](OUTPUT_STANDARDS.md#structural-requirements)).
- [ ] **Scope honored** — output stays within the agent's declared Scope
      (per its [Agent Contract](AGENT_CONTRACT.md) entry); anything
      outside scope was escalated or handed off, not silently absorbed.
- [ ] **Inputs referenced correctly** — output's Referenced Inputs match
      what the agent actually received; no unreferenced or fabricated
      input basis (see
      [Output Standards](OUTPUT_STANDARDS.md#quality-requirements)).
- [ ] **Claims are verifiable** — assertions in the output state their
      basis rather than standing unsupported.
- [ ] **Governing standard followed** — output complies with whichever
      standard applies to its category (see
      [Output Standards' category table](OUTPUT_STANDARDS.md#output-categories)).
- [ ] **Completeness signal accurate** — output is honestly marked
      final/partial/blocked; a partial result is never presented as
      complete.
- [ ] **Escalation honored where applicable** — if the agent's
      [Agent Contract](AGENT_CONTRACT.md) Escalation clause should have
      triggered, it did; the agent did not proceed past a condition it
      declared as an escalation trigger.

## How This Relates to Quality Gate Manager

This checklist is the baseline that the
[Quality Gate Manager](../../engines/QUALITY_GATE_MANAGER.md) evaluates
agent-produced Workflow Engine steps against, in the same way it evaluates
any other step output — see
[Quality Gate Manager Specification](../../engines/QUALITY_GATE_MANAGER.md#responsibilities).
An agent-specific Quality Gates addition (declared in that agent's own
specification) becomes an additional named gate the Quality Gate Manager
evaluates for that agent's steps specifically, layered on top of, not
instead of, this baseline.

## Agent-Specific Additions

An agent's specification may add checklist items beyond this baseline
where its capability warrants it (e.g., the Penetration Tester's output
additionally requires a documented severity rating per finding; the
Database Engineer's output additionally requires a rollback plan for any
schema migration). These additions are declared in the agent's own
"Quality Gates" field, referencing this document as the floor they build
on — never restating the baseline items themselves.

## Design Decisions

- **One universal baseline, extended per agent, never forked.** This is
  the direct application of the [Agent Contract](AGENT_CONTRACT.md)'s
  "no duplicated definitions" rule to review criteria specifically:
  24 agents extending one checklist stays auditable; 24 agents each
  inventing their own review bar does not.
- **Escalation-honored is a checklist item, not just a contract field.**
  Declaring an Escalation clause (per the
  [Agent Contract](AGENT_CONTRACT.md)) is necessary but not sufficient —
  this checklist is what actually verifies, per output, that the clause
  was respected in practice.

## Future Extension Points

- Automated checklist evaluation as part of Quality Gate Manager
  implementation (Sprint 4+ and beyond, following the Quality Gate
  Manager's own [Future Enhancements](../../engines/QUALITY_GATE_MANAGER.md#future-enhancements)).
- Checklist item weighting, if graduated (non-binary) Quality Gate results
  (already noted as a Quality Gate Manager future enhancement) are
  implemented.

## Related Documents

- [Agent Contract](AGENT_CONTRACT.md)
- [Output Standards](OUTPUT_STANDARDS.md)
- [Quality Gate Manager Specification](../../engines/QUALITY_GATE_MANAGER.md)
- [Review Standards](../../../standards/REVIEW_STANDARDS.md)
