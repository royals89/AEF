# 0002. Agent specifications live in docs/, not .claude/agents/

**Status:** Accepted
**Date:** 2026-07-22
**Owner:** Principal AI Platform Architect (Sprint 3 bootstrap)

## Context

The Sprint 3 bootstrap prompt requires building "a reusable, enterprise-
grade agent architecture" — a framework specification, a standard agent
contract, and specifications for 24 individual agents across 8 teams — while
explicitly prohibiting commands, hooks, templates, or runtime logic this
sprint, and requiring Sprint 4 approval before proceeding to those. This
needed reconciling against `.claude/agents/`, which the
[Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md) has,
since Sprint 1, reserved for Claude-Code-specific **runtime** agent
definitions — the actual files Claude Code loads and executes.

## Decision

Agent framework and individual agent **specifications** are placed under
`docs/specifications/agents/`, following the same pattern already
established for engines in Sprint 2
(`docs/specifications/engines/` — see
[Bootstrap Engine Specification](../specifications/engines/BOOTSTRAP_ENGINE.md)
as the precedent). `.claude/agents/` remains empty this sprint.

This mirrors the Discovery/Planning/Orchestrator/Workflow/Memory/Quality
Gate pattern exactly: a specification is a design document describing
purpose, contract, and behavior; it is not executable, and does not become
executable until a later sprint implements it. An "agent specification" in
`docs/specifications/agents/` is no more "runtime logic" than the
[Engineering Orchestrator Specification](../specifications/engines/ENGINEERING_ORCHESTRATOR.md)
was in Sprint 2 — both describe a component's contract without
implementing it.

`.claude/agents/` is reserved for the point at which a specification here
is turned into an actual agent definition file Claude Code can load (a
Sprint 4+ concern, gated by the same approval requirement Sprint 3's
bootstrap prompt states directly: "Wait for Sprint 4 approval before
proceeding").

## Alternatives Considered

- **Place specifications directly in `.claude/agents/`.** Rejected: would
  blur the specification/implementation boundary this repository has
  maintained consistently since Sprint 1, and would make it unclear, at a
  glance, whether a file in `.claude/agents/` is a loadable agent
  definition or a design document — a meaningful distinction for anyone
  auditing what AEF actually executes versus what it has merely designed.
- **Create a new top-level `agents/` directory** parallel to
  `docs/`, `framework/`, etc. Rejected: agent specifications are
  documentation in the same sense engine specifications are — see
  [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md) — and
  a new top-level directory would fragment "where specifications live"
  across two places without a clear reason for the split.

## Consequences

- `docs/specifications/agents/` follows the same required document
  structure as the rest of `docs/` (Purpose, Scope, ..., Related
  Documents — see
  [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md)),
  adapted per [Agent Contract](../specifications/agents/shared/AGENT_CONTRACT.md)
  for the individual agent documents specifically.
- When Sprint 4 (or later) implements actual agent definitions in
  `.claude/agents/`, each implementation should reference its source
  specification here rather than duplicating its content, consistent with
  the Sprint 3 bootstrap's own instruction that agents reference shared
  assets instead of duplicating content.
- The [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
  is updated this sprint to document `docs/specifications/agents/`
  alongside `docs/specifications/engines/`.

## Related Documents

- [ADR 0001: Sprint 2 structural evolution](0001-sprint-2-structural-evolution.md)
- [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
- [Agent Framework Specification](../specifications/agents/AGENT_FRAMEWORK_SPEC.md)
- [Roadmap](../roadmap/ROADMAP.md)
