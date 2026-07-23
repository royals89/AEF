# Agent Framework Specification

## Purpose

Defines AEF's Engineering Agent Framework: the standard contract every
agent satisfies, the agent lifecycle, how capabilities, communication,
registration/discovery, versioning, logging/memory, and quality gates work
for agents specifically, and the team structure organizing all 24 agents
specified this sprint. This document is the anchor for
`docs/specifications/agents/` in the same way the
[Master Specification](../MASTER_SPEC.md) anchors the whole repository and
the [Architecture Specification](../../architecture/ARCHITECTURE.md)
anchors the engine layer.

## Scope

Covers the agent framework's architecture and rules. Does not cover any
individual agent's specific content — see
[docs/specifications/agents/teams/](teams/) — or the five shared assets'
own detail, which each have their own specification under
[docs/specifications/agents/shared/](shared/) and are only summarized here.
Does not cover runtime implementation (agent definitions loadable by
Claude Code) — see
[ADR 0002](../../decisions/0002-agent-specifications-location.md) for why
this sprint is specification-only.

## Relationship to the Engine Layer

Agents are a layer above the engines specified in Sprint 2
(`docs/specifications/engines/`), not a replacement for them. An agent
does not call the Engineering Orchestrator, Discovery Engine, or any other
engine directly — an agent is *invoked as a plan step* by the Workflow
Engine, exactly as any other step is (see
[Workflow Engine Specification](../engines/WORKFLOW_ENGINE.md)). This
keeps the star-topology guarantee already established for engines (see
[Architecture Specification](../../architecture/ARCHITECTURE.md#orchestrator))
intact when agents are layered on top: the Orchestrator still coordinates
everything; agents are a new *kind* of step implementation, conceptually
adjacent to a `plugins/` entry (see
[Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md))
rather than a new coordinating authority.

## 1. Agent Contract

Every agent satisfies the same contract — Agent ID, Team, Mandate, Scope,
Capabilities, Primary Inputs, Primary Outputs, Collaborates With, Quality
Gates, Escalation — defined in full in
[Agent Contract](shared/AGENT_CONTRACT.md). No agent specification may
omit or redefine a contract field; each individual agent specification
under [teams/](teams/) is that contract filled in for one specific role.

## 2. Agent Lifecycle

An agent's lifecycle, from the framework's perspective, has four phases:

| Phase | Description |
|---|---|
| **Specified** | The agent has a complete specification satisfying the [Agent Contract](shared/AGENT_CONTRACT.md), but no runtime implementation. This is where all 24 agents in this repository stand as of Sprint 3. |
| **Registered** | The agent's specification has been converted into a loadable definition and recorded in the agent registry (see [Registration and Discovery](#5-registration-and-discovery)) — a Sprint 4+ concern. |
| **Invoked** | The agent is executing as a Workflow Engine step within a specific workflow invocation, per [Workflow Engine Specification](../engines/WORKFLOW_ENGINE.md). |
| **Retired** | The agent is deregistered; its specification remains in `docs/` for historical/audit reference (per [Memory Manager](../engines/MEMORY_MANAGER.md) workflow history), but it can no longer be invoked. |

Sprint 3 populates only the **Specified** phase. Registered, Invoked, and
Retired are defined here so later sprints implement against a lifecycle
that was designed up front, not one improvised at implementation time —
consistent with "Architecture First" (see
[Architecture Principles](../../architecture/ARCHITECTURE.md#architecture-principles)).

## 3. Agent Capabilities

Capabilities are defined once, centrally, in the
[Capability Catalog](shared/CAPABILITY_CATALOG.md), across six categories
(Analysis, Design, Implementation, Verification, Communication,
Governance). Every agent specification cites catalog entries rather than
defining capabilities inline — see
[Capability Catalog](shared/CAPABILITY_CATALOG.md#design-decisions) for
why this is enforced rather than merely suggested. The full mapping of
which agents hold which capabilities is the
[Capability Matrix](#capability-matrix) below.

## 4. Agent Communication

Agents never call each other directly — every handoff is mediated by the
Workflow Engine as a plan step boundary, per
[Communication Rules](shared/COMMUNICATION_RULES.md#core-rule-agents-do-not-call-each-other-directly).
Four handoff types are defined: Sequential, Review, Escalation, and
Advisory (see
[Communication Rules](shared/COMMUNICATION_RULES.md#handoff-types)).

## 5. Registration and Discovery

**Registration** is the act of making an agent's specification available
for the Planning Engine to bind workflow steps to (mirroring how a
`plugins/` entry becomes available for binding — see
[Planning Engine Specification](../engines/PLANNING_ENGINE.md#responsibilities)).
A registered agent declares, at minimum, the same identifying fields as a
plugin manifest for consistency: `agent_id`, `team`, `version`, and
`capabilities` (the catalog IDs it claims).

**Discovery** is how the Planning Engine finds the right agent for a
workflow step: it queries the agent registry by required capability (from
the [Capability Catalog](shared/CAPABILITY_CATALOG.md)), narrows by team
if the workflow specifies one, and resolves ties by the same
`priority`-declaration mechanism already used for plugin ambiguity (see
[Planning Engine Specification](../engines/PLANNING_ENGINE.md#error-handling)).
No engine hardcodes a reference to a specific agent by name — discovery is
always capability-driven, consistent with "Configuration over Hardcoding."

Registration and Discovery mechanics (the registry's storage, update, and
query implementation) are a Sprint 4+ implementation concern; this section
defines the contract they must satisfy.

## 6. Versioning

Agents version independently, using SemVer, following the same scheme
already defined for the framework and for Domain Packs (see
[Versioning Strategy](../../standards/VERSIONING_STRATEGY.md)):

- **MAJOR** — a change to the agent's Mandate, Scope, or Capabilities set
  that would break an existing workflow relying on it.
- **MINOR** — a backward-compatible expansion (e.g., an added capability
  that doesn't change existing behavior).
- **PATCH** — a backward-compatible refinement (e.g., a clarified
  Escalation condition that doesn't change what triggers it).

An agent also declares `compatible_core_version`, mirroring the plugin
manifest requirement (see
[Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md#plugin-manifest)),
so the registry can reject an agent incompatible with the running AEF
core.

## 7. Logging and Memory Usage

Every agent invocation is recorded via the Memory Manager's workflow
history (see
[Memory Manager Specification](../engines/MEMORY_MANAGER.md)), following
the same single-write-path rule already established: an agent does not
write to Memory directly; the Orchestrator does so on its behalf, exactly
as for any other Workflow Engine step (see
[Architecture Specification](../../architecture/ARCHITECTURE.md#memory-manager)).

What gets logged per invocation:

- Agent ID and version invoked.
- The workflow and step it was invoked within.
- Its declared Primary Inputs, as actually received (for the
  [Output Standards](shared/OUTPUT_STANDARDS.md#structural-requirements)
  provenance requirement).
- Its output artifact reference and completeness signal.
- Any escalation triggered, per
  [Communication Rules](shared/COMMUNICATION_RULES.md#communication-content-rules)
  ("escalations are never silent").

This log is what makes the [Review Checklist](shared/REVIEW_CHECKLIST.md)'s
provenance and escalation-honored items verifiable after the fact, not
just at invocation time.

## 8. Quality Gates for Agents

Every agent's output is checked against the
[Review Checklist](shared/REVIEW_CHECKLIST.md) baseline, plus any
agent-specific additions declared in that agent's own specification (see
[Review Checklist: Agent-Specific Additions](shared/REVIEW_CHECKLIST.md#agent-specific-additions)).
Mechanically, this is evaluated by the
[Quality Gate Manager](../engines/QUALITY_GATE_MANAGER.md) at the Workflow
Engine step boundary the agent occupies — agent output is not exempt from
or parallel to the Quality Gate system already defined in Sprint 2; it is
subject to it.

## Teams

Eight teams organize the 24 agents specified this sprint:

| Team | Directory | Agents |
|---|---|---|
| Architecture | [teams/architecture/](teams/architecture/) | Solution Architect, Enterprise Architect |
| Engineering | [teams/engineering/](teams/engineering/) | Backend Engineer, Frontend Engineer, Full Stack Engineer, API Engineer, Database Engineer |
| Security | [teams/security/](teams/security/) | Security Engineer, Penetration Tester, Compliance Engineer |
| Quality | [teams/quality/](teams/quality/) | QA Engineer, Performance Engineer, Code Reviewer |
| Platform | [teams/platform/](teams/platform/) | DevOps Engineer, Cloud Engineer, Platform Engineer |
| AI | [teams/ai/](teams/ai/) | AI Engineer, Prompt Engineer, MCP Engineer |
| Documentation | [teams/documentation/](teams/documentation/) | Technical Writer, API Documentation Engineer |
| Project | [teams/project/](teams/project/) | Project Manager, Scrum Master, Business Analyst |

Each team directory has its own README defining the team's charter and how
its member agents typically collaborate internally, plus one specification
file per agent.

## Capability Matrix

High-level view of which team each capability category is most associated
with (full per-agent capability citations are in each agent's own
specification; this matrix is a navigation aid, not a substitute):

| Capability Category | Primarily associated teams |
|---|---|
| Analysis | Architecture, Security, Quality, Project |
| Design | Architecture, Engineering, Platform |
| Implementation | Engineering, Platform, AI |
| Verification | Quality, Security |
| Communication | Documentation, Project |
| Governance | Security, Project |

No capability is exclusive to a team — e.g., `technical-analysis` may be
cited by an Engineering agent as readily as an Architecture agent — this
matrix shows typical concentration, not a restriction.

## Design Decisions

- **Agents are a step-implementation layer, not a new coordination
  authority.** This preserves every architectural guarantee already
  established in Sprint 1–2 (star-topology Orchestrator, capability-driven
  discovery, single-write-path Memory) rather than introducing a parallel
  set of rules specific to agents.
- **The five shared assets are specified independently** (see
  [docs/specifications/agents/shared/](shared/)) rather than folded into
  this document, because they are referenced individually and often — a
  single combined document would make citation from 24 agent
  specifications unwieldy.
- **Eight fixed teams**, mirroring the fixed-category pattern already
  established for plugins and capabilities — predictable team structure
  supports the Discovery/Registration narrowing described in
  [Registration and Discovery](#5-registration-and-discovery) above.

## Future Extension Points

- Agent-to-agent capability composition (an agent that itself orchestrates
  a small internal sequence of capabilities) — deferred, since it risks
  reintroducing the mesh topology the Orchestrator's star design exists to
  prevent, unless carefully scoped.
- Formal agent contract-test suite, mirroring the Domain Pack and Runtime
  Adapter contract-test approaches (see
  [Plugin Standards](../../standards/PLUGIN_STANDARDS.md) and
  [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md#future-extension-points)).
- Dynamic team membership or multi-team agents, if a real use case
  emerges that the current one-agent-one-team rule doesn't serve.

## Related Documents

- [ADR 0002: Agent specifications location](../../decisions/0002-agent-specifications-location.md)
- [Agent Contract](shared/AGENT_CONTRACT.md)
- [Capability Catalog](shared/CAPABILITY_CATALOG.md)
- [Communication Rules](shared/COMMUNICATION_RULES.md)
- [Output Standards](shared/OUTPUT_STANDARDS.md)
- [Review Checklist](shared/REVIEW_CHECKLIST.md)
- [Engineering Orchestrator Specification](../engines/ENGINEERING_ORCHESTRATOR.md)
- [Workflow Engine Specification](../engines/WORKFLOW_ENGINE.md)
- [Planning Engine Specification](../engines/PLANNING_ENGINE.md)
- [Roadmap](../../roadmap/ROADMAP.md)
