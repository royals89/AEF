# Roadmap

## Purpose

Tracks AEF's planned progression sprint by sprint, and records the explicit
approval gate required before moving from specification to implementation.

## Scope

Covers sprint-level scope only. Task-level planning within an approved
sprint happens in the repository's issue tracker (introduced in Sprint 2).

## Sprint 1 — Foundation (current)

**Deliverable:** Repository structure and full documentation set —
Master Specification, Architecture Specification, Repository Structure
Guide, and the engineering standards suite. No agents, commands, hooks, or
runtime code.

**Status:** In progress — see the Sprint 1 Completion Report produced at
the end of this sprint for the final file inventory and risk assessment.

**Explicit exclusions for this sprint:**
- No content in `.claude/agents/`, `.claude/commands/`, `.claude/hooks/`
- No implementation in `framework/*` beyond directory scaffolding
- No CI in `.github/`
- No Domain Packs in `domain-packs/`

## Sprint 2 — Core Runtime (requires approval)

**Planned deliverable:** Implementation of the Core Framework
(`framework/core/`), Runtime Abstraction interface plus a Claude Code
adapter, and the Project Analyzer. First Decision Records (implementation
language, config schema format). Initial CI in `.github/`.

**Gate:** Sprint 2 does not begin automatically on Sprint 1 completion. It
requires explicit approval, per the Sprint 1 bootstrap requirement to "wait
for approval before implementing runtime components."

## Sprint 3 — Orchestration & Workflows (tentative)

**Planned deliverable:** Orchestrator, Workflow Engine, and the first set of
built-in workflow definitions (see
[Workflow Specification](../workflows/WORKFLOW_SPEC.md)). First `.claude/commands/`
entries wired to those workflows.

## Sprint 4 — Quality & Governance (tentative)

**Planned deliverable:** Quality Gates and Governance Layer implementation,
including audit logging and approval-checkpoint enforcement (see
[Security Standards](../standards/SECURITY_STANDARDS.md)).

## Sprint 5 — Plugin Ecosystem (tentative)

**Planned deliverable:** Plugin Manager implementation and the first Domain
Pack(s), validated against [Plugin Standards](../standards/PLUGIN_STANDARDS.md).

## Beyond Sprint 5

Additional runtime adapters beyond Claude Code, expanded Domain Pack
library, and Memory backend options — scoped in more detail once Sprints
2–5 establish the core.

## Related Documents

- [Master Specification](../specifications/MASTER_SPEC.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md)
