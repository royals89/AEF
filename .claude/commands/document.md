---
description: Produce or update project and API reference documentation for an implemented change.
argument-hint: [scope]
---

# /document

Document `$ARGUMENTS` (a component, feature, or the project as a whole; if
not specified, the most recently implemented change).

## What to do

1. Compare existing documentation against the current project state to
   identify what's stale or missing.
2. Invoke `technical-writer` for general documentation.
3. If an API contract is in scope, invoke `api-documentation-engineer`
   for reference documentation, sourced directly from the API contract.
4. Apply `.claude/shared/DOCUMENTATION_STYLE.md` throughout.
5. If existing docs contain a genuine inconsistency (not just staleness),
   flag it explicitly rather than silently picking one version.

## Preconditions

Implementation is complete (or, for design-stage documentation, a design
document exists).

## Success criteria

Documentation satisfies the required structure (Purpose, Scope, Related)
and, for API docs, matches the source contract exactly.

## Failure handling

- Existing docs are inconsistent with each other: escalate to a human or
  `enterprise-architect` for the affected section; proceed on unaffected
  sections.
- API contract itself is ambiguous: escalate back to `api-engineer` —
  never fill the gap with an assumption.

## Related

`docs/specifications/automation/commands/DOCUMENT.md` ·
`.claude/shared/DOCUMENTATION_STYLE.md`
