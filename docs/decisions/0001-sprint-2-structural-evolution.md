# 0001. Sprint 2 structural evolution: discovery, planning, memory, plugins, config

**Status:** Accepted
**Date:** 2026-07-22
**Owner:** Principal Software Architect (Sprint 2 bootstrap)

## Context

The Sprint 2 bootstrap prompt requires `framework/` to include `discovery/`,
`planning/`, and `memory/` as first-class components, alongside a new
top-level `runtime/`, `plugins/`, `config/`, and `assets/`. Sprint 1's
`framework/analyzer/` and the Sprint 1 Architecture Specification's
description of Memory as a storage location rather than a component both
needed reconciling against this. Sprint 1 also established `domain-packs/`
at the repo root for pluggable domain-specific behavior, which now sits
alongside a differently-scoped `plugins/` directory requested in Sprint 2.

## Decision

1. **`framework/analyzer/` is renamed to `framework/discovery/`.** The
   Discovery Engine specified in Sprint 2 is a broadened version of the
   Sprint 1 Project Analyzer: it still profiles a target repository's stack
   and conventions, but is now also responsible for discovering environment
   and deployment context (runtime target, available infra, configured
   profile — see [Configuration Specification](../specifications/CONFIGURATION_SPEC.md)).
   This is a rename-and-extend, not a new parallel component. The
   [Architecture Specification](../architecture/ARCHITECTURE.md) is updated
   accordingly; no component named "Project Analyzer" remains.

2. **`framework/planning/` is a new component**, sitting between Discovery
   and Orchestrator. In Sprint 1, workflow selection and sequencing was
   folded into the Orchestrator's and Workflow Engine's responsibilities.
   Sprint 2 splits planning out explicitly: the Planning Engine turns a
   Discovery output plus a workflow request into a concrete execution plan,
   which the Orchestrator then executes via the Workflow Engine. This keeps
   "decide what to do" (Planning) separate from "make it happen"
   (Orchestrator/Workflow Engine), consistent with the Single Responsibility
   principle already in force (see
   [Architecture Specification](../architecture/ARCHITECTURE.md#architecture-principles)).

3. **`framework/memory/` is promoted from an interface-only concern to a
   full framework component.** Sprint 1 described Memory as a runtime-agnostic
   interface defined in `framework/core/` with `.claude/memory/` as the
   Claude Code runtime's concrete store. Sprint 2 makes the Memory Manager a
   named component with its own specification
   (see [Memory Manager Specification](../specifications/engines/MEMORY_MANAGER.md)),
   because Sprint 2 introduces multiple runtime adapters (`runtime/claude-code/`,
   `runtime/shared/`) and the memory contract needs to be defined once, in
   `framework/memory/`, and implemented per runtime rather than assumed to
   live inside `framework/core/`.

4. **`framework/governance/` is retained but untouched this sprint.** It was
   not named in the Sprint 2 bootstrap's list of framework subfolders, and
   Sprint 2's objectives explicitly exclude business logic and agent
   behavior. Governance's policy/approval/audit responsibilities (see
   [Architecture Specification](../architecture/ARCHITECTURE.md#governance-layer))
   remain scoped for a later sprint per the [Roadmap](../roadmap/ROADMAP.md).
   `framework/core/` is likewise retained as the kernel underlying every
   other component — it was not named for removal, and every new component
   still depends on its configuration/lifecycle/extension-point contracts.

5. **`plugins/` and `domain-packs/` are distinct, not duplicates.**
   `plugins/` (new in Sprint 2) is a *technical capability* taxonomy —
   languages, frameworks, databases, cloud providers, AI providers, security
   — that any project profile can compose from, regardless of industry.
   `domain-packs/` (Sprint 1, still empty, still planned for Sprint 5+)
   is an *industry/domain vertical* taxonomy — e.g., a "network
   infrastructure" or "regulated fintech" pack — that itself composes
   `plugins/` entries plus domain-specific workflow and governance defaults.
   In short: `plugins/` answers "what technical capability," `domain-packs/`
   answers "for what kind of organization or industry." See
   [Plugin Architecture Specification](../architecture/PLUGIN_ARCHITECTURE.md).

## Alternatives Considered

- **Keep `analyzer/` and add `discovery/` as a separate, broader component.**
  Rejected: would duplicate stack-detection logic between two components
  with overlapping responsibility, violating "No Duplicate Logic."
- **Fold Planning into the Orchestrator** rather than a separate component.
  Rejected: the Sprint 2 bootstrap explicitly lists Planning Engine as a
  required specification, and keeping it separate preserves the
  single-responsibility boundary the Orchestrator already relies on (it
  coordinates; it does not decide).
- **Merge `plugins/` into `domain-packs/`.** Rejected: conflates two
  different extension axes (technical capability vs. industry vertical),
  which would make it harder to compose, e.g., a "trading" domain pack that
  uses a "Python" language plugin and a "PostgreSQL" database plugin — those
  are cross-cutting choices, not the domain pack's own logic.

## Consequences

- The [Architecture Specification](../architecture/ARCHITECTURE.md) and
  [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md) are
  both updated in this sprint to reflect the renamed/added components.
- Any Sprint 1 language referring to "Project Analyzer" should be read as
  referring to the Discovery Engine going forward; no functional behavior
  changed, since neither had an implementation yet.
- Future sprints implementing `framework/discovery/`, `framework/planning/`,
  and `framework/memory/` should treat this record as the origin of their
  scope, alongside their individual specifications in
  `docs/specifications/engines/`.

## Related Documents

- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
- [Plugin Architecture Specification](../architecture/PLUGIN_ARCHITECTURE.md)
- [Runtime Architecture Specification](../architecture/RUNTIME_ARCHITECTURE.md)
- [Configuration Specification](../specifications/CONFIGURATION_SPEC.md)
