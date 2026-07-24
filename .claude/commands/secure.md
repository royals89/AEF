---
description: Route a design or implemented change through threat modeling, active security testing, and compliance verification.
argument-hint: [target]
---

# /secure

Run security review against `$ARGUMENTS` (a design, an implemented
system, or the most recent relevant change if not specified).

## What to do

1. If reviewing a design (pre-implementation): invoke `security-engineer`
   for threat modeling.
2. If reviewing an implemented/deployed system: invoke
   `penetration-tester` for active testing.
3. If a named compliance standard applies (per the active configuration
   profile): invoke `compliance-engineer`.
4. These may run in any order or in parallel where independent — apply
   `.claude/shared/SECURITY_CHECKLIST.md` throughout.
5. Consolidate findings into one report, cross-referencing overlap
   between security and compliance findings rather than duplicating them.

## Preconditions

A design (for threat modeling) or an implemented/deployed system (for
penetration testing) exists.

## Success criteria

Every finding carries an explicit severity rating (security) or cites the
specific requirement violated (compliance).

## Failure handling

- Critical/High severity finding: escalate immediately to Governance —
  do not let deployment or release proceed past it.
- Confirmed mandatory-standard compliance gap: escalate immediately to
  Governance.
- If a step can't complete (e.g., no accessible test environment for
  penetration testing), report the blocker rather than presenting an
  incomplete review as final.

## Related

`docs/specifications/automation/commands/SECURE.md` ·
`.claude/shared/SECURITY_CHECKLIST.md`
