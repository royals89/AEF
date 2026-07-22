# Decision Log Template

## Purpose

Provides a consistent format for Architecture Decision Records (ADRs) so
significant decisions and their rationale are captured, not lost in PR
discussions or chat history.

## Scope

Applies to any decision with lasting architectural impact: component
boundaries, interface contracts, technology choices, or deviations from a
documented standard. Does not apply to routine implementation choices
already covered by existing standards.

## When to Write One

Write a Decision Record when:

- Choosing between two or more viable architectural approaches.
- Deviating from a documented standard, with justification.
- Making a choice that would be expensive to reverse later (e.g.,
  implementation language, core interface shape, versioning scheme details
  not already fixed in [Versioning Strategy](../standards/VERSIONING_STRATEGY.md)).
- Resolving an open question raised in another document (e.g., an "?" left
  in the Architecture Specification).

## Record Format

Each decision is a new file in this directory named
`NNNN-short-title.md` (four-digit, zero-padded, sequential), using this
template:

```markdown
# NNNN. <Title>

**Status:** Proposed | Accepted | Superseded by NNNN | Deprecated
**Date:** YYYY-MM-DD
**Owner:** <name or role>

## Context

What situation or question prompted this decision? What constraints apply?

## Decision

What was decided, stated plainly.

## Alternatives Considered

What else was on the table, and why it wasn't chosen.

## Consequences

What becomes easier or harder as a result. Include any follow-up work this
creates.

## Related Documents

Links to specs/standards this decision implements, modifies, or deviates
from.
```

## Index

No decisions have been recorded yet. The first Decision Record will be
`0001-` and should be added the first time Sprint 2 work requires choosing
between viable alternatives (e.g., core implementation language).

## Related Documents

- [Contribution Guide](../standards/CONTRIBUTION_GUIDE.md)
- [Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md)
- [Roadmap](../roadmap/ROADMAP.md)
