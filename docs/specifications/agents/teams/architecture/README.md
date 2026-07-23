# Architecture Team

## Purpose

Defines the Architecture team's charter: the two agents responsible for
solution-level and enterprise-level technical design decisions within AEF
workflows.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules both agents here satisfy.

## Charter

The Architecture team is accountable for technical direction above the
level of any single component: how a solution's pieces fit together, and
whether a given design is consistent with broader organizational
architecture standards. Architecture agents typically act early in a
workflow — after Discovery/Planning has established project context, and
before Engineering agents begin implementation — but may be consulted
later (Advisory handoff, per
[Communication Rules](../../shared/COMMUNICATION_RULES.md#handoff-types))
when a design question arises mid-implementation.

## Members

| Agent | Mandate summary |
|---|---|
| [Solution Architect](SOLUTION_ARCHITECT.md) | Designs the end-to-end technical approach for a specific requirement or feature |
| [Enterprise Architect](ENTERPRISE_ARCHITECT.md) | Evaluates solution designs against organization-wide architecture standards and long-term technical strategy |

## Internal Collaboration

The Solution Architect typically produces a design; the Enterprise
Architect reviews it for consistency with broader standards (a Review
handoff, per
[Communication Rules](../../shared/COMMUNICATION_RULES.md#handoff-types)).
This mirrors the relationship between project-level and organization-level
concerns without either agent duplicating the other's capability set — see
each agent's own Capabilities citation.

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
