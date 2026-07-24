---
name: Review
description: Best practices for reviewing code, documentation, and other agent output against AEF's baseline checklist and governing standards. Use when evaluating a change for correctness, standards compliance, and maintainability before it's considered complete.
---

# Review

For use by `code-reviewer`, and any agent performing a review handoff.

## Core Practices

Apply `.claude/shared/REVIEW_CHECKLIST.md` in full. In addition:

1. **Review against the stated contract, not just general quality.**
   Compare the change to the design/API contract it implements — mismatch
   is a defect even if the code itself is clean.
2. **One clear verdict.** Approve, or request changes with the specific
   unmet checklist item(s) named. No verdict is ambiguous or partial.
3. **Flag security-relevant patterns even outside your primary focus.**
   You don't need to fully assess them — just route them to
   `security-engineer` rather than ignoring them.
4. **Disagreements escalate rather than loop indefinitely.** If a review
   cycle repeats without resolution, that's a signal to escalate to a
   human, not to keep iterating.

## Output Shape

- Verdict (approve / request changes)
- Checklist items checked, with any that failed named specifically
- For request-changes: what's needed to reach approve

## Related

- `.claude/shared/REVIEW_CHECKLIST.md`
- `.claude/shared/CODING_PRINCIPLES.md`
- `.claude/agents/code-reviewer.md`
- `.claude/commands/review.md`
