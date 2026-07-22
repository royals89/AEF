# AEF Architecture Specification

## Purpose

Defines the technical architecture of AEF: its components, their
responsibilities, and how they interact. This is a specification only —
Sprint 1 defines these components; none are implemented yet.

## Scope

Covers the Core Framework, Orchestrator, Project Analyzer, Workflow Engine,
Memory, Quality Gates, Plugin Manager, Runtime Abstraction, and Domain Packs.
Does not cover engineering process (see [standards/](../standards/)) or
product vision (see [Master Specification](../specifications/MASTER_SPEC.md)).

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
                         │       Orchestrator        │
                         └──┬──────────┬───────────┬─┘
                            │          │           │
                  ┌─────────▼──┐ ┌─────▼─────┐ ┌───▼────────┐
                  │  Project    │ │  Workflow  │ │  Quality   │
                  │  Analyzer   │ │  Engine    │ │  Gates     │
                  └─────────────┘ └─────┬──────┘ └────────────┘
                                        │
                              ┌─────────▼─────────┐
                              │   Plugin Manager    │
                              │  (Domain Packs)      │
                              └─────────┬───────────┘
                                        │
                              ┌─────────▼─────────┐
                              │  Runtime Abstraction │
                              │   (Claude Code, ...)  │
                              └───────────────────────┘

        Core Framework (config, lifecycle, shared utilities) underlies all of the above.
        Memory is accessed by the Orchestrator, Workflow Engine, and Project Analyzer.
```

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

### Orchestrator
**Location:** `framework/orchestrator/`

Coordinates multi-step engineering workflows across the Project Analyzer,
Workflow Engine, and Quality Gates. The Orchestrator is the only component
permitted to call across these three — they do not call each other directly.
This keeps the interaction graph a star rather than a mesh, so any one
component can be replaced without rippling changes through the others.

**Responsibilities:** sequencing analyzer → workflow → quality-gate calls;
propagating context (including Memory) between steps; surfacing
governance checkpoints at the right point in a workflow.

### Project Analyzer
**Location:** `framework/analyzer/`

Inspects a target repository before AEF acts on it: language/stack
detection, existing conventions, dependency graph, and prior AEF-managed
history (via Memory). Produces a structured "project profile" that the
Workflow Engine and any Domain Pack can consume.

**Responsibilities:** stack/convention detection; dependency awareness;
producing a versioned project profile artifact.

### Workflow Engine
**Location:** `framework/workflow/`

Executes defined, repeatable workflows (e.g., "implement feature," "fix
bug," "refactor module"). A workflow is a configuration-driven sequence of
steps, each of which may invoke a Domain Pack, request a Quality Gate check,
or request a governance approval. Workflows are data, not code — new
workflows should be addable via configuration wherever possible.

**Responsibilities:** workflow definition schema; step execution and
sequencing; checkpoint/rollback semantics.

### Bootstrap
**Location:** `framework/bootstrap/`

Handles first-run initialization of AEF against a new or existing
repository: creating the expected directory structure, seeding default
configuration, and running the Project Analyzer for the first time. This is
the component that produced this very repository structure.

### Quality Gates
**Location:** `framework/quality/`

Defines and runs the checkpoints that must pass before work is considered
complete: tests, linting, security scanning, and review requirements. Quality
Gates are configuration-driven and pluggable — a project can add or replace
gates without modifying the Quality Gates component itself.

**Responsibilities:** gate definition schema; pass/fail evaluation; gate
result reporting to the Orchestrator and governance log.

### Governance Layer
**Location:** `framework/governance/`

Defines and enforces policy: which actions require human approval, which
standards are mandatory versus advisory, and what gets written to the audit
trail. The Governance Layer is consulted by the Orchestrator at defined
checkpoints (e.g., before Sprint transitions, before destructive operations).

**Responsibilities:** policy definition and evaluation; approval-gate
enforcement; audit logging.

### Plugin Manager / Domain Packs
**Location:** `framework/shared/` (manager) and `domain-packs/` (packs)

The Plugin Manager discovers, loads, and validates Domain Packs — self-
contained extensions that add stack- or domain-specific behavior (e.g., a
"Python/Django" pack, a "network infrastructure" pack) without modifying the
core. Domain Packs declare the extension points they attach to and must not
reach into core internals directly.

**Responsibilities:** plugin discovery and loading; interface/version
compatibility checks; sandboxed execution boundary between core and plugins.

### Runtime Abstraction
**Location:** `framework/core/` (interface) with runtime adapters alongside

Defines the interface AEF uses to talk to whatever AI coding runtime is
executing it. Claude Code is the first implementation of this interface.
Nothing outside the Runtime Abstraction layer should contain
runtime-specific logic — this is what makes AEF vendor-neutral.

**Responsibilities:** defining the runtime-facing contract (invocation,
context passing, tool/command surface); one adapter implementation per
supported runtime.

### Memory
**Location:** `.claude/memory/` (Claude Code runtime store) with a
runtime-agnostic interface defined in `framework/core/`

Persistent, structured context AEF retains about a project across sessions:
prior project profiles, workflow history, decisions, and governance audit
records. Memory is read by the Orchestrator, Project Analyzer, and Workflow
Engine, and written to by the Orchestrator on their behalf — individual
components do not write to Memory directly, to keep a single, consistent
write path.

## Data Flow (conceptual, Sprint 2+)

1. A workflow is invoked (via a `.claude/commands/` command or directly).
2. The Orchestrator asks the Project Analyzer for a current project profile
   (using Memory for anything already known).
3. The Orchestrator asks the Workflow Engine to execute the requested
   workflow, passing the project profile.
4. Each workflow step may invoke a Domain Pack (via the Plugin Manager) and
   is checked against relevant Quality Gates.
5. Governance checkpoints fire at defined points (e.g., before merge).
6. Results, decisions, and any new project-profile information are written
   back to Memory by the Orchestrator.

## Future Extension Points

- Additional Runtime Abstraction adapters (non-Claude-Code runtimes).
- Additional Domain Packs (language/stack/industry specific).
- Pluggable Quality Gate implementations (e.g., swapping linters).
- Alternative Memory backends (local file store today; remote/shared store
  possible later).

## Related Documents

- [Master Specification](../specifications/MASTER_SPEC.md)
- [Repository Structure Guide](REPOSITORY_STRUCTURE.md)
- [Workflow Specification](../workflows/WORKFLOW_SPEC.md)
- [Security Standards](../standards/SECURITY_STANDARDS.md)
- [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md)
