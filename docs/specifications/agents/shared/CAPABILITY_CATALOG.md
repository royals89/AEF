# Capability Catalog

## Purpose

The single, canonical list of capabilities an agent may claim. Every
agent's "Capabilities" field (per the [Agent Contract](AGENT_CONTRACT.md))
cites entries from this catalog rather than defining its own — this is
what makes 24 agent specifications composable instead of 24 independent
prose descriptions of similar things.

## Scope

Covers capability definitions and the catalog's structure. Does not cover
which agents hold which capabilities — that mapping lives in each agent's
own specification and, in aggregate, in the
[Agent Framework Specification's capability matrix](../AGENT_FRAMEWORK_SPEC.md#capability-matrix).

## Catalog Structure

Each capability entry declares:

- **ID** — stable, kebab-case, referenced by agent specs (e.g., `code-review`)
- **Category** — one of: Analysis, Design, Implementation, Verification,
  Communication, Governance
- **Definition** — what the capability means, precisely enough that two
  different agents citing it are claiming the same thing
- **Typical output** — the general shape of what exercising this
  capability produces, consistent with [Output Standards](OUTPUT_STANDARDS.md)

## Catalog

### Analysis

| ID | Definition | Typical output |
|---|---|---|
| `requirements-analysis` | Interpreting a request or business need into structured, testable requirements | Requirements document or backlog item |
| `technical-analysis` | Assessing existing code, architecture, or infrastructure against a specific question (feasibility, risk, impact) | Analysis memo referencing the relevant `project_profile` fields |
| `threat-modeling` | Identifying potential attack vectors and their likelihood/impact for a system or change | Threat model artifact |
| `performance-analysis` | Identifying bottlenecks or capacity risks from metrics, load characteristics, or design | Performance findings report |
| `data-modeling` | Designing or evaluating a data schema for correctness, normalization, and access-pattern fit | Schema design or schema review |

### Design

| ID | Definition | Typical output |
|---|---|---|
| `solution-design` | Producing an end-to-end technical approach for a requirement, spanning multiple components | Design document |
| `system-architecture-design` | Producing or evaluating architecture at the level of components, boundaries, and integration points | Architecture diagram plus rationale |
| `api-design` | Defining or reviewing an API's contract (interface, versioning, error semantics) | API specification |
| `ui-design-review` | Evaluating a user-facing interface against usability and consistency expectations | Design review notes |
| `infrastructure-design` | Designing or evaluating deployment topology, scaling strategy, or cloud resource layout | Infrastructure design document |

### Implementation

| ID | Definition | Typical output |
|---|---|---|
| `backend-implementation` | Writing or modifying server-side application code | Code change |
| `frontend-implementation` | Writing or modifying client-side/UI application code | Code change |
| `database-implementation` | Writing or modifying schema migrations, queries, or data-access code | Code change |
| `infrastructure-as-code` | Writing or modifying declarative infrastructure configuration | Code change |
| `prompt-authoring` | Writing or modifying prompts, agent instructions, or model-facing configuration | Prompt/config change |
| `integration-implementation` | Wiring together external services, APIs, or protocols (including MCP) | Code/config change |

### Verification

| ID | Definition | Typical output |
|---|---|---|
| `code-review` | Evaluating a code change against [Coding Standards](../../../standards/CODING_STANDARDS.md) and correctness | Review comments plus verdict |
| `test-authoring` | Writing automated tests per [Testing Standards](../../../standards/TESTING_STANDARDS.md) | Test code |
| `test-execution` | Running tests and interpreting results | Test report |
| `security-testing` | Actively probing a system for exploitable weaknesses (e.g., penetration testing) | Findings report with severity ratings |
| `compliance-verification` | Checking a system or process against a named regulatory or policy standard | Compliance findings report |
| `performance-testing` | Executing load/stress/soak tests and interpreting results against defined thresholds | Performance test report |

### Communication

| ID | Definition | Typical output |
|---|---|---|
| `technical-writing` | Producing clear, accurate documentation for a technical audience | Documentation artifact |
| `api-documentation` | Producing reference documentation for an API surface | API reference document |
| `stakeholder-communication` | Translating technical status/risk into terms appropriate for non-technical stakeholders | Status update or summary |
| `requirements-elicitation` | Drawing out and clarifying needs directly from a requester or stakeholder | Clarified requirements |
| `facilitation` | Running a structured process (e.g., a planning or retrospective session) that produces a decision or plan | Meeting/session output artifact |

### Governance

| ID | Definition | Typical output |
|---|---|---|
| `risk-assessment` | Identifying and rating risk associated with a proposed change | Risk assessment artifact |
| `policy-enforcement` | Checking a proposed action against defined organizational policy before it proceeds | Pass/fail/escalate determination |
| `audit-logging` | Producing a structured record of a decision or action for the audit trail | Audit record (via Memory Manager) |
| `backlog-prioritization` | Ordering work items against defined criteria (value, risk, dependency) | Prioritized backlog |
| `progress-tracking` | Monitoring and reporting status of in-flight work against a plan | Status/progress report |

## Design Decisions

- **Capabilities are parameterized by context, not forked per agent.**
  E.g., `code-review` means the same thing whether the Backend Engineer or
  the Code Reviewer cites it; what differs is *which* code each agent
  reviews and in what workflow position, which belongs in the agent's own
  specification, not in a second, near-duplicate catalog entry.
- **A capability's "typical output" is a shape, not a template.** Full
  formatting rules live in [Output Standards](OUTPUT_STANDARDS.md); this
  catalog only says what kind of thing comes out.
- **Six categories, not a flat list.** Mirrors the fixed-category approach
  already used for `plugins/` (see
  [Plugin Architecture Specification](../../../architecture/PLUGIN_ARCHITECTURE.md)),
  for the same reason: predictable categorization supports tooling and
  cross-agent reasoning (e.g., "which agents hold any Verification
  capability") without constraining what's inside each category.

## Future Extension Points

- Capability versioning if a definition needs to change after agents
  depend on the current wording.
- A machine-readable form of this catalog for validation tooling once
  agent specifications are implemented (Sprint 4+).
- Capability-to-Quality-Gate mapping (e.g., every agent claiming
  `backend-implementation` automatically inherits certain
  [Quality Gate Manager](../../engines/QUALITY_GATE_MANAGER.md) checks) —
  noted here as a design question for whoever implements the Quality Gate
  Manager against agent output.

## Related Documents

- [Agent Contract](AGENT_CONTRACT.md)
- [Output Standards](OUTPUT_STANDARDS.md)
- [Agent Framework Specification](../AGENT_FRAMEWORK_SPEC.md)
- [Plugin Architecture Specification](../../../architecture/PLUGIN_ARCHITECTURE.md)
