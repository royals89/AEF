# Review Standards

## Purpose

Defines what a pull request must satisfy before merge, so review quality is
consistent regardless of whether the reviewer is human or an AI-assisted
Quality Gate.

## Scope

Applies to all pull requests into `main`. Draft/WIP branches are exempt
until marked ready for review.

## Responsibilities

The PR author is responsible for satisfying every applicable checklist item
before requesting review. The reviewer is responsible for verifying them,
not re-deriving them from scratch.

## Design Decisions

- **Checklist-driven review.** A fixed checklist (below) keeps review focus
  on substance rather than re-litigating style choices already codified in
  [Coding Standards](CODING_STANDARDS.md) and
  [Documentation Standards](DOCUMENTATION_STANDARDS.md).
- **Quality Gates run before human review, not instead of it.** Automated
  gates catch mechanical issues (tests, lint, security scan); human review
  focuses on architectural fit and intent.
- **Governance approval is a separate step from code review** for anything
  classified as requiring it (see
  [Security Standards](SECURITY_STANDARDS.md#design-decisions)) — code
  review approval does not substitute for a required governance approval.

## Review Checklist

- [ ] Change matches its stated purpose; no unrelated changes bundled in.
- [ ] Relevant Quality Gates pass.
- [ ] New/changed public interfaces are documented at the point of
      definition (see [Coding Standards](CODING_STANDARDS.md)).
- [ ] No duplicated logic introduced (checked against
      `framework/shared/` and related components).
- [ ] Tests added/updated per [Testing Standards](TESTING_STANDARDS.md).
- [ ] Documentation under `docs/` updated if behavior or architecture
      changed.
- [ ] Commit messages follow
      [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md).
- [ ] Any decision with lasting architectural impact is captured as a
      Decision Record (see [Decision Log Template](../decisions/DECISION_LOG_TEMPLATE.md)).

## Future Extension Points

- CODEOWNERS-driven mandatory reviewer assignment per component.
- Automated checklist verification as a Quality Gate.

## Related Documents

- [Git & Branching Standards](GIT_BRANCHING_STANDARDS.md)
- [Testing Standards](TESTING_STANDARDS.md)
- [Security Standards](SECURITY_STANDARDS.md)
