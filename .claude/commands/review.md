---
description: Route an implemented code change to code review against coding principles and the review checklist.
argument-hint: [change reference]
---

# /review

Review the most recently implemented change (or the one referenced in
`$ARGUMENTS`).

## What to do

1. Invoke `code-reviewer` with: the code change, and the design/contract
   it implements against (if available).
2. Apply `.claude/shared/REVIEW_CHECKLIST.md` in full.
3. Produce one clear verdict: **approve** or **request changes**, with
   specific items named for any request-changes verdict.
4. If a security-relevant pattern is noticed outside the standard
   checklist, flag it for `security-engineer` rather than either
   ignoring it or attempting a full security review here.

## Preconditions

A code change exists to review.

## Success criteria

A verdict is produced with review comments satisfying the baseline
checklist — never an ambiguous or partial verdict.

## Failure handling

- No code change available: say so, don't fabricate a review.
- Request-changes verdict: this is a normal, successful outcome for
  `/review` — route back to the implementing agent, not a command
  failure.
- Repeated unresolved disagreement across review cycles: escalate to a
  human rather than looping indefinitely.

## Related

`docs/specifications/automation/commands/REVIEW.md` ·
`.claude/agents/code-reviewer.md`
