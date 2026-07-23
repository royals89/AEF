# 0003. Automation specifications live in docs/, not .claude/commands/ or .claude/hooks/

**Status:** Accepted
**Date:** 2026-07-23
**Owner:** Principal Automation Architect (Sprint 4 bootstrap)

## Context

The Sprint 4 bootstrap prompt requires designing and documenting a Command
Framework (12 commands), a Hook Framework (12 lifecycle hooks), an Event
Catalog, a Workflow Library (7 workflows), and Automation Rules connecting
all of them to engines and agents — while explicitly scoping the sprint to
"design and document the automation architecture only" and prohibiting
runtime code, templates, and domain packs. This is the same shape of
decision already made twice: [ADR 0002](0002-agent-specifications-location.md)
placed agent specifications in `docs/specifications/agents/` rather than
`.claude/agents/` for exactly this reason.

## Decision

Command, hook, event, and workflow-library specifications are placed under
`docs/specifications/automation/`, following the established
`docs/specifications/{engines,agents}/` pattern. `.claude/commands/` and
`.claude/hooks/` remain empty this sprint.

Specifically:

- `docs/specifications/automation/AUTOMATION_ARCHITECTURE.md` — the anchor
  document, playing the same role for automation that the
  [Agent Framework Specification](../specifications/agents/AGENT_FRAMEWORK_SPEC.md)
  plays for agents.
- `docs/specifications/automation/commands/` — the Command Contract (shared
  shape) plus one specification file per command.
- `docs/specifications/automation/hooks/` — the Hook Framework, covering
  all 12 lifecycle hooks.
- `docs/specifications/automation/events/` — the Event Catalog.
- `docs/specifications/automation/workflows/` — the Workflow Library: one
  specification file per named workflow, building on the workflow
  definition model already established in
  [Workflow Specification](../workflows/WORKFLOW_SPEC.md).
- `docs/specifications/automation/AUTOMATION_RULES.md` — the rules
  connecting commands, workflows, events, hooks, and agents.

A command specification here is no more "runtime code" than a
[Bootstrap Engine Specification](../specifications/engines/BOOTSTRAP_ENGINE.md)
or a [Solution Architect specification](../specifications/agents/teams/architecture/SOLUTION_ARCHITECT.md)
was in their respective sprints — all three describe a contract without
implementing it. `.claude/commands/` and `.claude/hooks/` are reserved for
the point at which these specifications are converted into files Claude
Code can actually load and execute — a future-sprint concern, gated by the
same approval requirement this sprint's bootstrap states directly.

## Alternatives Considered

- **Place command/hook specifications directly in `.claude/commands/` and
  `.claude/hooks/`.** Rejected for the same reason given in
  [ADR 0002](0002-agent-specifications-location.md): it would blur the
  specification/implementation boundary this repository has maintained
  consistently since Sprint 1.
- **Create a new top-level `automation/` directory.** Rejected for the
  same reason `agents/` wasn't made a new top-level directory in Sprint 3:
  automation specifications are documentation in the same sense engine and
  agent specifications are (see
  [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md)), and
  a new top-level directory would fragment "where specifications live"
  without a clear reason for the split.
- **Fold commands/hooks/events/workflows into `docs/specifications/agents/`
  or `docs/specifications/engines/`.** Rejected: automation is a distinct
  concern from either — it is the layer that *invokes* engines and agents
  in response to user commands, lifecycle events, and defined workflows,
  not a new engine or a new agent itself. It warrants its own directory
  for the same reason agents warranted their own in Sprint 3.

## Consequences

- `docs/specifications/automation/` follows the same required document
  structure as the rest of `docs/` (Purpose, Scope, ..., Related
  Documents — see
  [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md)).
- When a future sprint implements actual command/hook definitions in
  `.claude/commands/` and `.claude/hooks/`, each implementation should
  reference its source specification here rather than duplicating its
  content, consistent with the reference-not-duplicate principle already
  established for agents (see
  [Agent Contract](../specifications/agents/shared/AGENT_CONTRACT.md#rules)).
- The [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
  is updated this sprint to document `docs/specifications/automation/`
  alongside `docs/specifications/engines/` and
  `docs/specifications/agents/`.

## Related Documents

- [ADR 0002: Agent specifications location](0002-agent-specifications-location.md)
- [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
- [Automation Architecture](../specifications/automation/AUTOMATION_ARCHITECTURE.md)
- [Roadmap](../roadmap/ROADMAP.md)
