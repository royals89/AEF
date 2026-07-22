# AEF Master Specification

## Purpose

This document is the single source of truth for what AEF (AI Engineering
Framework) is, why it exists, and what it must guarantee. Every other
document in this repository is a refinement of something stated here. Where
another document appears to conflict with this one, this one wins until both
are reconciled.

## Scope

This specification covers:

- The problem AEF solves
- The product vision and non-goals
- The core concepts and vocabulary used across the framework
- The guarantees AEF makes to teams that adopt it
- The boundaries of Sprint 1 versus future sprints

This specification does **not** cover implementation details of any specific
component (see [Architecture Specification](../architecture/ARCHITECTURE.md)),
or day-to-day engineering process (see [standards/](../standards/)).

## Problem Statement

AI coding assistants are increasingly used to plan, generate, and modify
production software, but most teams use them in an ad-hoc way: prompts are
one-off, conventions live in individual engineers' heads, quality gates are
inconsistent, and there is no shared, versioned definition of *how* AI-assisted
engineering should be done on a given codebase. This creates three problems:

1. **Inconsistency** — the same request produces different quality output
   depending on who prompted it and how.
2. **No institutional memory** — decisions, conventions, and context are not
   captured anywhere the AI (or a new team member) can reliably find them.
3. **No governance** — there is no repeatable way to enforce security,
   quality, or architectural standards on AI-generated work.

## Vision

AEF is an **AI Engineering Operating System**: a modular, configuration-driven
framework that standardizes how AI coding runtimes (starting with Claude Code)
analyze, plan, build, test, and govern software across any project, language,
or framework.

AEF should feel less like a prompt library and more like an operating system
kernel — a small, stable core with well-defined extension points, where
project-specific and domain-specific behavior is added through plugins
("domain packs") rather than by modifying the core.

## Non-Goals

- AEF is not a code generator in itself; it does not replace the underlying
  AI runtime's reasoning — it structures and governs how that reasoning is
  invoked and applied.
- AEF is not tied to Claude Code specifically. Claude Code is the first
  supported runtime, not a permanent dependency (see
  [Runtime Abstraction](../architecture/ARCHITECTURE.md#runtime-abstraction)).
- AEF does not prescribe a specific programming language, framework, or
  hosting environment for the *projects* it is used on.
- Sprint 1 does not implement any runtime behavior. It defines the
  architecture and standards that later sprints implement against.

## Core Concepts

| Term | Definition |
|---|---|
| **Runtime** | The AI coding tool executing AEF (e.g., Claude Code). |
| **Core Framework** | The stable kernel: config loading, lifecycle, extension points. |
| **Orchestrator** | Coordinates multi-step engineering workflows across components. |
| **Project Analyzer** | Inspects a target repository to understand its structure, stack, and conventions before AEF acts on it. |
| **Workflow Engine** | Executes defined, repeatable engineering workflows (e.g., "implement feature," "fix bug," "refactor module"). |
| **Quality Gate** | A checkpoint that must pass before work is considered complete (tests, lint, security scan, review). |
| **Plugin / Domain Pack** | A self-contained extension that adds domain- or stack-specific behavior without modifying the core. |
| **Governance Layer** | Defines and enforces policy: what actions require approval, what standards are mandatory, what gets logged. |
| **Memory** | Persistent, structured context AEF retains about a project across sessions. |

## Guarantees

When fully implemented, AEF guarantees that any project adopting it will have:

1. A documented, versioned architecture and set of engineering standards
   that both humans and the AI runtime can read and follow.
2. A repeatable workflow model — the same class of task is executed the same
   way regardless of who invokes it.
3. Quality gates that run automatically before work is considered complete.
4. Clear extension points, so project- or domain-specific needs are met via
   plugins rather than by forking or hand-editing the core.
5. An audit trail of significant decisions (see
   [Decision Log](../decisions/DECISION_LOG_TEMPLATE.md)).

Sprint 1 establishes the specifications these guarantees are built on. The
guarantees themselves become enforceable starting in Sprint 2, when runtime
components are implemented.

## Sprint Boundaries

| Sprint | Deliverable |
|---|---|
| **Sprint 1 (this sprint)** | Repository structure, architecture spec, engineering standards, workflow spec — documentation only. No agents, commands, hooks, or runtime code. |
| **Sprint 2+** | Runtime implementation (subject to a separate approval step — see [Roadmap](../roadmap/ROADMAP.md)). |

## Related Documents

- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
- [Workflow Specification](../workflows/WORKFLOW_SPEC.md)
- [Versioning Strategy](../standards/VERSIONING_STRATEGY.md)
- [Roadmap](../roadmap/ROADMAP.md)
