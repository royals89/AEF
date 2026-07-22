# Testing Standards

## Purpose

Defines what "tested" means for AEF's own codebase, so Quality Gates have an
unambiguous bar to enforce (see
[Architecture Specification](../architecture/ARCHITECTURE.md#quality-gates)).

## Scope

Applies to code under `framework/` and `domain-packs/`. Example code under
`examples/` is exempt (see [Coding Standards](CODING_STANDARDS.md#relaxed-standard-for-examples)).

## Responsibilities

Each component owner is responsible for their component's test suite under
`tests/<component>/`, mirroring the `framework/<component>/` structure
defined in the [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md).

## Design Decisions

- **Tests mirror structure.** `tests/` mirrors `framework/` 1:1 so any
  contributor (human or AI) can find a component's tests without searching.
- **Unit tests are mandatory; integration tests are required at component
  boundaries.** Because the Orchestrator is the only component permitted to
  call across Analyzer/Workflow/Quality boundaries (see
  [Architecture Specification](../architecture/ARCHITECTURE.md#orchestrator)),
  integration tests are concentrated there rather than scattered redundantly
  across every component pair.
- **Domain Packs are tested against a contract test suite**, not just
  their own unit tests, so any pack meeting the Plugin Manager's interface
  is verified compatible before release.
- **No implementation without a corresponding test plan.** A Quality Gate
  should reject work that adds implementation code without any associated
  test coverage, rather than merely warning about it.

## Test Categories

| Category | Scope | Required for |
|---|---|---|
| Unit | Single function/module in isolation | All `framework/` and `domain-packs/` code |
| Integration | Cross-component interaction via the Orchestrator | Orchestrator, Workflow Engine |
| Contract | Domain Pack ↔ Plugin Manager interface compliance | All Domain Packs |
| Regression | Previously fixed defects | Any bugfix workflow |

## Future Extension Points

- Coverage thresholds and enforcement tooling, defined once Sprint 2 selects
  an implementation language.
- Performance/load testing standards for the Orchestrator and Workflow
  Engine, once real workflows exist to benchmark.

## Related Documents

- [Coding Standards](CODING_STANDARDS.md)
- [Review Standards](REVIEW_STANDARDS.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
