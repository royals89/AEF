# Documentation Standards

## Purpose

Defines how documentation is written and organized across AEF, so that
"Documentation as Code" (see
[Architecture Principles](../architecture/ARCHITECTURE.md#architecture-principles))
is a practice, not just a slogan.

## Scope

Applies to every Markdown document under `docs/`. Code-comment documentation
is covered by [Coding Standards](CODING_STANDARDS.md) instead.

## Responsibilities

Every document owner is responsible for keeping their document accurate as
the system it describes changes. A document that falls out of sync with
reality is treated as a defect, the same as a failing test.

## Required Structure

Every substantive document in `docs/` includes these sections, in this
order:

1. **Purpose** — one or two sentences: why this document exists.
2. **Scope** — what it covers and, where useful, what it explicitly does not.
3. (Document-specific content)
4. **Related Documents** — links to directly relevant documents elsewhere in
   the repo.

Architecture and specification documents additionally include:

- **Responsibilities**
- **Design Decisions**
- **Future Extension Points**

This structure is itself defined by the Sprint 1 bootstrap requirements and
is used consistently across `docs/architecture/`, `docs/specifications/`,
and `docs/standards/`.

## Design Decisions

- **Cross-referencing over duplication.** If a concept is already defined
  elsewhere (e.g., a term in the [Master Specification](../specifications/MASTER_SPEC.md)),
  link to it instead of redefining it. Duplicated definitions drift out of
  sync; links don't.
- **One concern per document.** A document that starts covering two
  unrelated concerns should be split, with each half linking to the other
  via Related Documents.
- **Markdown only.** All documentation is Markdown for portability and
  diffability in version control.

## Style Rules

- Use sentence case for headings, not Title Case.
- Prefer tables over long prose lists when presenting structured
  comparisons (e.g., component responsibility tables).
- Code and file paths use inline code formatting (`` `like/this` ``).
- Keep line length reasonable for diff readability; hard-wrapping is not
  required.

## Future Extension Points

- Automated doc-linting (structure/section checks) — planned for
  `tools/` in Sprint 2, enforced as a Quality Gate.
- Automated cross-reference validation (broken-link checking).

## Related Documents

- [Repository Structure Guide](../architecture/REPOSITORY_STRUCTURE.md)
- [Contribution Guide](CONTRIBUTION_GUIDE.md)
- [Decision Log Template](../decisions/DECISION_LOG_TEMPLATE.md)
