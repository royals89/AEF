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
├── .github/          CI/CD workflows, issue/PR templates (Sprint 2+)
├── .claude/           Claude Code runtime integration surface
├── framework/          Core framework source code
├── docs/                All documentation — architecture, standards, specs
├── standards/            Machine-readable standards (schemas, lint configs)
├── templates/            Reusable project/document templates
├── domain-packs/         Domain-specific plugin packs (Sprint 3+)
├── examples/              Example projects demonstrating AEF usage
├── tests/                Test suites for framework/ code (Sprint 2+)
├── tools/                Developer tooling (not shipped as part of AEF itself)
└── scripts/               One-off and CI automation scripts
```

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
| `orchestrator/` | Orchestrator |
| `analyzer/` | Project Analyzer |
| `workflow/` | Workflow Engine |
| `bootstrap/` | Bootstrap/init engine |
| `quality/` | Quality Gates |
| `governance/` | Governance Layer |
| `shared/` | Cross-cutting utilities and the Plugin Manager |

Sprint 1 leaves these directories structurally present but empty of
implementation — see each directory's own placeholder README for its
Sprint 2 scope.

## `docs/`

All documentation, split by purpose:

| Subfolder | Contents |
|---|---|
| `architecture/` | This guide, the Architecture Specification |
| `standards/` | Engineering standards (coding, security, testing, etc.) |
| `workflows/` | Workflow Specification and individual workflow definitions |
| `specifications/` | Master Specification and other product-level specs |
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
2. Is it Claude-Code-specific runtime integration? → `.claude/<category>/`
3. Is it framework logic usable by any runtime? → `framework/<component>/`
4. Is it a domain/stack-specific extension? → `domain-packs/`
5. Is it dev tooling for AEF itself? → `tools/` or `scripts/`

If it doesn't clearly fit any of these, raise it as a Decision Record (see
[Decision Log Template](../decisions/DECISION_LOG_TEMPLATE.md)) rather than
guessing.

## Related Documents

- [Architecture Specification](ARCHITECTURE.md)
- [Coding Standards](../standards/CODING_STANDARDS.md)
- [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md)
