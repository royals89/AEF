---
description: Turn a requirement into a concrete execution plan against the current project profile, without executing it yet.
argument-hint: <requirement or workflow name>
---

# /plan

Turn `$ARGUMENTS` into a concrete plan of work.

## What to do

1. If `$ARGUMENTS` is missing or vague, invoke `business-analyst` to
   interpret it into structured requirements first.
2. Identify which reusable workflow this maps to: New Project, New
   Feature, Bug Fix, Refactoring, Security Review, Documentation, or
   Release (see `docs/specifications/automation/workflows/`). If none
   fit cleanly, say so explicitly rather than forcing a mismatch.
3. Use the current project profile (run `/analyze` first if none exists
   or it's stale) to bind the workflow's generic steps to this project's
   actual stack and agents.
4. Check feasibility: does every step have an available agent/capability
   for this project? If something's missing, report exactly what's
   missing instead of producing an incomplete plan.
5. Present the resulting plan: ordered steps, which agent handles each,
   and which quality gates apply.

## Preconditions

- A current project profile exists.
- The request maps to a known workflow (or the mismatch is explicitly
  flagged).

## Success criteria

- A complete, ordered plan is produced with every step bound to an
  available agent, OR a clear statement of what's missing is given
  instead — never a partial plan presented as complete.

## Failure handling

- Missing project profile: run `/analyze` first, or ask permission to.
- Unknown/unmappable workflow: ask for clarification rather than
  guessing.
- Infeasible step (no available agent/capability): report specifically
  what's missing.

## Related

`docs/specifications/automation/commands/PLAN.md` ·
`docs/specifications/automation/workflows/WORKFLOW_LIBRARY.md`
