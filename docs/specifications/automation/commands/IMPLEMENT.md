# Command: implement

**Command ID:** `implement`

## Purpose

Executes a previously produced `execution_plan` via the Workflow Engine,
invoking the Engineering (and other, as bound) agents each step calls for,
through to completion or a defined halt.

## Inputs

- `execution_plan` — from a prior `plan` invocation
- `workflow_context` — accumulated as steps execute

## Outputs

- `step_result` per step, and a final `execution_result`, per
  [Workflow Engine Specification](../../engines/WORKFLOW_ENGINE.md#outputs)

## Preconditions

- A valid `execution_plan` exists (from `plan`); `implement` does not plan
  on the fly.

## Workflow

Directly invokes the [Workflow Engine](../../engines/WORKFLOW_ENGINE.md)
via the Engineering Orchestrator to execute the plan's steps in order,
each of which may invoke an Engineering, Architecture, Database, or API
agent (per [Agent Framework Specification](../../agents/AGENT_FRAMEWORK_SPEC.md#relationship-to-the-engine-layer)),
with Quality Gate Manager evaluation at gated step boundaries.

## Success Criteria

- Every step in the plan completes, **or** halts per its declared failure
  behavior — `implement` never silently skips a failed step (per
  [Workflow Engine error handling](../../engines/WORKFLOW_ENGINE.md#error-handling)).
- `execution_result` accurately reflects step-by-step outcomes.

## Failure Handling

- **Step failure**: applies the step's declared failure behavior (halt /
  fallback / non-fatal); default is halt if undeclared.
- **Quality Gate failure at a gated boundary**: treated as seriously as a
  step failure unless explicitly configured non-fatal.
- **Governance checkpoint unmet**: `implement` halts and reports
  `halted-for-approval`; it does not proceed or bypass.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Workflow Engine Specification](../../engines/WORKFLOW_ENGINE.md)
- [plan](PLAN.md)
- [review](REVIEW.md)
- [test](TEST.md)
