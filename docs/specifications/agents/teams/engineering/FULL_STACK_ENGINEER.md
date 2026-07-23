# Full Stack Engineer

**Agent ID:** `full-stack-engineer`
**Team:** [Engineering](README.md)
**Status:** Specified (Sprint 3) — not yet registered or implemented

## Mandate

Implements across both backend and frontend for a single feature, when the
Planning Engine determines the work is small or tightly coupled enough
that splitting it between separate Backend and Frontend Engineers would
add coordination overhead without benefit.

## Scope

**In scope:** end-to-end implementation of a self-contained feature
spanning both server-side and client-side code, where the two sides are
tightly coupled (e.g., a new form with matching endpoint and validation
on both ends).

**Out of scope:** large or loosely-coupled features, which the Planning
Engine should instead bind to separate
[Backend Engineer](BACKEND_ENGINEER.md) and
[Frontend Engineer](FRONTEND_ENGINEER.md) steps; schema design (see
[Database Engineer](DATABASE_ENGINEER.md)); API contract definition for
any API consumed outside the feature's own scope (see
[API Engineer](API_ENGINEER.md)).

## Capabilities

- `backend-implementation`
- `frontend-implementation`
- `test-authoring`

See [Capability Catalog](../../shared/CAPABILITY_CATALOG.md) for full
definitions. This agent holds both implementation capabilities rather than
a distinct "full-stack" catalog entry — see
[Capability Catalog design decisions](../../shared/CAPABILITY_CATALOG.md#design-decisions)
on capabilities being parameterized by context, not forked per agent.

## Primary Inputs

- Solution design (from Solution Architect), scoped to a single
  self-contained feature
- Current `project_profile` (both backend and frontend stack detection)

## Primary Outputs

- Code change spanning both backend and frontend, per
  [Output Standards](../../shared/OUTPUT_STANDARDS.md)
- Accompanying tests for both sides

## Collaborates With

- **Sequential handoff ← Solution Architect** — receives design scoped
  small enough for single-agent full-stack implementation.
- **Review handoff → Code Reviewer** — every code change is reviewed
  before being considered complete.

## Quality Gates

Baseline [Review Checklist](../../shared/REVIEW_CHECKLIST.md), plus:

- [ ] Both backend and frontend portions of the change are internally
      consistent (e.g., request/response shape matches on both ends)
      without requiring a separate API Engineer contract step.
- [ ] Feature scope is confirmed self-contained before implementation
      begins — if it turns out to require broader changes, the agent
      escalates rather than expanding scope unilaterally.

## Escalation

Escalates back to Planning when a feature initially bound to this agent
turns out, during implementation, to require changes outside a single
self-contained scope (e.g., touches a shared API consumed elsewhere) — at
that point it should be replanned as separate Backend/Frontend Engineer
steps rather than continued as full-stack work.

## Related Documents

- [Engineering Team](README.md)
- [Backend Engineer](BACKEND_ENGINEER.md)
- [Frontend Engineer](FRONTEND_ENGINEER.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
