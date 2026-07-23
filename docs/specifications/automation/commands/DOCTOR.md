# Command: doctor

**Command ID:** `doctor`

## Purpose

Runs a diagnostic health check across an AEF-managed repository: structure
integrity, configuration validity, plugin compatibility, and Memory
Manager consistency — without modifying anything, to surface problems
before they cause a command or workflow to fail partway through.

## Inputs

- `target_path` — repository root to diagnose

## Outputs

- Diagnostic report: per-check pass/fail/warning, with enough detail to
  act on (mirroring
  [Output Standards: Structural Requirements](../../agents/shared/OUTPUT_STANDARDS.md#structural-requirements)
  even though `doctor` is a command output, not an agent output)

## Preconditions

- None — `doctor` is designed to be safely runnable even against a
  partially broken or inconsistent repository state, since diagnosing such
  states is its purpose.

## Workflow

`doctor` is read-only and does not invoke the Workflow Engine or any
agent. It directly queries: the Core Framework's config loader (schema
validity, per
[Configuration Specification](../../CONFIGURATION_SPEC.md#schema-validation)),
the [Repository Structure Guide](../../../architecture/REPOSITORY_STRUCTURE.md)
expectations, the Plugin Manager (installed `plugins/`/`domain-packs/`
version compatibility, per
[Plugin Architecture Specification](../../../architecture/PLUGIN_ARCHITECTURE.md#plugin-manifest)),
and the Memory Manager (corrupt/missing artifact detection, per
[Memory Manager error handling](../../engines/MEMORY_MANAGER.md#error-handling)).

## Success Criteria

- Every check reports a definitive pass/fail/warning — `doctor` never
  reports an ambiguous "unknown" without stating why the check couldn't
  run.
- A clean repository produces an all-pass report with no side effects.

## Failure Handling

- **Structure mismatch found**: reported as a warning with the specific
  expected-vs-actual path difference; `doctor` does not auto-fix — that is
  `update`'s or `bootstrap`'s concern (see [update](UPDATE.md)).
- **Configuration schema violation found**: reported with the specific
  field and expected schema, per
  [Configuration Specification: Schema Validation](../../CONFIGURATION_SPEC.md#schema-validation).
- **Plugin version incompatibility found**: reported per plugin, citing
  its declared `compatible_core_version`, per
  [Plugin Architecture Specification: Plugin Manifest](../../../architecture/PLUGIN_ARCHITECTURE.md#plugin-manifest).
- `doctor` itself never fails outright except on being unable to access
  `target_path` at all.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Repository Structure Guide](../../../architecture/REPOSITORY_STRUCTURE.md)
- [Configuration Specification](../../CONFIGURATION_SPEC.md)
- [update](UPDATE.md)
