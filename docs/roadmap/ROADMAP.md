# Roadmap

## Purpose

Tracks AEF's planned progression sprint by sprint, and records the explicit
approval gate required before moving from specification to implementation.

## Scope

Covers sprint-level scope only. Task-level planning within an approved
sprint happens in the repository's issue tracker (introduced in Sprint 2).

## Sprint 1 — Foundation (complete)

**Delivered:** Repository structure and full documentation set — Master
Specification, Architecture Specification, Repository Structure Guide, and
the engineering standards suite. No agents, commands, hooks, or runtime
code.

**Tag:** `sprint-1-complete`

## Sprint 2 — Runtime Foundation (complete)

**Delivered:** New top-level directories `runtime/`, `plugins/`,
`config/`, `assets/`; `framework/` extended with `discovery/`
(renamed/broadened from `analyzer/`), `planning/` (new), and `memory/`
(promoted to a full component); full specifications for the Bootstrap,
Discovery, Planning, Orchestrator, Workflow, Memory Manager, and Quality
Gate Manager engines; Runtime and Plugin Architecture Specifications;
Configuration Specification with `enterprise`/`startup`/`ai-platform`/
`trading` profiles. No agents, commands, hooks, or implementation code.

**Tag:** `sprint-2-complete`

## Sprint 3 — Engineering Agent Framework (complete)

**Delivered:** Agent Framework Specification covering the agent contract,
lifecycle, capabilities, communication, registration/discovery,
versioning, logging/memory usage, and quality gates for agents (see
[Agent Framework Specification](../specifications/agents/AGENT_FRAMEWORK_SPEC.md)).
Five shared assets (Agent Contract, Capability Catalog, Communication
Rules, Output Standards, Review Checklist — see
[docs/specifications/agents/shared/](../specifications/agents/shared/))
that every individual agent specification references rather than
duplicates. Eight team charters and 24 individual agent specifications
across Architecture, Engineering, Security, Quality, Platform, AI,
Documentation, and Project teams (see
[docs/specifications/agents/teams/](../specifications/agents/teams/)).
[ADR 0002](../decisions/0002-agent-specifications-location.md) establishes
that specifications live in `docs/specifications/agents/`, not
`.claude/agents/`, keeping this sprint specification-only. No commands,
hooks, templates, or runtime logic.

**Tag:** `sprint-3-complete`

**Explicit exclusions for this sprint (per the Sprint 3 bootstrap's own
instruction):**
- No content in `.claude/agents/`, `.claude/commands/`, `.claude/hooks/`,
  `.claude/templates/` beyond placeholder READMEs
- No agent runtime logic — every agent is Specified, not Registered or
  Invoked, per the [Agent Framework Specification's lifecycle](../specifications/agents/AGENT_FRAMEWORK_SPEC.md#2-agent-lifecycle)
- No business logic or implementation code anywhere in the repository

## Sprint 4 — Automation Framework (complete)

**Delivered:** Automation Architecture tying commands, hooks, events, and
the workflow library to the engine and agent layers established in
Sprints 2–3 (see
[Automation Architecture](../specifications/automation/AUTOMATION_ARCHITECTURE.md)).
A Command Contract plus 12 individual command specifications (bootstrap,
analyze, plan, implement, review, test, secure, document, deploy,
release, doctor, update — see
[docs/specifications/automation/commands/](../specifications/automation/commands/)).
A Hook Framework covering all 12 lifecycle hooks, in six before/after
pairs (see
[Hook Framework](../specifications/automation/hooks/HOOK_FRAMEWORK.md)).
An Event Catalog covering hook-derived and state-change events, with
ordering and retry-strategy rules (see
[Event Catalog](../specifications/automation/events/EVENT_CATALOG.md)). A
Workflow Library with seven named workflows — New Project, New Feature,
Bug Fix, Refactoring, Security Review, Documentation, Release (see
[Workflow Library](../specifications/automation/workflows/WORKFLOW_LIBRARY.md)).
Automation Rules connecting all of the above via a fixed baseline rule
set (see
[Automation Rules](../specifications/automation/AUTOMATION_RULES.md)).
[ADR 0003](../decisions/0003-automation-specifications-location.md)
establishes that these specifications live in
`docs/specifications/automation/`, not `.claude/commands/` or
`.claude/hooks/`, keeping this sprint specification-only. No templates,
domain packs, or runtime code.

**Tag:** `sprint-4-complete`

**Explicit exclusions for this sprint (per the Sprint 4 bootstrap's own
instruction):**
- No content in `.claude/commands/` or `.claude/hooks/` beyond placeholder
  READMEs
- No templates or domain packs
- No runtime code — every command, hook, event, and workflow is a
  specification, not an implementation

## Sprint 5 — Agents, Commands, Hooks & Templates (requires approval)

**Planned deliverable:** `.claude/agents/`, `.claude/commands/`,
`.claude/hooks/`, and `.claude/templates/` content, built against the
Sprint 2 engine specifications, Sprint 3 agent specifications, and
Sprint 4 automation specifications all at once, since all three now exist
and are cross-referenced. First actual implementation code for the Core
Framework, Runtime Abstraction (Claude Code adapter), Discovery Engine,
and Planning Engine. First Decision Records for implementation language
and configuration schema format. Initial CI in `.github/`. First agents
move from Specified to Registered, per the
[Agent Framework Specification's lifecycle](../specifications/agents/AGENT_FRAMEWORK_SPEC.md#2-agent-lifecycle).

**Gate:** Sprint 5 does not begin automatically on Sprint 4 completion. It
requires explicit approval, consistent with the same discipline applied
before every prior sprint transition.

## Sprint 6 — Orchestration & Workflows (tentative)

**Planned deliverable:** Engineering Orchestrator, Workflow Engine, and
the seven [Workflow Library](../specifications/automation/workflows/WORKFLOW_LIBRARY.md)
entries made executable, wired to the first `.claude/commands/` entries
and invoking the first Registered agents from Sprint 5.

## Sprint 7 — Quality & Governance (tentative)

**Planned deliverable:** Quality Gate Manager and Governance Layer
implementation, including audit logging and approval-checkpoint
enforcement (see [Security Standards](../standards/SECURITY_STANDARDS.md)),
and the first automated evaluation of the
[Review Checklist](../specifications/agents/shared/REVIEW_CHECKLIST.md)
against agent output, plus the first implemented
[Automation Rules](../specifications/automation/AUTOMATION_RULES.md).

## Sprint 8 — Plugin Ecosystem (tentative)

**Planned deliverable:** Plugin Manager implementation, the first concrete
`plugins/` entries per category, and the first `domain-packs/` pack(s),
validated against [Plugin Standards](../standards/PLUGIN_STANDARDS.md) and
[Plugin Architecture Specification](../architecture/PLUGIN_ARCHITECTURE.md).

## Beyond Sprint 8

Additional Runtime Adapters beyond Claude Code (Codex CLI, Gemini CLI, per
[Runtime Architecture Specification](../architecture/RUNTIME_ARCHITECTURE.md#adding-a-new-runtime-eg-codex-cli-gemini-cli)),
expanded plugin/domain-pack library, additional agents beyond the initial
24, custom project-defined hooks and automation rules, and Memory Manager
backend options — scoped in more detail once Sprints 5–8 establish the
core.

## Related Documents

- [Master Specification](../specifications/MASTER_SPEC.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md)
