---
description: Run (or re-run) project discovery to refresh the project profile - stack, conventions, dependencies, and deployment context.
argument-hint: [scope]
---

# /analyze

Analyze this repository and produce or refresh its project profile.

## What to do

1. If `$ARGUMENTS` narrows scope (e.g., a subpath or specific concern
   like "dependencies only"), limit analysis to that scope; otherwise run
   a full analysis.
2. Detect languages, frameworks, and build tooling present.
3. Detect existing conventions (naming, structure) so later work respects
   them.
4. Build or update the dependency graph.
5. Identify which capability areas (languages, frameworks, databases,
   cloud providers, AI providers, security tooling) are relevant to this
   project.
6. If a prior analysis exists, summarize what changed.
7. Report the resulting project profile clearly.

## Preconditions

This repository should already be bootstrapped (`/bootstrap` has run).
If it hasn't, say so and suggest running `/bootstrap` first, but proceed
with best-effort analysis if asked to continue anyway.

## Success criteria

- A structured project profile is produced covering stack, conventions,
  and dependencies.
- If a prior profile existed, differences are called out explicitly.

## Failure handling

- If part of the analysis fails (e.g., a specific detector can't run),
  note that gap specifically and continue with the rest — don't abort the
  whole analysis over one failed check.

## Related

`docs/specifications/automation/commands/ANALYZE.md` ·
`docs/specifications/engines/DISCOVERY_ENGINE.md`
