# AEF Architecture Specification

## Purpose

Defines the technical architecture of AEF: its components, their
responsibilities, and how they interact. This is a specification only —
none of these components are implemented yet as of Sprint 2.

## Scope

Covers the Core Framework, Orchestrator, Discovery Engine, Planning Engine,
Workflow Engine, Memory Manager, Quality Gates, Plugin Manager, Runtime
Abstraction, Governance Layer, and Domain Packs. Does not cover engineering
process (see [standards/](../standards/)) or product vision (see
[Master Specification](../specifications/MASTER_SPEC.md)). For full
per-engine detail (inputs, outputs, lifecycle, error handling) beyond the
architectural summary given here, see
[docs/specifications/engines/](../specifications/engines/). For the
runtime and plugin systems introduced in Sprint 2, see
[Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md) and
[Plugin Architecture Specification](PLUGIN_ARCHITECTURE.md).

## Architecture Principles

These principles govern every design decision in AEF:

- **Architecture First** — structure and contracts are defined before code.
- **Security by Design** — security is a default property of every
  component, not a layer added later.
- **Documentation as Code** — docs are versioned, reviewed, and kept in sync
  with the system they describe.
- **Configuration over Hardcoding** — behavior is driven by configuration,
  not hardcoded assumptions.
- **Plugin-based Architecture** — the core stays small; project- and
  domain-specific behavior lives in plugins.
- **Modular Components** — each component has a single, well-defined
  responsibility and a stable interface.
- **Clear Ownership** — every component and document has a defined owner.
- **No Duplicate Logic** — a capability is implemented in exactly one place.
- **Enterprise Quality** — every component meets the bar defined in
  [standards/](../standards/) before it is considered done.
- **Automation by Default** — anything that can be automated (tests, checks,
  releases) should be.

## System Overview

```
                         ┌─────────────────────────┐
                         │      Governance Layer     │
                         │  (policy, approval, audit) │
                         └────────────┬────────────┘
                                      │
                         ┌────────────▼────────────┐
                         │  Engineering Orchestrator  │
                         └─┬─────────┬────────────┬─┘
                           │         │            │
                 ┌─────────▼─┐ ┌─────▼──────┐ ┌───▼─────┐
                 │ Discovery  │ │  Planning   │ │ Workflow │
                 │  Engine    │→│  Engine     │→│ Engine   │
                 └────────────┘ └─────────────┘ └────┬─────┘
                                                       │
                                             ┌─────────▼─────────┐
                                             │  Quality Gate       │
                                             │  Manager             │
                                             └─────────┬───────────┘
                                                       │
                                             ┌─────────▼─────────┐
                                             │   Plugin Manager    │
                                             │ (plugins/, domain-  │
                                             │  packs/)             │
                                             └─────────┬───────────┘
                                                       │
                                             ┌─────────▼─────────┐
                                             │  Runtime Abstraction │
                                             │ (runtime/claude-code, │
                                             │  runtime/shared, ...) │
                                             └───────────────────────┘

        Core Framework (config, lifecycle, shared utilities) underlies all of the above.
        Memory Manager is called by the Orchestrator (writes) and read by the
        Orchestrator, Discovery Engine, and Governance Layer.
        Configuration (config/profiles/) is read by every engine via the Core
        Framework's layered config loader — see Configuration Specification.
```

Only the Orchestrator calls across Discovery, Planning, Workflow Engine,
and Quality Gate Manager — the arrows between Discovery → Planning →
Workflow above depict data flow within a single Orchestrator-driven
invocation, not direct calls between those components (see
[Engineering Orchestrator Specification](../specifications/engines/ENGINEERING_ORCHESTRATOR.md)).

## Components

### Core Framework
**Location:** `framework/core/`

The kernel. Owns configuration loading/validation, component lifecycle
(init, start, stop), the extension-point registry that plugins attach to,
and shared error/logging contracts used by every other component. The Core
Framework has no knowledge of any specific runtime, workflow, or domain —
those are all consumers of the Core Framework's contracts, never the other
way around.

**Responsibilities:** configuration schema and loading; component lifecycle
management; extension-point registry; cross-cutting contracts (logging,
error types, event bus).

**Explicitly not responsible for:** workflow logic, quality checks, runtime
specifics — those live in their own components.

### Engineering Orchestrator
**Location:** `framework/orchestrator/`

Coordinates multi-step engineering workflows across the Discovery Engine,
Planning Engine, Workflow Engine, and Quality Gate Manager. The Orchestrator
is the only component permitted to call across these four — they do not
call each other directly. This keeps the interaction graph a star rather
than a mesh, so any one component can be replaced without rippling changes
through the others. Full detail:
[Engineering Orchestrator Specification](../specifications/engines/ENGINEERING_ORCHESTRATOR.md).

**Responsibilities:** sequencing discovery → planning → workflow →
quality-gate calls; propagating context (including Memory) between steps;
surfacing governance checkpoints at the right point in a workflow.

### Discovery Engine
**Location:** `framework/discovery/`

Inspects a target repository and its runtime/configuration context before
AEF acts on it: language/stack detection, existing conventions, dependency
graph, relevant `plugins/` entries, and prior AEF-managed history (via
Memory Manager). Produces a structured "project profile" that the Planning
Engine, Workflow Engine, and Quality Gate Manager consume. Supersedes and
broadens Sprint 1's "Project Analyzer" — see
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md). Full
detail: [Discovery Engine Specification](../specifications/engines/DISCOVERY_ENGINE.md).

**Responsibilities:** stack/convention detection; dependency awareness;
plugin relevance mapping; producing a versioned project profile artifact.

### Planning Engine
**Location:** `framework/planning/`

New in Sprint 2 (see
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md)). Turns a
project profile (from Discovery) and a requested workflow into a concrete,
project-specific execution plan: ordered steps bound to specific plugins,
with Quality Gates and governance checkpoints attached per the active
configuration profile. Sits between Discovery and the Workflow Engine,
splitting "decide what to do" from "make it happen." Full detail:
[Planning Engine Specification](../specifications/engines/PLANNING_ENGINE.md).

**Responsibilities:** binding workflow templates to concrete project
context; plugin selection per step; gate/checkpoint attachment; feasibility
validation.

### Workflow Engine
**Location:** `framework/workflow/`

Executes the ordered steps of an execution plan produced by the Planning
Engine, invoking each step's bound plugin(s) and requesting Quality Gate
Manager evaluation at gated step boundaries. Workflows themselves remain
data, not code (see [Workflow Specification](../workflows/WORKFLOW_SPEC.md))
— the Workflow Engine executes a plan; it does not decide what the plan
should be. Full detail:
[Workflow Engine Specification](../specifications/engines/WORKFLOW_ENGINE.md).

**Responsibilities:** step execution and sequencing per a given plan; gate
invocation at step boundaries; checkpoint/rollback semantics.

### Bootstrap Engine
**Location:** `framework/bootstrap/`

Handles first-run initialization of AEF against a new or existing
repository: creating the expected directory structure, seeding default
configuration for a selected profile, and running the Discovery Engine for
the first time. This is the component that produced this repository
structure. Full detail:
[Bootstrap Engine Specification](../specifications/engines/BOOTSTRAP_ENGINE.md).

### Quality Gate Manager
**Location:** `framework/quality/`

Defines and evaluates the checkpoints that must pass before work is
considered complete: tests, linting, security scanning, and review
requirements. Gates are configuration-driven and plugin-supplied — a
project can add or replace gates by supplying a plugin, without modifying
the Quality Gate Manager itself. Full detail:
[Quality Gate Manager Specification](../specifications/engines/QUALITY_GATE_MANAGER.md).

**Responsibilities:** gate definition registry; pass/fail/error evaluation;
gate result reporting to the Workflow Engine.

### Governance Layer
**Location:** `framework/governance/`

Defines and enforces policy: which actions require human approval, which
standards are mandatory versus advisory, and what gets written to the audit
trail. The Governance Layer is consulted by the Orchestrator at defined
checkpoints (e.g., before Sprint transitions, before destructive operations).
Unchanged from Sprint 1; not in scope for Sprint 2 implementation (see
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md)).

**Responsibilities:** policy definition and evaluation; approval-gate
enforcement; audit logging.

### Plugin Manager / Plugins / Domain Packs
**Location:** `framework/shared/` (manager), `plugins/` (technical
capability plugins), `domain-packs/` (industry/domain verticals)

The Plugin Manager discovers, loads, and validates both `plugins/` entries
and `domain-packs/` packs — self-contained extensions that add technical-
capability or domain-specific behavior without modifying the core. As of
Sprint 2, these are two distinct, complementary taxonomies rather than one:
`plugins/` is organized into six fixed categories (languages, frameworks,
databases, cloud providers, AI providers, security); `domain-packs/`
composes `plugins/` entries plus domain-specific workflow/governance
defaults for a given industry vertical. See
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md) and
[Plugin Architecture Specification](PLUGIN_ARCHITECTURE.md) for the full
distinction. Both declare the extension points they attach to and must not
reach into core internals directly.

**Responsibilities:** plugin/pack discovery and loading; interface/version
compatibility checks; sandboxed execution boundary between core and
plugins/packs.

### Runtime Abstraction
**Location:** `framework/core/` (interface contract) with concrete adapters
in `runtime/<runtime-name>/` and shared adapter utilities in
`runtime/shared/`

Defines the interface AEF uses to talk to whatever AI coding runtime is
executing it. Claude Code (`runtime/claude-code/`) is the first
implementation of this interface. Nothing outside the Runtime Abstraction
layer should contain runtime-specific logic — this is what makes AEF
vendor-neutral. Full detail, including how to add a new runtime (e.g.,
Codex CLI, Gemini CLI) without touching the framework core:
[Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md).

**Responsibilities:** defining the runtime-facing contract (invocation,
context passing, memory backing store); one adapter implementation per
supported runtime.

### Memory Manager
**Location:** `framework/memory/` (runtime-agnostic contract) with
per-runtime backing stores (e.g., `.claude/memory/` for the Claude Code
adapter)

Persistent, structured context AEF retains about a project across sessions:
prior project profiles, workflow history, decisions, and governance audit
records. Promoted to a full framework component in Sprint 2 — see
[ADR 0001](../decisions/0001-sprint-2-structural-evolution.md). Memory is
read by the Orchestrator, Discovery Engine, and Governance Layer, and
written to by the Orchestrator on behalf of other components, keeping a
single, consistent write path. Full detail:
[Memory Manager Specification](../specifications/engines/MEMORY_MANAGER.md).

## Data Flow (conceptual, Sprint 2+)

1. A workflow is invoked (via a `.claude/commands/` command in Sprint 3+,
   or directly via a Runtime Adapter).
2. The Orchestrator asks the Discovery Engine for a current project profile
   (using the Memory Manager for anything already known, and `plugins/` for
   relevant-plugin mapping).
3. The Orchestrator asks the Planning Engine to turn the requested workflow
   and project profile into a concrete execution plan.
4. The Orchestrator asks the Workflow Engine to execute that plan's steps
   in order; each step may invoke a plugin and is checked against relevant
   Quality Gates via the Quality Gate Manager.
5. Governance checkpoints fire at defined points (e.g., before merge).
6. Results, decisions, and any new project-profile information are written
   back via the Memory Manager by the Orchestrator.

## Future Extension Points

- Additional Runtime Abstraction adapters (non-Claude-Code runtimes) — see
  [Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md#adding-a-new-runtime-eg-codex-cli-gemini-cli).
- Additional plugins within each `plugins/` category, and additional
  `domain-packs/` (industry/vertical specific).
- Pluggable Quality Gate implementations (e.g., swapping linters), supplied
  as plugins.
- Alternative Memory Manager backends (local file store today; remote/
  shared store possible later).

## Related Documents

- [Master Specification](../specifications/MASTER_SPEC.md)
- [Repository Structure Guide](REPOSITORY_STRUCTURE.md)
- [Runtime Architecture Specification](RUNTIME_ARCHITECTURE.md)
- [Plugin Architecture Specification](PLUGIN_ARCHITECTURE.md)
- [Configuration Specification](../specifications/CONFIGURATION_SPEC.md)
- [Workflow Specification](../workflows/WORKFLOW_SPEC.md)
- [Engine Specifications](../specifications/engines/)
- [Security Standards](../standards/SECURITY_STANDARDS.md)
- [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md)
- [ADR 0001: Sprint 2 structural evolution](../decisions/0001-sprint-2-structural-evolution.md)
