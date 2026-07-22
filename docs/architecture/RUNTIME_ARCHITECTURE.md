# Runtime Architecture Specification

## Purpose

Defines how AEF's Runtime Abstraction works in practice: the contract every
Runtime Adapter implements, the two adapters established in Sprint 2
(Claude Code and Shared Runtime), and the exact steps required to add a new
runtime (e.g., Codex CLI, Gemini CLI) without modifying the framework core.

## Scope

Covers runtime adapters and the abstraction boundary between them and
`framework/`. Does not cover the internals of any specific engine
(Orchestrator, Workflow Engine, etc.) — see
[docs/specifications/engines/](../specifications/engines/) — which are
runtime-agnostic by construction and out of scope here.

## Background

The [Architecture Specification](ARCHITECTURE.md#runtime-abstraction)
established in Sprint 1 that nothing outside the Runtime Abstraction layer
should contain runtime-specific logic. Sprint 2 makes this concrete: a
top-level `runtime/` directory holds one subdirectory per supported
runtime, each implementing the same adapter contract, plus a `shared/`
subdirectory for logic common to all adapters.

## Directory Layout

```
runtime/
├── shared/              Logic common to all Runtime Adapters
│   └── README.md          Adapter contract, shared utilities
└── claude-code/          Claude Code Runtime Adapter (Sprint 2 reference implementation)
    └── README.md           Claude-Code-specific adapter details
```

`runtime/shared/` is not itself a runtime — it's where adapter-contract
code that would otherwise be duplicated across every adapter lives (e.g.,
common request/response shapes, shared validation). Every concrete adapter
depends on `runtime/shared/`; `runtime/shared/` depends on nothing runtime-
specific.

## The Adapter Contract

Every Runtime Adapter, regardless of which AI coding tool it wraps,
implements the same three responsibilities:

1. **Invocation surface** — how a user or the runtime's own tool-use
   mechanism triggers an AEF workflow (e.g., Claude Code's
   `.claude/commands/`; a future adapter's own equivalent mechanism).
2. **Context passing** — translating the runtime's native context (files
   in scope, conversation/session state, tool outputs) into the
   `runtime_context` and `workflow_request` inputs the Engineering
   Orchestrator expects (see
   [Engineering Orchestrator Specification](../specifications/engines/ENGINEERING_ORCHESTRATOR.md)).
3. **Memory backing store** — supplying the concrete storage backend behind
   the Memory Manager's runtime-agnostic contract (see
   [Memory Manager Specification](../specifications/engines/MEMORY_MANAGER.md)).
   For Claude Code, this is `.claude/memory/` on disk.

An adapter must implement all three. `framework/` components call only the
adapter contract — never a specific runtime's native APIs directly.

## Claude Code Adapter (`runtime/claude-code/`)

The Sprint 2 reference implementation. Bridges:

- Claude Code's `.claude/commands/` (Sprint 3+) to Orchestrator invocation.
- Claude Code's tool-use/session context to `runtime_context`.
- `.claude/memory/` as the Memory Manager's backing store.

Sprint 2 establishes this adapter's directory and documents its contract
obligations; the concrete implementation code follows the same "not yet
implemented" status as the rest of `framework/` this sprint (see
[Roadmap](../roadmap/ROADMAP.md)).

## Shared Runtime (`runtime/shared/`)

Holds contract types and utilities used by every adapter, so adding a new
adapter means implementing the contract, not rebuilding common plumbing.
What belongs here versus in `framework/core/`: `framework/core/` defines
the abstract contract (the interface); `runtime/shared/` holds concrete
helper code that any adapter implementation may reuse, but which is not
itself part of the framework core's public interface.

## Adding a New Runtime (e.g., Codex CLI, Gemini CLI)

Adding support for a new AI coding runtime requires only:

1. Create `runtime/<new-runtime-name>/`.
2. Implement the three adapter-contract responsibilities above, using
   `runtime/shared/` where applicable.
3. Supply a Memory Manager backing store appropriate to that runtime's
   environment (a local file store, a different session-scoped store, etc.).
4. Register the adapter so the Bootstrap Engine and Orchestrator can
   resolve `runtime_context` to this new adapter (registration mechanism
   defined alongside the Core Framework's implementation in Sprint 2+
   follow-through).

**No changes to `framework/` are required.** Every engine specified in
`docs/specifications/engines/` receives `runtime_context` and
`workflow_request` as plain inputs — none of them import or reference a
specific runtime. This is the guarantee the Runtime Abstraction layer
exists to provide, and it is why Claude Code is described throughout this
repository as "the first supported runtime, not the only one" (see
[Master Specification](../specifications/MASTER_SPEC.md#non-goals)).

## Design Decisions

- **One directory per runtime, flat under `runtime/`**, rather than nested
  by category, keeps adding a runtime a single, obvious step (see
  Adding a New Runtime, above).
- **`shared/` is a sibling, not a base class hierarchy.** Adapters compose
  shared utilities rather than inherit from a shared base implementation,
  keeping each adapter free to differ structurally where its host runtime
  requires it, without fighting an imposed inheritance shape.
- **The adapter, not the framework, owns runtime-native context
  translation.** This keeps `framework/` genuinely runtime-agnostic rather
  than "mostly agnostic with a few Claude Code assumptions baked in."

## Future Extension Points

- Formal adapter contract-test suite (mirroring the Domain Pack
  contract-test approach in [Plugin Standards](../standards/PLUGIN_STANDARDS.md)),
  so a new adapter's compliance is verifiable before it's trusted.
- Adapter capability negotiation, for runtimes that support only a subset
  of AEF's invocation surface.

## Related Documents

- [Architecture Specification](ARCHITECTURE.md)
- [ADR 0001: Sprint 2 structural evolution](../decisions/0001-sprint-2-structural-evolution.md)
- [Memory Manager Specification](../specifications/engines/MEMORY_MANAGER.md)
- [Engineering Orchestrator Specification](../specifications/engines/ENGINEERING_ORCHESTRATOR.md)
- [Roadmap](../roadmap/ROADMAP.md)
