# Workflow Library

## Purpose

Catalogs the seven reusable workflows built on the workflow definition
model established in [Workflow Specification](../../../workflows/WORKFLOW_SPEC.md):
New Project, New Feature, Bug Fix, Refactoring, Security Review,
Documentation, and Release. These are the named workflows the `plan`
command (see [plan](../commands/PLAN.md)) resolves against.

## Scope

Covers the library's index and cross-workflow conventions. Each
workflow's full definition (trigger, inputs, steps, quality gates,
governance) is its own file in this directory. Does not redefine the
workflow definition model itself — see
[Workflow Specification](../../../workflows/WORKFLOW_SPEC.md) for that.

## The Seven Workflows

| Workflow | Typical trigger | Summary |
|---|---|---|
| [New Project](NEW_PROJECT.md) | `bootstrap` on an empty/new repository | Establishes AEF management of a repository from scratch |
| [New Feature](NEW_FEATURE.md) | `plan` with a feature requirement | Requirement → design → implementation → verification → documentation |
| [Bug Fix](BUG_FIX.md) | `plan` with a defect report | Reproduction → root-cause → fix → verification, with regression testing |
| [Refactoring](REFACTORING.md) | `plan` with a refactor target | Behavior-preserving structural change, verified against existing tests |
| [Security Review](SECURITY_REVIEW.md) | `secure`, or scheduled per `config/` profile | Threat modeling, testing, and compliance verification without a code change as the primary deliverable |
| [Documentation](DOCUMENTATION.md) | `document` | Documentation-only workflow, for when documentation lags implementation |
| [Release](RELEASE.md) | `release` | Version finalization, tagging, and release-scoped verification |

## Cross-Workflow Conventions

- **Every workflow starts with an implicit Discovery step** unless the
  current `project_profile` is fresh enough (per the active `config/`
  profile's staleness threshold) — this is not restated in each
  workflow's own step list, per
  [Documentation Standards: cross-referencing over duplication](../../../standards/DOCUMENTATION_STANDARDS.md#design-decisions).
- **Every workflow's Quality Gates reference the [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md) baseline** for any step producing agent output, plus workflow-specific gates declared in that workflow's own file.
- **Every workflow declares its Governance checkpoints explicitly**, per
  [Workflow Specification: Workflow Definition Model](../../../workflows/WORKFLOW_SPEC.md#workflow-definition-model) —
  none are assumed silently ungoverned.

## Design Decisions

- **Seven workflows, matching exactly what the Sprint 4 bootstrap named.**
  No additional workflows were added speculatively — new workflows are a
  configuration addition (per
  [Workflow Specification: Concept](../../../workflows/WORKFLOW_SPEC.md#concept)),
  not a framework change, so there's no cost to adding more later as real
  needs arise.
- **One file per workflow**, mirroring the one-file-per-agent and
  one-file-per-command patterns already established, for the same
  navigability reason.

## Related Documents

- [Workflow Specification](../../../workflows/WORKFLOW_SPEC.md)
- [Automation Architecture](../AUTOMATION_ARCHITECTURE.md)
- [Automation Rules](../AUTOMATION_RULES.md)
- [plan command](../commands/PLAN.md)
