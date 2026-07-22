# Logging & Configuration Standards

## Purpose

Defines conventions for logging and configuration across all AEF
components, in service of the "Configuration over Hardcoding" and
"Automation by Default" architecture principles.

## Scope

Applies to any component under `framework/` or `domain-packs/` that emits
log output or reads configuration. Does not define the concrete schema
format (JSON Schema vs. other) — that is a Sprint 2 decision to be recorded
in [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md).

## Responsibilities

- The **Core Framework** owns the configuration loading/validation contract
  and the shared logging interface every other component uses.
- Individual components own their own configuration schema (validated
  against the Core Framework's contract) and must not implement bespoke
  logging.

## Design Decisions — Configuration

- **Layered configuration.** Defaults ship with the framework; a project may
  override via a project-level config file; environment-specific overrides
  apply last. Precedence order is defined once and enforced by the Core
  Framework, not reimplemented per component.
- **Schema-validated.** Every configuration surface has a schema (stored
  under `standards/`) and fails fast with a clear error on invalid config,
  rather than silently falling back to defaults.
- **No secrets in config values.** See
  [Security Standards](SECURITY_STANDARDS.md#design-decisions).

## Design Decisions — Logging

- **Structured logging only.** Log entries are structured (key/value or
  equivalent), never free-text-only, so the Governance Layer's audit trail
  and any future tooling can reliably parse them.
- **Consistent severity levels** across all components: `debug`, `info`,
  `warn`, `error`, `audit`. `audit` is reserved for Governance Layer events
  and is never used for ordinary application logging.
- **No logging of secret values**, ever, regardless of severity level.
- **Component-tagged.** Every log entry identifies its originating
  component (e.g., `orchestrator`, `analyzer`) so cross-component issues are
  traceable without guessing.

## Future Extension Points

- Pluggable log sinks (local file, remote aggregator) — the logging
  interface should not assume a single destination.
- Configuration hot-reload for long-running orchestration sessions.

## Related Documents

- [Security Standards](SECURITY_STANDARDS.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Coding Standards](CODING_STANDARDS.md)
