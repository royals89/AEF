# Coding Standards

## Purpose

Defines the baseline coding standards for any implementation code added to
`framework/`, `domain-packs/`, or `tools/` from Sprint 2 onward.

## Scope

Applies to all implementation code in this repository. Does not apply to
documentation prose (see [Documentation Standards](DOCUMENTATION_STANDARDS.md))
or to code inside `examples/`, which follows a relaxed variant noted below.

## Responsibilities

- Every module has a single, stated responsibility (see
  [Architecture Specification](../architecture/ARCHITECTURE.md) for
  component boundaries).
- Every public interface is documented at the point of definition, not only
  in `docs/`.
- Configuration values are never hardcoded where a config schema exists for
  them (see [Architecture Principles](../architecture/ARCHITECTURE.md#architecture-principles):
  Configuration over Hardcoding).

## Design Decisions

- **Language-agnostic by default.** AEF's core is designed to be
  implementable in more than one language; Sprint 2 will select and record
  the initial implementation language as a Decision Record rather than
  assuming one here.
- **No duplicate logic.** Before adding a function or module, check whether
  equivalent logic already exists in `framework/shared/`. If it does, reuse
  or extend it rather than reimplementing.
- **Fail loud, fail typed.** Errors use the shared error contract defined in
  `framework/core/` (Sprint 2) rather than untyped exceptions or silent
  failure.

## Naming

- Directories and files: `kebab-case`.
- Configuration keys: `snake_case`.
- Public interface/type names: `PascalCase`.
- Functions and variables: follow the convention of the implementation
  language chosen in Sprint 2, applied consistently within a module.

## Structure Rules

- One component's implementation stays within its own `framework/<component>/`
  directory; cross-component calls go through the Orchestrator, not direct
  imports between component internals (see
  [Architecture Specification](../architecture/ARCHITECTURE.md#orchestrator)).
- Domain Packs never import from `framework/<component>/` internals directly
  — only from the public extension-point interfaces defined in
  `framework/shared/`.

## Relaxed Standard for `examples/`

Code under `examples/` should still be correct and runnable, but may skip
full documentation coverage and error-handling completeness in favor of
readability, since its purpose is pedagogical rather than production use.

## Enforcement

From Sprint 2 onward, these standards are enforced by:

- Linting configuration in `standards/` (machine-readable form).
- Quality Gates (see
  [Architecture Specification](../architecture/ARCHITECTURE.md#quality-gates))
  run automatically before work is considered complete.

## Related Documents

- [Testing Standards](TESTING_STANDARDS.md)
- [Documentation Standards](DOCUMENTATION_STANDARDS.md)
- [Security Standards](SECURITY_STANDARDS.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
