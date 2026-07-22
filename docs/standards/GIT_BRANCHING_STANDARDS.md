# Git & Branching Standards

## Purpose

Defines source-control conventions so history stays readable and automatable
across a repository that both humans and AI agents commit to.

## Scope

Applies to all commits, branches, and pull requests in this repository.

## Responsibilities

Every contributor (human or AI-driven) follows these conventions without
exception; CI enforcement is added in Sprint 2 once `.github/` workflows
exist.

## Design Decisions

- **Trunk-based with short-lived feature branches.** `main` is always
  releasable. Feature work happens on branches named per the convention
  below and merges back via reviewed pull request.
- **Conventional Commits.** Commit messages follow
  `type(scope): summary`, e.g. `feat(orchestrator): add workflow dispatch`,
  `docs(architecture): clarify plugin manager boundary`. This enables
  automated changelog generation later and gives both humans and AI agents
  a predictable way to scan history.
- **Sprint boundaries are tagged.** Each sprint's completion (see
  [Roadmap](../roadmap/ROADMAP.md)) is marked with an annotated tag, e.g.
  `sprint-1-complete`, so the state of the repo at each approval gate is
  recoverable.

## Branch Naming

| Type | Pattern | Example |
|---|---|---|
| Feature | `feature/<short-description>` | `feature/workflow-engine-schema` |
| Fix | `fix/<short-description>` | `fix/analyzer-null-profile` |
| Docs | `docs/<short-description>` | `docs/security-standards-update` |
| Chore | `chore/<short-description>` | `chore/repo-structure-cleanup` |

## Commit Message Format

```
<type>(<scope>): <summary, imperative mood, no trailing period>

<optional body: why, not just what>
```

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `build`, `ci`.

## Pull Requests

- One logical change per PR. A PR that touches both `framework/` code and
  unrelated `docs/` content should be split.
- PR description states **what** changed and **why**, and links the
  relevant Decision Record if the change stems from one.
- See [Review Standards](REVIEW_STANDARDS.md) for review requirements
  before merge.

## Future Extension Points

- CODEOWNERS-based automatic reviewer assignment (Sprint 2, once `.github/`
  is populated).
- Automated Conventional Commit linting in CI.

## Related Documents

- [Review Standards](REVIEW_STANDARDS.md)
- [Versioning Strategy](VERSIONING_STRATEGY.md)
- [Contribution Guide](CONTRIBUTION_GUIDE.md)
