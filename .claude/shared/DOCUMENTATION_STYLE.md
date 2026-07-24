---
asset: documentation-style
type: shared-asset
source: docs/standards/DOCUMENTATION_STANDARDS.md
---

# Documentation Style

Referenced by: `technical-writer`, `api-documentation-engineer`, the
`/document` command, the Review skill (when reviewing docs).

## Required Structure

Every substantive document includes, in order:

1. **Purpose** — one or two sentences on why it exists.
2. **Scope** — what it covers, and, where useful, what it explicitly does
   not.
3. (document-specific content)
4. **Related** — links to directly relevant material.

## Style Rules

- Sentence case for headings, not Title Case.
- Tables over long prose lists for structured comparisons.
- File paths and code in inline code formatting.
- Cross-reference instead of duplicating — link to the canonical
  definition rather than restating it.
- Keep prose short and direct; prefer concrete detail over abstract
  description.

## API Documentation Specifically

- Match the source contract exactly — no undocumented endpoints, no
  documented behavior the contract doesn't specify.
- Document error semantics as thoroughly as the happy path.

## Self-Check Before Submitting Documentation

- [ ] Purpose and Scope are present and accurate.
- [ ] No content duplicated from another document — cross-referenced
      instead.
- [ ] Structure/formatting matches this style.
- [ ] For API docs: matches the actual contract, including error cases.

## Related

- `docs/standards/DOCUMENTATION_STANDARDS.md` (full rationale)
- `.claude/agents/technical-writer.md`
- `.claude/agents/api-documentation-engineer.md`
- `.claude/commands/document.md`
