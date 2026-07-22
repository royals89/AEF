# Memory Manager Specification

## Purpose

The Memory Manager defines and implements persistent, structured storage
for everything AEF needs to remember about a project across sessions:
project profiles, workflow execution history, decisions, and governance
audit records. Promoted to a full framework component in Sprint 2 — see
[ADR 0001](../../decisions/0001-sprint-2-structural-evolution.md).

## Scope

Covers the memory contract and its runtime-specific implementations.
Does not cover *what* gets remembered beyond the categories above, which
are defined by the components that produce that data (Discovery,
Orchestrator, Governance).

## Responsibilities

- Define a single, runtime-agnostic read/write contract used by every
  framework component that needs persistence.
- Provide the reference implementation backing store for the Claude Code
  runtime adapter (`runtime/claude-code/`), with the contract itself kept
  independent of that specific backing store so other runtimes can supply
  their own.
- Enforce the single-write-path rule: only the Orchestrator writes to
  Memory on behalf of other components (see
  [Architecture Specification](../../architecture/ARCHITECTURE.md#memory));
  the Memory Manager itself does not gate *who* calls it beyond exposing
  that contract, but the convention is enforced by the Orchestrator being
  the only caller in practice.
- Version stored artifacts (e.g., project profiles) so consumers can detect
  staleness and Discovery can produce meaningful `discovery_diff` output.
- Support incremental/partial reads (e.g., "just the dependency graph")
  so large project profiles don't need to be fully loaded for every query.

## Inputs

| Input | Description |
|---|---|
| `write_request` | Category (project profile, workflow history, decision, audit record), payload, and version metadata |
| `read_request` | Category and optional filter (e.g., latest only, specific version, specific field) |

## Outputs

| Output | Description |
|---|---|
| `write_result` | Confirmation and the version assigned to the written artifact |
| `read_result` | The requested stored artifact(s), or a clear not-found result |

## Interfaces

- **Inbound:** called by the Orchestrator (writes, per the single-write-path
  convention) and by the Discovery Engine, Orchestrator, and Governance
  Layer (reads).
- **Outbound:** delegates to a runtime-specific backing store — for the
  Claude Code adapter, this is `.claude/memory/` on disk (see
  [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md)).
  The Memory Manager contract itself has no knowledge of the backing
  store's implementation details.

## Lifecycle

Memory Manager is not workflow-scoped like the other engines — it is a
long-lived service available for the lifetime of an AEF session:

1. **Initialize** — resolve which backing store to use, based on
   `runtime_context` (which Runtime Adapter is active).
2. **Serve reads/writes** — for the duration of the session, respond to
   read/write requests per the contract above.
3. **Flush/persist** — ensure durability of writes according to the
   backing store's own guarantees (e.g., disk write for Claude Code's
   local store).

## Extension Points

- **Backing store implementations** are swappable per Runtime Adapter, per
  [ADR 0001](../../decisions/0001-sprint-2-structural-evolution.md) —
  a future non-Claude-Code runtime adapter supplies its own backing store
  behind the same contract (see
  [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md)).
- **Storage category schemas** (project profile shape, workflow history
  shape, etc.) are owned by the components that produce them, not by the
  Memory Manager itself, keeping the Memory Manager genuinely
  content-agnostic.

## Error Handling

- **Backing store unavailable:** Memory Manager fails the request clearly
  rather than silently discarding a write or returning stale data as if
  current.
- **Version conflict on write** (concurrent write to the same artifact):
  rejected with a clear conflict result; the Orchestrator, as sole writer
  in normal operation, is expected not to produce concurrent writes to the
  same artifact — a conflict here signals a bug elsewhere and should
  surface loudly.
- **Corrupt stored artifact on read:** returned as an explicit
  corrupt-artifact result, never silently treated as not-found or as an
  empty default — callers like Discovery need to distinguish "nothing
  here yet" from "something here that's broken."

## Future Enhancements

- Remote/shared backing store option for team-shared project memory,
  beyond the local-file default (see
  [Architecture Specification](../../architecture/ARCHITECTURE.md#future-extension-points)).
- Retention/pruning policy for workflow history, configurable per
  `config/` profile.
- Query interface beyond category+filter (e.g., structured search across
  decision records).

## Related Documents

- [ADR 0001: Sprint 2 structural evolution](../../decisions/0001-sprint-2-structural-evolution.md)
- [Architecture Specification](../../architecture/ARCHITECTURE.md)
- [Runtime Architecture Specification](../../architecture/RUNTIME_ARCHITECTURE.md)
- [Discovery Engine Specification](DISCOVERY_ENGINE.md)
