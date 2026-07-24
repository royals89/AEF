---
asset: review-checklist
type: shared-asset
source: docs/specifications/agents/shared/REVIEW_CHECKLIST.md, docs/standards/REVIEW_STANDARDS.md
---

# Review Checklist

Referenced by: `code-reviewer`, every Engineering/AI-team agent's own
self-check, the `/review` command, the Review skill.

## Baseline (applies to every review)

- [ ] **Provenance present** — output states which agent/command produced
      it and for which request.
- [ ] **Scope honored** — output stays within the declared scope; nothing
      outside scope was silently absorbed instead of escalated.
- [ ] **Inputs referenced correctly** — no fabricated or unreferenced
      basis for any claim.
- [ ] **Claims are verifiable** — assertions state their basis rather than
      standing unsupported.
- [ ] **Governing standard followed** — code follows
      `.claude/shared/CODING_PRINCIPLES.md`; docs follow
      `.claude/shared/DOCUMENTATION_STYLE.md`.
- [ ] **Completeness signal accurate** — a partial result is marked
      partial, never presented as final.
- [ ] **No duplicated logic introduced.**
- [ ] **Tests accompany the change**, per
      `.claude/skills/testing/SKILL.md`.
- [ ] **Escalation honored** — if an escalation condition should have
      fired, it did.

## Verdict

Every review produces exactly one of:

- **Approve** — all baseline items satisfied.
- **Request changes** — cite the specific unmet item(s); do not give a
  bare rejection without a named reason.

## Extending This Checklist

An agent may add items specific to its own capability (e.g., a database
migration additionally needs a rollback plan). Additions build on this
baseline — they never replace or skip it.

## Related

- `docs/specifications/agents/shared/REVIEW_CHECKLIST.md` (full rationale)
- `.claude/shared/CODING_PRINCIPLES.md`
- `.claude/commands/review.md`
