# Output Standards

## Purpose

Defines the shape and quality bar every agent's output must meet,
regardless of team or capability, so outputs are consistent, reviewable,
and consumable by both other agents and the Quality Gate Manager.

## Scope

Covers structural and quality requirements for agent output artifacts.
Does not cover the specific content of any one capability's output — see
each entry's "Typical output" in the
[Capability Catalog](CAPABILITY_CATALOG.md) — or how output moves between
agents, which is [Communication Rules](COMMUNICATION_RULES.md).

## Structural Requirements

Every agent output artifact includes:

1. **Provenance** — which agent produced it, against which Agent ID, and
   as part of which workflow invocation (traceable via the Memory
   Manager's workflow history — see
   [Memory Manager Specification](../../engines/MEMORY_MANAGER.md)).
2. **Scope statement** — what the output covers and, where relevant, what
   it explicitly does not (mirrors the Purpose/Scope pattern used
   throughout `docs/` — see
   [Documentation Standards](../../../standards/DOCUMENTATION_STANDARDS.md)).
3. **Confidence/completeness signal** — whether the agent considers the
   output final, partial, or blocked, so a downstream agent or human
   reviewer doesn't mistake a partial result for a complete one.
4. **Referenced inputs** — which Primary Inputs (per the
   [Agent Contract](AGENT_CONTRACT.md)) the output was derived from, so
   staleness is detectable if an input later changes.

## Quality Requirements

- **Verifiable, not just assertive.** Where an agent's output makes a
  claim (e.g., "this change is secure," "this design meets the
  requirement"), it states the basis for that claim rather than asserting
  it unsupported — consistent with the evidentiary standard already
  required of Quality Gate results (see
  [Quality Gate Manager Specification](../../engines/QUALITY_GATE_MANAGER.md#responsibilities)).
- **No fabricated specifics.** An agent output never invents details
  (file paths, API names, metrics) it did not actually derive from its
  inputs — this mirrors the Core Framework's "fail loud, fail typed"
  principle (see
  [Coding Standards](../../../standards/CODING_STANDARDS.md#design-decisions)):
  an agent that lacks the information to complete a field states that
  gap explicitly rather than filling it plausibly.
- **Consistent formatting per output type.** Code changes follow
  [Coding Standards](../../../standards/CODING_STANDARDS.md); documents
  follow [Documentation Standards](../../../standards/DOCUMENTATION_STANDARDS.md);
  test artifacts follow [Testing Standards](../../../standards/TESTING_STANDARDS.md).
  Output Standards does not redefine these — it requires that agent
  output comply with whichever already-defined standard applies to its
  type.

## Output Categories

| Category | Governing standard | Example |
|---|---|---|
| Code change | [Coding Standards](../../../standards/CODING_STANDARDS.md) | Backend Engineer's implementation |
| Document/report | [Documentation Standards](../../../standards/DOCUMENTATION_STANDARDS.md) | Solution Architect's design document |
| Test artifact | [Testing Standards](../../../standards/TESTING_STANDARDS.md) | QA Engineer's test suite |
| Review/verdict | [Review Checklist](REVIEW_CHECKLIST.md) | Code Reviewer's review comments |
| Audit/decision record | [Decision Log Template](../../../decisions/DECISION_LOG_TEMPLATE.md) | Governance-relevant agent decisions |

## Design Decisions

- **Provenance is mandatory, not optional metadata.** Given agents operate
  across an 8-team, 24-agent structure, untraceable output would make the
  [Communication Rules](COMMUNICATION_RULES.md#core-rule-agents-do-not-call-each-other-directly)
  handoff model unauditable in practice, even though it's sound in theory.
- **Reuse existing standards rather than defining parallel ones.** Output
  Standards is a routing document — it says which existing standard
  governs which output type — rather than a sixth, agent-specific set of
  formatting rules that could drift from the standards non-agent
  contributions already follow.

## Future Extension Points

- Machine-readable output schemas once agents are implemented (Sprint 4+),
  enabling automated provenance/completeness validation ahead of Quality
  Gate evaluation.
- Output diffing/versioning for iterative agent work on the same artifact.

## Related Documents

- [Agent Contract](AGENT_CONTRACT.md)
- [Capability Catalog](CAPABILITY_CATALOG.md)
- [Review Checklist](REVIEW_CHECKLIST.md)
- [Documentation Standards](../../../standards/DOCUMENTATION_STANDARDS.md)
- [Coding Standards](../../../standards/CODING_STANDARDS.md)
