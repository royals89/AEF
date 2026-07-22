# Discovery Engine Specification

## Purpose

The Discovery Engine inspects a target repository and its runtime
environment to produce a structured **project profile**: the stack,
conventions, dependency graph, configured plugins, and deployment context
that every downstream engine (Planning, Workflow, Quality) relies on. It
supersedes and broadens the Sprint 1 "Project Analyzer" — see
[ADR 0001](../../decisions/0001-sprint-2-structural-evolution.md).

## Scope

Covers repository- and environment-level discovery. Does not cover
deciding *what to do* with the discovered information — that is the
Planning Engine's responsibility (see
[Planning Engine Specification](PLANNING_ENGINE.md)).

## Responsibilities

- Detect languages, frameworks, and build tooling present in the target
  repository.
- Detect existing conventions (naming, structure) so later engines respect
  them rather than imposing AEF defaults blindly.
- Build a dependency graph sufficient for the Planning Engine to reason
  about blast radius of a change.
- Identify which `plugins/` entries are relevant to the detected stack
  (e.g., detecting Python + PostgreSQL implies the corresponding language
  and database plugins should be considered active).
- Read the resolved `config/` profile (see
  [Configuration Specification](../CONFIGURATION_SPEC.md)) to understand
  organizational context (e.g., `enterprise` vs. `startup`) that affects
  discovery depth (e.g., enterprise profiles may require deeper dependency
  and security-posture scanning).
- Incorporate prior project-profile history from the Memory Manager, so
  repeated discovery runs are incremental rather than always full scans.
- Produce a versioned **project profile** artifact consumed by Planning,
  Workflow, and Quality Gate Manager.

## Inputs

| Input | Description |
|---|---|
| `target_path` | Repository root to analyze |
| `resolved_config` | The active `config/` profile (see [Configuration Specification](../CONFIGURATION_SPEC.md)) |
| `prior_project_profile` | Previous profile from the Memory Manager, if any |
| `plugin_registry` | Currently available `plugins/` entries, from the Plugin Manager (`framework/shared/`) |

## Outputs

| Output | Description |
|---|---|
| `project_profile` | Structured artifact: detected stack, conventions, dependency graph, relevant plugin set, deployment context |
| `discovery_diff` | What changed since `prior_project_profile`, when one existed (supports incremental re-discovery) |

## Interfaces

- **Inbound:** invoked by the Bootstrap Engine (first run) and by the
  Orchestrator (subsequent runs, at the start of a workflow invocation —
  see [Workflow Specification](../../workflows/WORKFLOW_SPEC.md)).
- **Outbound:** reads from the Memory Manager (prior profile) and the
  Plugin Manager (available plugins); writes the new `project_profile` back
  to the Memory Manager via the Orchestrator, consistent with the
  single-write-path rule in the
  [Architecture Specification](../../architecture/ARCHITECTURE.md#memory).
  Discovery does not call the Planning Engine, Workflow Engine, or Quality
  Gate Manager directly.

## Lifecycle

1. **Load context** — resolved config profile and prior project profile
   (if any).
2. **Scan** — walk the target repository for language/framework/tooling
   signals, respecting `.gitignore` and any AEF-specific exclusion config.
3. **Diff** — compare against `prior_project_profile` to scope the scan
   depth for incremental runs.
4. **Map plugins** — cross-reference detected stack against
   `plugin_registry` to determine the relevant plugin set.
5. **Assemble** — produce the `project_profile` artifact.
6. **Return** — hand `project_profile` and `discovery_diff` back to the
   invoking component (Bootstrap or Orchestrator).

## Extension Points

- **Detection rules per plugin category** (see
  [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md))
  are supplied by the plugins themselves — Discovery does not hardcode
  per-language or per-framework detection logic; it calls into each
  registered plugin's detection contract.
- **Scan depth policy** is configuration-driven per profile (e.g.,
  `enterprise` may mandate a deeper dependency/security scan than
  `startup`) without changing Discovery's own code.

## Error Handling

- **Partial scan failure** (e.g., one plugin's detector errors): Discovery
  records the failure against that plugin in `project_profile` and
  continues scanning with the remaining plugins, rather than aborting the
  entire run.
- **No prior profile found:** treated as a full, non-incremental first
  scan — not an error condition.
- **Corrupt/unreadable prior profile:** logged as a warning; Discovery
  falls back to a full scan rather than trusting a possibly-invalid diff.

## Future Enhancements

- Live/watch-mode discovery that updates `project_profile` incrementally
  as files change, rather than only on workflow invocation.
- Cross-repository discovery for monorepos and multi-service architectures.
- Confidence scoring per detected signal, so Planning can weigh
  low-confidence detections differently.

## Related Documents

- [ADR 0001: Sprint 2 structural evolution](../../decisions/0001-sprint-2-structural-evolution.md)
- [Planning Engine Specification](PLANNING_ENGINE.md)
- [Memory Manager Specification](MEMORY_MANAGER.md)
- [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md)
- [Configuration Specification](../CONFIGURATION_SPEC.md)
