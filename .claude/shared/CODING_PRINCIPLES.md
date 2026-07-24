---
asset: coding-principles
type: shared-asset
source: docs/standards/CODING_STANDARDS.md, docs/architecture/ARCHITECTURE.md
---

# Coding Principles

Referenced by: all Engineering, Platform, and AI team agents; the
`implement` command; the Implementation skill.

## Core Rules

1. **Single responsibility.** Every module/function does one thing. If a
   change touches two unrelated concerns, split it.
2. **No duplicated logic.** Before writing new code, check whether
   equivalent logic already exists in the project (its own shared/utils
   layer) or in AEF's own `framework/shared/`. Reuse or extend; don't
   reimplement.
3. **Configuration over hardcoding.** Values that could plausibly differ
   by environment or project profile are read from configuration, never
   hardcoded.
4. **Fail loud, fail typed.** Use the project's typed error/exception
   conventions. Never swallow an error silently.
5. **Document public interfaces at the point of definition.** Inline
   documentation for anything another module/agent will call — not only
   in a separate doc.
6. **Tests accompany code.** A code change without a corresponding test is
   incomplete, not merely lower quality.

## Naming

- Directories and files: `kebab-case`.
- Configuration keys: `snake_case`.
- Public interface/type names: `PascalCase`.
- Functions and variables: match the convention of the target language,
  applied consistently within a module.

## Structure Rules

- Stay within your own component/module boundary. Cross-component calls go
  through whatever the project's defined integration point is — never a
  direct reach into another module's internals.
- Match the target project's existing conventions (detected via
  `project_profile`) over imposing an unrelated external style.

## Self-Check Before Submitting Code

- [ ] Does this duplicate logic that already exists elsewhere?
- [ ] Are all public interfaces documented?
- [ ] Are tests included?
- [ ] Are configuration values used instead of hardcoded ones?
- [ ] Does naming match the project's existing convention?

## Related

- `docs/standards/CODING_STANDARDS.md` (full rationale)
- `.claude/shared/REVIEW_CHECKLIST.md`
- `.claude/skills/implementation/SKILL.md`
