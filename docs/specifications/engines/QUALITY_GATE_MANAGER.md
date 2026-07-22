# Quality Gate Manager Specification

## Purpose

The Quality Gate Manager defines, evaluates, and reports on the
checkpoints that must pass before a workflow step — and ultimately a
workflow as a whole — is considered complete: tests, linting, security
scanning, and review requirements, per
[Architecture Specification](../../architecture/ARCHITECTURE.md#quality-gates).

## Scope

Covers gate definition and evaluation. Does not cover *what happens* when a
gate fails beyond reporting the result — the declared failure behavior
(halt/fallback/non-fatal) is applied by the Workflow Engine (see
[Workflow Engine Specification](WORKFLOW_ENGINE.md)), not decided by the
Quality Gate Manager itself.

## Responsibilities

- Maintain the registry of available gate definitions (test execution,
  lint, security scan, review-requirement check, and any project- or
  plugin-supplied custom gates).
- Evaluate a named gate against the current `workflow_context` when
  requested by the Workflow Engine at a gated step boundary.
- Return a structured pass/fail (or partial, where a gate supports
  graduated results) with enough detail for the result to be meaningfully
  logged and, if needed, acted on by a human reviewer.
- Support project- and profile-specific gate configuration (e.g., which
  linter, what coverage threshold) without requiring gate logic itself to
  change — see [Configuration Specification](../CONFIGURATION_SPEC.md).

## Inputs

| Input | Description |
|---|---|
| `gate_request` | Which gate(s) to evaluate, plus the current `workflow_context` |
| `resolved_config` | Active profile's gate configuration (thresholds, enabled/disabled gates) |
| `plugin_registry` | Plugins that supply gate implementations (e.g., a language plugin supplying its test runner) |

## Outputs

| Output | Description |
|---|---|
| `gate_result` | Pass/fail/partial, plus supporting detail (e.g., failing test names, lint violations, scan findings) |

## Interfaces

- **Inbound:** invoked by the Workflow Engine at gated step boundaries.
- **Outbound:** invokes plugin-supplied gate implementations (e.g., a
  language plugin's test runner, a security plugin's scanner) via the
  Plugin Manager. Does not call the Orchestrator, Planning Engine, or
  Memory Manager directly — gate results are reported back to the Workflow
  Engine, which reports to the Orchestrator in turn.

## Lifecycle

1. **Receive** a `gate_request` for one or more named gates at a step
   boundary.
2. **Resolve configuration** — thresholds and enablement from
   `resolved_config` for each requested gate.
3. **Delegate** — invoke the plugin-supplied implementation for each gate
   (e.g., the relevant language plugin's test runner).
4. **Aggregate** — combine individual gate outcomes into `gate_result`.
5. **Return** `gate_result` to the Workflow Engine.

## Extension Points

- **New gate types** are added by supplying a plugin that implements the
  Quality Gate Manager's gate-provider contract — no changes to the
  Quality Gate Manager itself are required (see
  [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md)).
- **Per-profile gate policy** (which gates are mandatory, what thresholds
  apply) is entirely configuration-driven (see
  [Configuration Specification](../CONFIGURATION_SPEC.md)) — e.g., an
  `enterprise` profile may mandate a security-scan gate that a `startup`
  profile leaves optional.

## Error Handling

- **Gate implementation unavailable** (plugin missing at execution time):
  reported as a distinct `gate_result` status (not a plain fail), so the
  Workflow Engine and any human reviewer can tell "the check didn't run"
  apart from "the check ran and failed."
- **Gate implementation errors internally** (e.g., the test runner itself
  crashes): reported as `gate_result` status `error`, distinct from `fail`
  — a crashed check is not evidence the underlying quality bar wasn't met,
  and conflating the two would produce misleading audit history.
- **Conflicting gate configuration** (e.g., a profile both disables and
  mandates the same gate through different config layers): resolved by the
  Configuration layering precedence defined in
  [Configuration Specification](../CONFIGURATION_SPEC.md); if still
  ambiguous, the Quality Gate Manager fails the request rather than
  guessing which instruction wins.

## Future Enhancements

- Graduated (non-binary) gate results with configurable pass thresholds
  beyond simple pass/fail (e.g., "coverage decreased but above floor").
- Historical gate-result trending, surfaced via the Memory Manager's
  workflow history.
- Gate result caching for unchanged inputs, to avoid redundant re-runs
  within a single workflow.

## Related Documents

- [Architecture Specification](../../architecture/ARCHITECTURE.md)
- [Workflow Engine Specification](WORKFLOW_ENGINE.md)
- [Plugin Architecture Specification](../../architecture/PLUGIN_ARCHITECTURE.md)
- [Configuration Specification](../CONFIGURATION_SPEC.md)
- [Security Standards](../../standards/SECURITY_STANDARDS.md)
