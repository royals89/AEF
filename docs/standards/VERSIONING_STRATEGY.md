# Versioning Strategy

## Purpose

Defines how AEF itself is versioned, so downstream projects can depend on a
given AEF version with predictable expectations about compatibility.

## Scope

Covers versioning of the AEF framework as a whole and of individual Domain
Packs. Does not cover versioning of projects that merely use AEF.

## Responsibilities

The maintainer(s) recorded in each component's ownership metadata (defined
in Sprint 2 tooling) are responsible for correctly classifying the impact of
their changes under this scheme.

## Design Decisions

- **Semantic Versioning (SemVer) for the framework.** `MAJOR.MINOR.PATCH`:
  - `MAJOR` — breaking change to a public interface, extension-point
    contract, or configuration schema.
  - `MINOR` — backward-compatible new capability (new component, new
    optional config field, new workflow type).
  - `PATCH` — backward-compatible fix.
- **Independent versioning for Domain Packs.** Each Domain Pack declares its
  own SemVer version plus the range of AEF core versions it's compatible
  with, checked by the Plugin Manager at load time (see
  [Architecture Specification](../architecture/ARCHITECTURE.md#plugin-manager--domain-packs)).
- **Sprint tags are not release versions.** `sprint-N-complete` git tags
  (see [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md)) mark
  development milestones; they are distinct from SemVer releases, which are
  cut only when a sprint's output is ready for downstream consumption.
- **Pre-1.0 caveat.** Until AEF reaches `1.0.0`, `MINOR` version bumps may
  include breaking changes, consistent with standard SemVer pre-release
  conventions. This repository currently targets `1.0.0-sprint1` — a
  pre-release identifier, not a release.

## Future Extension Points

- Automated version bump + changelog generation from Conventional Commits
  (see [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md)), once CI
  exists in Sprint 2.
- Formal deprecation policy for extension-point contract changes.

## Related Documents

- [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md)
- [Roadmap](../roadmap/ROADMAP.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
