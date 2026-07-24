---
description: Verify a reviewed code change functionally, and for performance where the active profile requires it.
argument-hint: [change reference]
---

# /test

Verify the most recently reviewed change (or the one referenced in
`$ARGUMENTS`).

## What to do

1. Invoke `qa-engineer` for functional verification: execute relevant
   tests, and test against the original requirement's intent, not only
   the implementation's own interpretation of it.
2. If the active configuration profile requires performance verification
   (or performance risk is evident), also invoke `performance-engineer`
   against defined thresholds.
3. Categorize any defects found: functional, performance, or security —
   route security-flavored findings to `/secure` rather than handling
   them here.
4. Report a clear pass/fail per category tested.

## Preconditions

The change has been reviewed (`/review`), or is explicitly supplied for
standalone testing.

## Success criteria

No unaddressed functional defect remains when this command reports
complete; findings are categorized, not lumped together.

## Failure handling

- Functional defect found: escalate back to the implementing agent;
  `/test` is incomplete until resolved and re-verified.
- Performance threshold failure: escalate to the relevant Engineering
  agent.
- Ambiguous/contradictory requirement discovered during testing: escalate
  to a human rather than resolving it unilaterally.

## Related

`docs/specifications/automation/commands/TEST.md` ·
`.claude/agents/qa-engineer.md` · `.claude/agents/performance-engineer.md`
