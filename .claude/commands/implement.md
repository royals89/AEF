---
description: Execute a previously produced plan, invoking the agents each step calls for, through to completion or a defined halt.
argument-hint: [plan reference]
---

# /implement

Execute the plan from the most recent `/plan` invocation (or the one
referenced in `$ARGUMENTS`, if given).

## What to do

1. Confirm a valid plan exists. If not, say so and suggest `/plan` first.
2. Work through the plan's steps in order. For each step:
   - Invoke the agent the plan assigned (e.g., `backend-engineer`,
     `database-engineer`) using its own agent definition in
     `.claude/agents/`.
   - Apply `.claude/skills/implementation/SKILL.md` and
     `.claude/shared/CODING_PRINCIPLES.md`.
   - If the step is gated (e.g., requires review before the next step),
     don't proceed past it until that gate passes.
3. Report each step's result as it completes — don't wait until the end
   to surface a failure.
4. On completion, summarize what was implemented and what (if anything)
   still needs `/review`, `/test`, or `/secure`.

## Preconditions

A valid execution plan exists (from `/plan`).

## Success criteria

- Every step completes, or the workflow halts per its defined failure
  behavior — never silently skip a failed step.

## Failure handling

- Step failure: halt at that step by default, report clearly what failed
  and why, unless the plan explicitly marks that step non-fatal.
- Quality gate failure at a gated boundary: treat as seriously as a step
  failure.
- If something requires human approval per the active configuration
  profile, stop and ask rather than proceeding.

## Related

`docs/specifications/automation/commands/IMPLEMENT.md` ·
`docs/specifications/engines/WORKFLOW_ENGINE.md`
