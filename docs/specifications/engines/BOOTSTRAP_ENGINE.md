# Bootstrap Engine Specification

## Purpose

The Bootstrap Engine performs first-run initialization of AEF against a
target repository: creating the expected directory structure, seeding
default configuration for the selected profile, and triggering the first
Discovery Engine pass. It is the component that produced the Sprint 1
repository structure and this document's own scaffolding in Sprint 2.

## Scope

Covers the Bootstrap Engine's contract only. Does not cover ongoing
(post-bootstrap) configuration changes — see
[Configuration Specification](../CONFIGURATION_SPEC.md) — or repeated
project analysis after the first run — see
[Discovery Engine Specification](DISCOVERY_ENGINE.md).

## Responsibilities

- Detect whether a target repository is unbootstrapped, partially
  bootstrapped, or already AEF-managed, and act accordingly (never silently
  overwrite existing AEF-managed structure or content — see
  [Coding Standards](../../standards/CODING_STANDARDS.md)).
- Create the standard AEF directory structure (see
  [Repository Structure Guide](../../architecture/REPOSITORY_STRUCTURE.md))
  where absent.
- Seed default configuration under `config/` based on a selected or
  inferred profile (see [Configuration Specification](../CONFIGURATION_SPEC.md)).
- Trigger the first Discovery Engine run so the newly bootstrapped project
  has an initial project profile in Memory.
- Report a structured bootstrap result (created/skipped/conflicted paths)
  to the invoking Runtime Adapter.

## Inputs

| Input | Description |
|---|---|
| `target_path` | Root of the repository being bootstrapped |
| `profile` | Optional named configuration profile (e.g., `enterprise`, `startup`); if omitted, Bootstrap requests one interactively via the Runtime Adapter or falls back to a documented default |
| `runtime_context` | Identifies which Runtime Adapter invoked Bootstrap (see [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md)) |
| `existing_state` | Whatever the Core Framework's config loader already finds at `target_path` (used to detect prior partial bootstrap) |

## Outputs

| Output | Description |
|---|---|
| `bootstrap_result` | Structured report: paths created, paths skipped (already present), paths in conflict (present but not AEF-managed), and the profile applied |
| `initial_project_profile` | Written to Memory via the Memory Manager, produced by the triggered Discovery Engine run |
| Filesystem changes | The directory structure and seeded config files themselves |

## Interfaces

- **Inbound:** invoked by a Runtime Adapter (e.g., `runtime/claude-code/`)
  or by a `.claude/commands/` command in Sprint 3+; never invoked directly
  by another framework component other than at Orchestrator request.
- **Outbound:** calls the Core Framework's config loader/validator; calls
  the Discovery Engine for the first project profile; calls the Memory
  Manager to persist that profile; does not call the Orchestrator,
  Workflow Engine, or Planning Engine — bootstrap is a one-time setup path,
  not a workflow.

## Lifecycle

1. **Detect** — inspect `target_path` for existing AEF structure/config.
2. **Resolve profile** — use the given `profile`, or prompt via the Runtime
   Adapter, or apply the documented default profile.
3. **Scaffold** — create missing directories/files; never modify or
   delete anything already present that isn't clearly AEF-generated
   boilerplate.
4. **Seed configuration** — write the resolved profile's configuration
   under `config/`.
5. **Trigger discovery** — invoke the Discovery Engine for an initial
   project profile.
6. **Report** — return the structured `bootstrap_result`.

Bootstrap is idempotent: re-running it against an already-bootstrapped
repository produces a `bootstrap_result` where affected paths are reported
`skipped`, not re-created or overwritten.

## Extension Points

- **Profile resolution strategy** is pluggable — a Runtime Adapter may
  supply its own interactive prompt, or a CI environment may supply a
  profile via environment variable, without Bootstrap itself changing.
- **Post-scaffold hooks** (Sprint 3+, once `.claude/hooks/` is implemented)
  may run additional setup after the standard scaffold completes, without
  modifying the Bootstrap Engine itself.

## Error Handling

- **Conflict (non-AEF content at an expected path):** Bootstrap does not
  overwrite; it reports the conflict in `bootstrap_result` and halts
  scaffolding for that path only, continuing with the rest.
- **Invalid or unknown profile:** fails fast with a clear error before any
  filesystem changes are made — no partial scaffold from a bad profile
  reference.
- **Discovery Engine failure on first run:** Bootstrap still completes
  (structure and config are valid), but `bootstrap_result` flags that no
  initial project profile was produced, so the Orchestrator knows a
  Discovery run is still needed before the first workflow executes.

## Future Enhancements

- Re-bootstrap / "repair" mode that reconciles drift between expected and
  actual structure without a full conflict halt.
- Multi-repository bootstrap (monorepo awareness).
- Profile migration tooling (e.g., moving from `startup` to `enterprise`
  profile on an already-bootstrapped repository).

## Related Documents

- [Discovery Engine Specification](DISCOVERY_ENGINE.md)
- [Configuration Specification](../CONFIGURATION_SPEC.md)
- [Repository Structure Guide](../../architecture/REPOSITORY_STRUCTURE.md)
- [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md)
