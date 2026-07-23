# Repository Structure Guide

## Purpose

Explains what belongs in every top-level directory of this repository, so
contributors (human or AI) place new files correctly and consistently.

## Scope

Covers directory-level responsibilities only. File-level naming rules are in
[Coding Standards](../standards/CODING_STANDARDS.md) and
[Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md).

## Top-Level Layout

```
AEF/
├── .github/          CI/CD workflows, issue/PR templates (Sprint 2+, not yet populated)
├── .claude/           Claude Code runtime integration surface
├── runtime/            Runtime Adapters (Sprint 2) — one dir per AI coding runtime, plus shared/
├── framework/          Core framework source code
├── plugins/             Technical-capability plugins (Sprint 2) — languages, frameworks, databases, cloud-providers, ai-providers, security
├── config/              Configuration model and profiles (Sprint 2) — enterprise, startup, ai-platform, trading
├── assets/               Static assets (logos, diagrams source files, etc.)
├── docs/                All documentation — architecture, standards, specs
├── standards/            Machine-readable standards (schemas, lint configs)
├── templates/            Reusable project/document templates
├── domain-packs/         Industry/domain-vertical plugin packs (Sprint 5+)
├── examples/              Example projects demonstrating AEF usage
├── tests/                Test suites for framework/ code (Sprint 2+)
├── tools/                Developer tooling (not shipped as part of AEF itself)
└── scripts/               One-off and CI automation scripts
```

`plugins/` vs. `domain-packs/`: see
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md) and
[Plugin Architecture Specification](PLUGIN_ARCHITECTURE.md) for the
distinction between technical-capability plugins and industry-vertical
domain packs.

## `.github/`

Repository-level automation: CI workflows, issue templates, PR templates,
CODEOWNERS. Introduced in Sprint 2 once there is code to run CI against.

## `.claude/`

The Claude Code runtime's integration surface — the concrete implementation
of the Runtime Abstraction interface (see
[Architecture Specification](ARCHITECTURE.md#runtime-abstraction)) for
Claude Code specifically.

| Subfolder | Contents |
|---|---|
| `agents/` | Agent definitions (Sprint 2+) |
| `commands/` | Slash-command definitions that invoke AEF workflows (Sprint 2+) |
| `hooks/` | Lifecycle hooks into Claude Code events (Sprint 2+) |
| `skills/` | Skill packages consumed by Claude Code (Sprint 2+) |
| `memory/` | Claude Code's concrete Memory store (Sprint 2+) |
| `templates/` | Prompt/config templates used when generating agents, commands, etc. |

Nothing in `.claude/` should contain framework logic that isn't
Claude-Code-specific — general logic belongs in `framework/`, so it remains
usable by future runtime adapters.

## `framework/`

The framework's own source code, organized by the components defined in the
[Architecture Specification](ARCHITECTURE.md#components):

| Subfolder | Component |
|---|---|
| `core/` | Core Framework (kernel, config, lifecycle, runtime abstraction interface) |
| `orchestrator/` | Engineering Orchestrator |
| `discovery/` | Discovery Engine (renamed/broadened from Sprint 1's `analyzer/` — see [ADR 0001](../decisions/0001-sprint-2-structural-evolution.md)) |
| `planning/` | Planning Engine (new in Sprint 2) |
| `workflow/` | Workflow Engine |
| `bootstrap/` | Bootstrap Engine |
| `quality/` | Quality Gate Manager |
| `governance/` | Governance Layer |
| `memory/` | Memory Manager (promoted to a full component in Sprint 2 — see [ADR 0001](../decisions/0001-sprint-2-structural-evolution.md)) |
| `shared/` | Cross-cutting utilities and the Plugin Manager |

These directories remain structurally present but empty of implementation
as of Sprint 2 — see each directory's own placeholder README, and the
corresponding specification under
[docs/specifications/engines/](../specifications/engines/), for scope.

## `runtime/`

Runtime Adapters — the concrete implementation of the Runtime Abstraction
interface per AI coding runtime. New in Sprint 2. See
[Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md) for the full
adapter contract and how to add a new runtime.

| Subfolder | Contents |
|---|---|
| `claude-code/` | Claude Code Runtime Adapter (Sprint 2 reference implementation) |
| `shared/` | Adapter-contract types and utilities common to all adapters |

## `plugins/`

Technical-capability plugins, organized into six fixed categories. New in
Sprint 2. See
[Plugin Architecture Specification](PLUGIN_ARCHITECTURE.md) for the full
plugin contract and how these differ from `domain-packs/`.

| Subfolder | Category |
|---|---|
| `languages/` | Language-specific detection, tooling, test-runner integration |
| `frameworks/` | Framework-specific detection and tooling |
| `databases/` | Database-specific detection and tooling |
| `cloud-providers/` | Cloud-provider-specific detection and tooling |
| `ai-providers/` | AI-provider-specific integration |
| `security/` | Security scanning and posture tooling |

## `config/`

The configuration model and named profiles. New in Sprint 2. See
[Configuration Specification](../specifications/CONFIGURATION_SPEC.md) for
the full model, precedence rules, and why profile behavior is never
hardcoded.

| Subfolder | Contents |
|---|---|
| `schema/` | Schema definitions for every configuration surface |
| `profiles/enterprise/` | `enterprise` profile configuration values |
| `profiles/startup/` | `startup` profile configuration values |
| `profiles/ai-platform/` | `ai-platform` profile configuration values |
| `profiles/trading/` | `trading` profile configuration values |

## `assets/`

Static assets used by AEF's own documentation or tooling (e.g., diagram
source files, logos). Not part of the runtime product surface.

## `docs/`

All documentation, split by purpose:

| Subfolder | Contents |
|---|---|
| `architecture/` | This guide, the Architecture Specification |
| `standards/` | Engineering standards (coding, security, testing, etc.) |
| `workflows/` | Workflow Specification and individual workflow definitions |
| `specifications/` | Master Specification, Configuration Specification, `engines/` (one specification per engine), and `agents/` (Agent Framework Specification, shared agent assets, and per-team agent specifications — see [ADR 0002](../decisions/0002-agent-specifications-location.md)) |
| `roadmap/` | Roadmap and sprint plans |
| `decisions/` | Architecture Decision Records (ADRs) |

## `standards/`

Machine-readable counterparts to `docs/standards/` — lint configs, JSON
Schemas for configuration files, and similar artifacts that tooling reads
directly. Human-readable rationale for these lives in `docs/standards/`;
`standards/` should contain no prose.

## `templates/`

Reusable templates for things AEF generates repeatedly — new project
scaffolds, document templates, config templates — that are not specific to
the Claude Code runtime (compare with `.claude/templates/`, which is).

## `domain-packs/`

Self-contained Domain Pack plugins (see
[Architecture Specification](ARCHITECTURE.md#plugin-manager--domain-packs)).
Empty until Sprint 3; each pack, once added, is a subdirectory with its own
manifest and README.

## `examples/`

Worked examples showing AEF applied to a sample project. Examples are
documentation, not test fixtures — they should be kept minimal and
well-commented rather than exhaustive.

## `tests/`

Test suites for code under `framework/`. Structure mirrors `framework/`'s
subfolders. Introduced in Sprint 2 alongside the first implementation code.

## `tools/`

Developer-facing tooling for working on AEF itself (e.g., doc-linting
scripts, repo-structure validators). Not part of the AEF product surface.

## `scripts/`

One-off and CI automation scripts. Anything reused more than a couple of
times should graduate from `scripts/` into `tools/` with proper documentation.

## Placement Rule of Thumb

When unsure where a new file belongs, ask in this order:

1. Is it documentation? → `docs/<category>/`
2. Is it Claude-Code-specific runtime integration (agents/commands/hooks/
   skills, Sprint 3+)? → `.claude/<category>/`
3. Is it a Runtime Adapter for a specific AI coding runtime, or logic
   shared across adapters? → `runtime/<runtime-name>/` or `runtime/shared/`
4. Is it framework logic usable by any runtime? → `framework/<component>/`
5. Is it a technical-capability plugin (language, framework, database,
   cloud provider, AI provider, security)? → `plugins/<category>/`
6. Is it an industry/domain-vertical extension composing multiple
   plugins? → `domain-packs/`
7. Is it configuration (schema or profile values)? → `config/schema/` or
   `config/profiles/<name>/`
8. Is it dev tooling for AEF itself? → `tools/` or `scripts/`

If it doesn't clearly fit any of these, raise it as a Decision Record (see
[Decision Log Template](../decisions/DECISION_LOG_TEMPLATE.md)) rather than
guessing.

## Related Documents

- [Architecture Specification](ARCHITECTURE.md)
- [Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md)
- [Plugin Architecture Specification](PLUGIN_ARCHITECTURE.md)
- [Configuration Specification](../specifications/CONFIGURATION_SPEC.md)
- [Coding Standards](../standards/CODING_STANDARDS.md)
- [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md)
