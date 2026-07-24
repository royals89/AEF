---
description: Run a read-only diagnostic health check across this AEF-managed repository - structure, configuration, plugin compatibility, and memory consistency.
argument-hint: []
---

# /doctor

Run a diagnostic health check. This command is read-only — it never
modifies anything.

## What to do

1. Check repository structure against `docs/architecture/REPOSITORY_STRUCTURE.md`
   expectations; report any missing or unexpected paths.
2. Check configuration validity: does the active profile's configuration
   parse and satisfy its expected shape?
3. Check plugin/capability compatibility, where applicable, against the
   declared compatible core version.
4. Check for any obviously corrupt or inconsistent stored state (e.g., a
   project profile that references files that no longer exist).
5. Report every check with a definitive pass/fail/warning — never an
   ambiguous "unknown" without stating why the check couldn't run.

## Preconditions

None — designed to run safely even against a partially broken or
inconsistent repository state, since diagnosing that state is the point.

## Success criteria

A clean repository produces an all-pass report with zero side effects.
Every check reports a definitive result.

## Failure handling

- `/doctor` itself doesn't "fail" except if it can't access the target
  path at all.
- Findings (structure mismatch, config issues, compatibility problems)
  are reported with specific detail — what's expected vs. what's actually
  there — not auto-fixed. Use `/update` for repair.

## Related

`docs/specifications/automation/commands/DOCTOR.md` ·
`.claude/commands/update.md`
