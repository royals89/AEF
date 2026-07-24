---
description: Initialize AEF against this repository - scaffold structure, seed configuration, and run initial discovery.
argument-hint: [profile]
---

# /bootstrap

Initialize AEF management of this repository.

## What to do

1. Determine the target profile: use `$ARGUMENTS` if given (one of
   `enterprise`, `startup`, `ai-platform`, `trading`); otherwise ask which
   profile applies, or default to `startup` if this is clearly a small/
   early-stage project.
2. Check current state: does `.claude/`, `config/`, `docs/` already exist
   in a way that suggests this repo is already AEF-managed? If so, treat
   this as idempotent — report what's already present rather than
   recreating it.
3. Scaffold any missing expected structure per
   `docs/architecture/REPOSITORY_STRUCTURE.md`. **Never overwrite or
   delete existing content** — only fill in what's missing.
4. Seed configuration for the selected profile.
5. Run an initial project discovery pass: identify the language(s),
   framework(s), and key conventions actually present in this repository.
6. Produce a short baseline summary of what was found and what was
   scaffolded.

## Preconditions

None — safe to run on an empty or partially-set-up repository.

## Success criteria

- Structure matches expectations for paths that were missing.
- A profile is selected and its configuration is present.
- A baseline project summary is produced.

## Failure handling

- If a path that should be scaffolded already has unrelated content,
  report the conflict and skip only that path — do not overwrite.
- If the profile given in `$ARGUMENTS` isn't one of the four defined
  profiles, ask for clarification rather than guessing.

## Related

`docs/specifications/automation/commands/BOOTSTRAP.md` ·
`docs/specifications/automation/workflows/NEW_PROJECT.md`
