# Plugin Architecture Specification

## Purpose

Defines the plugin system introduced in Sprint 2: a categorized, technical-
capability plugin taxonomy that is configuration-driven and independent of
any specific Runtime Adapter. Distinguishes this system (`plugins/`) from
the Sprint 1 `domain-packs/` industry-vertical taxonomy — see
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md).

## Scope

Covers plugin categories, the plugin contract, and how plugins are
discovered and invoked by the engines defined in
[docs/specifications/engines/](../specifications/engines/). Does not cover
`domain-packs/`, which remains specified separately (see
[Plugin Standards](../standards/PLUGIN_STANDARDS.md), which will be
extended when `domain-packs/` implementation begins in Sprint 5+).

## Plugin Categories

`plugins/` is organized into six fixed top-level categories:

| Category | Directory | Examples of future contents |
|---|---|---|
| Languages | `plugins/languages/` | Python, TypeScript, Go |
| Frameworks | `plugins/frameworks/` | Django, React, Spring |
| Databases | `plugins/databases/` | PostgreSQL, MongoDB, Redis |
| Cloud Providers | `plugins/cloud-providers/` | AWS, GCP, Azure |
| AI Providers | `plugins/ai-providers/` | Anthropic, OpenAI, local model runtimes |
| Security | `plugins/security/` | SAST/DAST tools, dependency scanners, secret scanners |

These six categories are fixed at the architecture level — a plugin always
belongs to exactly one — but the set of plugins *within* each category is
open-ended and grows independently of framework or runtime changes.

## Design Principle: Runtime-Independent, Configuration-Driven

Two rules govern every plugin, without exception:

1. **Runtime-independent.** A plugin's implementation contains no
   knowledge of which Runtime Adapter (see
   [Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md)) is
   active. Plugins are invoked identically by the Discovery Engine,
   Planning Engine, Workflow Engine, and Quality Gate Manager regardless of
   whether AEF is running under the Claude Code adapter or a future one.
2. **Configuration-driven.** Which plugins are active for a given project
   is determined by Discovery's detection plus the active `config/` profile
   (see [Configuration Specification](../specifications/CONFIGURATION_SPEC.md))
   — never hardcoded in a framework component. A plugin itself may expose
   configuration options (e.g., a language plugin's lint-rule strictness),
   but whether the plugin is active at all is a configuration decision, not
   a framework assumption.

## Plugin Manifest

Every plugin declares, at minimum:

- `name`, `category` (one of the six above), `version` (SemVer, per
  [Versioning Strategy](../standards/VERSIONING_STRATEGY.md)).
- `compatible_core_version` — the AEF core version range it works with.
- `detection_contract` — how the Discovery Engine identifies this plugin as
  relevant to a project (e.g., presence of a specific manifest file,
  config, or dependency).
- `capabilities` — which engine(s) this plugin supplies behavior to (e.g.,
  a language plugin typically supplies both a Discovery detector and a
  Quality Gate Manager test-runner implementation).
- `priority` — used to resolve ambiguity when multiple plugins could claim
  the same capability (see
  [Planning Engine Specification](../specifications/engines/PLANNING_ENGINE.md#error-handling)).

This extends, and remains consistent with, the manifest requirement already
defined in [Plugin Standards](../standards/PLUGIN_STANDARDS.md) for
`domain-packs/`; the two manifests share the same core fields
(`name`/`category-or-domain`/`version`/`compatible_core_version`) so
tooling that validates one can largely validate the other.

## How Plugins Are Used by Each Engine

| Engine | How it uses `plugins/` |
|---|---|
| Discovery Engine | Calls each candidate plugin's `detection_contract` to determine relevance to the target repository (see [Discovery Engine Specification](../specifications/engines/DISCOVERY_ENGINE.md)) |
| Planning Engine | Binds workflow steps to specific plugins based on Discovery's relevant-plugin set (see [Planning Engine Specification](../specifications/engines/PLANNING_ENGINE.md)) |
| Workflow Engine | Invokes the bound plugin(s) for each step at execution time (see [Workflow Engine Specification](../specifications/engines/WORKFLOW_ENGINE.md)) |
| Quality Gate Manager | Delegates gate evaluation to plugin-supplied implementations (e.g., a language plugin's test runner) (see [Quality Gate Manager Specification](../specifications/engines/QUALITY_GATE_MANAGER.md)) |

No engine hardcodes behavior for a specific plugin by name — all engine-to-
plugin interaction goes through the capability contracts declared in each
plugin's manifest.

## Design Decisions

- **Fixed categories, open plugin set.** Fixing the six categories at the
  architecture level (rather than letting categories themselves be
  arbitrary) keeps cross-cutting concerns like Configuration profiles able
  to reason about "which language, which cloud provider" predictably,
  while still allowing unlimited growth within each category.
- **One plugin, one category.** A plugin that seems to span categories
  (e.g., a framework tightly coupled to one cloud provider) should be
  split into two plugins with a declared dependency between them, not
  merged into one multi-category plugin — this keeps category membership
  meaningful for tooling and configuration.
- **Plugins vs. Domain Packs remain separate systems**, per
  [ADR 0001](../decisions/0001-sprint-2-structural-evolution.md): a Domain
  Pack composes `plugins/` entries plus domain-specific workflow/governance
  defaults; it does not replace or contain plugin implementation itself.

## Future Extension Points

- A seventh-plus category, if a genuinely new cross-cutting concern emerges
  that doesn't fit the current six (would require an ADR, not an
  informal addition).
- A plugin registry/discovery mechanism beyond the local `plugins/`
  directory, mirroring the future extension noted for `domain-packs/` in
  [Plugin Standards](../standards/PLUGIN_STANDARDS.md#future-extension-points).
- Formal contract-test suites per category (e.g., every Languages plugin
  must pass a shared Languages-category contract test).

## Related Documents

- [ADR 0001: Sprint 2 structural evolution](../decisions/0001-sprint-2-structural-evolution.md)
- [Plugin Standards](../standards/PLUGIN_STANDARDS.md)
- [Configuration Specification](../specifications/CONFIGURATION_SPEC.md)
- [Discovery Engine Specification](../specifications/engines/DISCOVERY_ENGINE.md)
- [Planning Engine Specification](../specifications/engines/PLANNING_ENGINE.md)
