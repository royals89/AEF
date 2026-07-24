---
description: Update AEF's framework, plugins, or apply structural repair identified by a prior /doctor run.
argument-hint: [scope]
---

# /update

Update `$ARGUMENTS` (framework core, a specific plugin/capability, or
"structure" for repair based on the last `/doctor` report — ask if
unspecified).

## What to do

1. If updating framework/plugin versions: confirm the target version is
   compatible with the current core before applying anything.
2. If applying structural repair: only add missing expected paths — never
   delete or overwrite existing content, exactly like `/bootstrap`'s own
   rule.
3. If a version update would involve a breaking (MAJOR) change, stop and
   get explicit confirmation before applying it — never apply a breaking
   change silently.
4. Report exactly what was updated, from which version to which, and
   anything skipped due to incompatibility.

## Preconditions

Ideally, a recent `/doctor` run has confirmed current state. If none
exists and the update scope is structural repair, run `/doctor` first (or
ask permission to).

## Success criteria

Every updated component's compatibility is verified before the update is
applied, not after. Structural repairs are additive only.

## Failure handling

- Target version incompatible with current core: skip that component and
  report why, rather than forcing it.
- Breaking change requires confirmation: stop and ask.
- Structural repair conflict (unexpected content at an expected path):
  report it, don't overwrite.

## Related

`docs/specifications/automation/commands/UPDATE.md` ·
`.claude/commands/doctor.md`
