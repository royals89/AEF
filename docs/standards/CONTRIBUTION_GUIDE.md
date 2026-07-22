# Contribution Guide

## Purpose

Explains how to contribute to AEF — human or AI-assisted — so contributions
consistently meet the standards defined elsewhere in `docs/standards/`.

## Scope

Covers the contribution process end-to-end: from picking up work through
merge. Does not restate the standards themselves — this document links to
them at the relevant step.

## Responsibilities

Every contributor follows this process; there is no fast path that skips
review or Quality Gates, including for AI-generated contributions.

## Process

1. **Understand the scope.** Read the relevant part of the
   [Master Specification](../specifications/MASTER_SPEC.md) and
   [Architecture Specification](../architecture/ARCHITECTURE.md) before
   writing anything. Check the [Roadmap](../roadmap/ROADMAP.md) to confirm
   the work is in-scope for the current sprint.
2. **Check for existing work.** Search `framework/shared/` and related
   components for existing logic before adding new code (see
   [Coding Standards](CODING_STANDARDS.md#design-decisions):
   No Duplicate Logic).
3. **Branch.** Follow [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md)
   for branch naming and commit message format.
4. **Implement.** Follow [Coding Standards](CODING_STANDARDS.md) and
   [Documentation Standards](DOCUMENTATION_STANDARDS.md) as applicable.
   Add tests per [Testing Standards](TESTING_STANDARDS.md).
5. **Record significant decisions.** If the change involves a non-obvious
   architectural choice, add a
   [Decision Record](../decisions/DECISION_LOG_TEMPLATE.md) rather than
   leaving the reasoning only in a PR description.
6. **Open a pull request.** Follow the checklist in
   [Review Standards](REVIEW_STANDARDS.md).
7. **Address review feedback and merge** once Quality Gates pass and
   required approvals (including any Governance Layer approval per
   [Security Standards](SECURITY_STANDARDS.md)) are obtained.

## Sprint Discipline

Sprint 1 is documentation and architecture only. Contributions that add
runtime implementation code, agents, commands, or hooks before Sprint 2 is
explicitly approved are out of scope — see [Roadmap](../roadmap/ROADMAP.md).

## Getting Help

Open questions about where something belongs are resolved by consulting, in
order: the [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md),
existing [Decision Records](../decisions/), and — only if still unresolved —
a new Decision Record proposing an answer.

## Related Documents

- [Coding Standards](CODING_STANDARDS.md)
- [Review Standards](REVIEW_STANDARDS.md)
- [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md)
- [Roadmap](../roadmap/ROADMAP.md)
