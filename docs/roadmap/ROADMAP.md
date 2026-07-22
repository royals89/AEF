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

## Sprint 2 — Runtime Foundation (current)

**Deliverable:** Architectural foundation for runtime execution — no
engineering agents, no business logic, no AI prompts, no implementation
code. Specifically:

- New top-level directories: `runtime/`, `plugins/`, `config/`, `assets/`.
- `framework/` extended with `discovery/` (renamed/broadened from
  `analyzer/`), `planning/` (new), and `memory/` (promoted to a full
  component) — see
  [ADR 0001](../decisions/0001-sprint-2-structural-evolution.md).
- Runtime adapters structured for Claude Code and a Shared Runtime layer,
  with documentation on adding future runtimes (Codex CLI, Gemini CLI,
  etc.) without changing the framework core — see
  [Runtime Architecture Specification](../architecture/RUNTIME_ARCHITECTURE.md).
- Full specifications (Purpose, Responsibilities, Inputs, Outputs,
  Interfaces, Lifecycle, Extension Points, Error Handling, Future
  Enhancements) for the Bootstrap Engine, Discovery Engine, Planning
  Engine, Engineering Orchestrator, Workflow Engine, Memory Manager, and
  Quality Gate Manager — see
  [docs/specifications/engines/](../specifications/engines/).
- A plugin architecture separating languages, frameworks, databases, cloud
  providers, AI providers, and security, config-driven and
  runtime-independent — see
  [Plugin Architecture Specification](../architecture/PLUGIN_ARCHITECTURE.md).
- A configuration model with `enterprise`, `startup`, `ai-platform`, and
  `trading` profiles, with no hardcoded profile behavior — see
  [Configuration Specification](../specifications/CONFIGURATION_SPEC.md).

**Status:** Complete — see the Sprint 2 Completion Report for the final
file inventory and risk assessment.

**Explicit exclusions for this sprint (unchanged from Sprint 1's
discipline):**
- No content in `.claude/agents/`, `.claude/commands/`, `.claude/hooks/`,
  `.claude/templates/` beyond placeholder READMEs
- No implementation in `framework/*`, `runtime/*`, or `plugins/*` beyond
  directory scaffolding and specifications
- No business logic or AI prompt content anywhere in the repository
- No CI in `.github/`
- No Domain Packs in `domain-packs/`

## Sprint 3 — Agents, Commands, Hooks & Templates (requires approval)

**Planned deliverable:** `.claude/agents/`, `.claude/commands/`,
`.claude/hooks/`, and `.claude/templates/` content, built against the
Sprint 2 specifications. First actual implementation code for the Core
Framework, Runtime Abstraction (Claude Code adapter), Discovery Engine, and
Planning Engine, per the specifications in
[docs/specifications/engines/](../specifications/engines/). First Decision
Records for implementation language and configuration schema format.
Initial CI in `.github/`.

**Gate:** Sprint 3 does not begin automatically on Sprint 2 completion. It
requires explicit approval, per the Sprint 2 bootstrap requirement to
"wait for Sprint 3 approval before implementing those components"
(agents, commands, hooks, templates), consistent with Sprint 1's original
requirement to wait before implementing any runtime components.

## Sprint 4 — Orchestration & Workflows (tentative)

**Planned deliverable:** Engineering Orchestrator, Workflow Engine, and the
first set of built-in workflow definitions (see
[Workflow Specification](../workflows/WORKFLOW_SPEC.md)), wired to the
first `.claude/commands/` entries from Sprint 3.

## Sprint 5 — Quality & Governance (tentative)

**Planned deliverable:** Quality Gate Manager and Governance Layer
implementation, including audit logging and approval-checkpoint
enforcement (see [Security Standards](../standards/SECURITY_STANDARDS.md)).

## Sprint 6 — Plugin Ecosystem (tentative)

**Planned deliverable:** Plugin Manager implementation, the first concrete
`plugins/` entries per category, and the first `domain-packs/` pack(s),
validated against [Plugin Standards](../standards/PLUGIN_STANDARDS.md) and
[Plugin Architecture Specification](../architecture/PLUGIN_ARCHITECTURE.md).

## Beyond Sprint 6

Additional Runtime Adapters beyond Claude Code (Codex CLI, Gemini CLI, per
[Runtime Architecture Specification](../architecture/RUNTIME_ARCHITECTURE.md#adding-a-new-runtime-eg-codex-cli-gemini-cli)),
expanded plugin/domain-pack library, and Memory Manager backend options —
scoped in more detail once Sprints 3–6 establish the core.

## Related Documents

- [Master Specification](../specifications/MASTER_SPEC.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md)
