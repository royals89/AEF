# Agent Contract

## Purpose

Defines the single contract every AEF agent — regardless of team or
specialty — must satisfy. This is the shared shape referenced by all 24
individual agent specifications (see
[docs/specifications/agents/teams/](../teams/)) instead of each agent
redefining its own structure.

## Scope

Covers the fields and rules every agent specification must include. Does
not cover a specific agent's actual content for those fields — that is
each agent's own specification. Does not cover runtime execution of agents
— see [ADR 0002](../../../decisions/0002-agent-specifications-location.md)
for why this sprint is specification-only.

## Contract Fields

Every agent specification declares the following, in this order:

| Field | Description |
|---|---|
| **Agent ID** | Unique, kebab-case identifier (e.g., `backend-engineer`) |
| **Team** | Exactly one of the eight teams (see [Team Structure](../AGENT_FRAMEWORK_SPEC.md#teams)) |
| **Mandate** | One or two sentences: what this agent exists to do |
| **Scope** | Explicit in-scope and out-of-scope statements — an agent's boundaries are as important as its purpose |
| **Capabilities** | References to entries in the [Capability Catalog](CAPABILITY_CATALOG.md) — an agent never defines a capability inline; it cites one or more catalog entries |
| **Primary Inputs** | What the agent needs to act (e.g., a project profile, a specific artifact type) |
| **Primary Outputs** | What the agent produces, in terms consistent with [Output Standards](OUTPUT_STANDARDS.md) |
| **Collaborates With** | Other agents/teams it hands off to or receives from, following [Communication Rules](COMMUNICATION_RULES.md) |
| **Quality Gates** | Which checks from the [Review Checklist](REVIEW_CHECKLIST.md) apply to this agent's output, plus any agent-specific additions |
| **Escalation** | The conditions under which this agent stops and hands off to a human or to the Governance Layer, rather than proceeding autonomously |

## Rules

1. **No duplicated definitions.** An agent specification never restates
   what a capability, communication rule, output standard, or checklist
   item means — it references the shared asset by name/ID. If a shared
   asset doesn't yet cover something an agent needs, the shared asset is
   extended; the definition is not forked into the individual agent spec.
2. **Every agent has an Escalation clause.** No agent specification may
   omit this field, even if the answer is "escalates rarely" — silence on
   escalation is not permitted, because it is the single most
   safety-relevant field in the contract.
3. **Capabilities are cited, not invented per-agent.** If two agents
   appear to need "the same thing but slightly different," that is a
   signal the Capability Catalog entry needs parameterization, not that
   each agent should define its own variant (see
   [Capability Catalog](CAPABILITY_CATALOG.md#design-decisions)).
4. **An agent belongs to exactly one team.** Cross-team work happens via
   [Communication Rules](COMMUNICATION_RULES.md#cross-team-handoff), not
   by an agent claiming dual team membership.

## Design Decisions

- **Contract-first, not agent-first.** This document exists before any
  individual agent specification, and every agent specification is
  written by filling in this contract's fields — never the reverse. This
  mirrors "Configuration over Hardcoding" and "No Duplicate Logic" from
  the core [Architecture Principles](../../../architecture/ARCHITECTURE.md#architecture-principles),
  applied to agents instead of framework components.
- **The contract is deliberately thin.** It defines *what* every agent
  spec must say, not *how* agents are invoked or executed — that is
  runtime logic, out of scope for Sprint 3 (see
  [ADR 0002](../../../decisions/0002-agent-specifications-location.md)).

## Future Extension Points

- A machine-readable (schema) form of this contract, once agent
  specifications are implemented as loadable `.claude/agents/` definitions
  in a future sprint.
- Contract versioning, if the field set needs to change after agents exist
  that depend on the current shape (see
  [Versioning](../AGENT_FRAMEWORK_SPEC.md#versioning)).

## Related Documents

- [Agent Framework Specification](../AGENT_FRAMEWORK_SPEC.md)
- [Capability Catalog](CAPABILITY_CATALOG.md)
- [Communication Rules](COMMUNICATION_RULES.md)
- [Output Standards](OUTPUT_STANDARDS.md)
- [Review Checklist](REVIEW_CHECKLIST.md)
- [ADR 0002: Agent specifications location](../../../decisions/0002-agent-specifications-location.md)
