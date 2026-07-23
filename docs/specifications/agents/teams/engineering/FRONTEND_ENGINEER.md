# Frontend Engineer

**Agent ID:** `frontend-engineer`
**Team:** [Engineering](README.md)
**Status:** Specified (Sprint 3) — not yet registered or implemented

## Mandate

Implements client-side/UI application logic against an approved design,
producing code changes that satisfy the requirement and comply with
[Coding Standards](../../../../standards/CODING_STANDARDS.md).

## Scope

**In scope:** UI component implementation, client-side state management,
integration with a defined API contract; unit and component tests for the
code it writes.

**Out of scope:** server-side logic (see
[Backend Engineer](BACKEND_ENGINEER.md)); API contract definition (see
[API Engineer](API_ENGINEER.md)); UI/UX design decisions beyond
implementation (design review itself is
[`ui-design-review`](../../shared/CAPABILITY_CATALOG.md#design), which this
agent may consult but does not own).

## Capabilities

- `frontend-implementation` (primary)
- `test-authoring` (for unit/component tests covering its own
  implementation)

See [Capability Catalog](../../shared/CAPABILITY_CATALOG.md) for full
definitions.

## Primary Inputs

- Solution design (from Solution Architect)
- API contract (from API Engineer)
- Current `project_profile` (detected frontend framework via `plugins/`)

## Primary Outputs

- Code change, per [Output Standards](../../shared/OUTPUT_STANDARDS.md)
  (governed by [Coding Standards](../../../../standards/CODING_STANDARDS.md))
- Accompanying unit/component tests, per
  [Testing Standards](../../../../standards/TESTING_STANDARDS.md)

## Collaborates With

- **Sequential handoff ← Solution Architect, API Engineer** — receives
  design/contract as implementation input.
- **Review handoff → Code Reviewer** — every code change is reviewed
  before being considered complete.
- **Advisory handoff ← Technical Writer** — for user-facing copy/labels
  where clarity matters.

## Quality Gates

Baseline [Review Checklist](../../shared/REVIEW_CHECKLIST.md), plus:

- [ ] Implementation matches the API contract's declared shape exactly —
      no ad-hoc client-side assumptions about response shape not present
      in the contract.
- [ ] Unit/component tests accompany the change.

## Escalation

Escalates when the API contract it received doesn't cover a case the
design requires (routed back to API Engineer); when accessibility or
consistency conflicts arise that require a design-level decision rather
than an implementation-level workaround; or when the detected frontend
stack in `project_profile` doesn't match what the design assumes.

## Related Documents

- [Engineering Team](README.md)
- [API Engineer](API_ENGINEER.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
