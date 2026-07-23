# Command Contract

## Purpose

Defines the single contract every AEF command satisfies, so the 12
commands specified this sprint (bootstrap, analyze, plan, implement,
review, test, secure, document, deploy, release, doctor, update) are
consistent and composable rather than 12 independently-shaped
descriptions. Mirrors the role the
[Agent Contract](../../agents/shared/AGENT_CONTRACT.md) plays for agents.

## Scope

Covers the fields every command specification must include. Does not
cover a specific command's actual content for those fields — see
[docs/specifications/automation/commands/](.) for each command's own file.
Does not cover runtime execution of commands — see
[ADR 0003](../../../decisions/0003-automation-specifications-location.md)
for why this sprint is specification-only.

## Contract Fields

Every command specification declares the following, in this order:

| Field | Description |
|---|---|
| **Command ID** | Unique, kebab-case identifier (e.g., `implement`) |
| **Purpose** | One or two sentences: what invoking this command accomplishes |
| **Inputs** | What the command needs to run (explicit — never assumed context) |
| **Outputs** | What the command produces on completion |
| **Preconditions** | What must be true before the command can run (e.g., a prior command's output must exist) |
| **Workflow** | Which [Workflow Library](../workflows/WORKFLOW_LIBRARY.md) entry (or Engineering Orchestrator invocation) the command triggers, and the engines/agents involved |
| **Success Criteria** | The specific, checkable conditions under which the command is considered to have succeeded |
| **Failure Handling** | What happens when a precondition isn't met, or the triggered workflow fails partway |

## Rules

1. **A command is a trigger, not a workflow implementation.** Per
   [Automation Architecture](../AUTOMATION_ARCHITECTURE.md#commands-trigger-workflows-they-are-not-workflows),
   a command's "Workflow" field names which
   [Workflow Library](../workflows/WORKFLOW_LIBRARY.md) entry it invokes —
   it does not redefine that workflow's steps inline. This mirrors the
   Agent Contract's rule that agents cite the Capability Catalog rather
   than defining capabilities inline.
2. **Preconditions are checked, not assumed.** A command specification
   states what must be true before it runs; per
   [Failure Handling defaults](#failure-handling-defaults) below, an unmet
   precondition is a defined failure mode, not undefined behavior.
3. **Every command has explicit Success Criteria.** "The command ran
   without error" is not sufficient — criteria must be specific enough
   that the [Quality Gate Manager](../../engines/QUALITY_GATE_MANAGER.md)
   or a human could verify them independently.

## Failure Handling Defaults

Unless a command's own specification states otherwise:

- **Unmet precondition** → the command does not start; it reports which
  precondition failed and what would satisfy it.
- **Triggered workflow fails partway** → the command surfaces the
  Workflow Engine's `execution_result` (per
  [Workflow Engine Specification](../../engines/WORKFLOW_ENGINE.md#outputs))
  as-is; it does not retry automatically unless its own specification
  defines a retry rule.
- **Governance checkpoint halts the workflow** → the command reports
  `halted-for-approval`, consistent with the
  [Engineering Orchestrator's error handling](../../engines/ENGINEERING_ORCHESTRATOR.md#error-handling).

## Design Decisions

- **Contract-first, not command-first**, for the same reason the Agent
  Contract precedes individual agent specifications: every command
  specification is written by filling in this contract, never the
  reverse.
- **Commands are thin triggers over the Workflow Library.** This keeps the
  Command Framework from becoming a second, parallel place where workflow
  logic is defined — see
  [Automation Architecture](../AUTOMATION_ARCHITECTURE.md) for the full
  layering rationale.

## Future Extension Points

- A machine-readable (schema) form of this contract, once commands are
  implemented as loadable `.claude/commands/` definitions in a future
  sprint.
- Command versioning, mirroring
  [Agent Framework Specification: Versioning](../../agents/AGENT_FRAMEWORK_SPEC.md#6-versioning).

## Related Documents

- [Automation Architecture](../AUTOMATION_ARCHITECTURE.md)
- [Workflow Library](../workflows/WORKFLOW_LIBRARY.md)
- [Agent Contract](../../agents/shared/AGENT_CONTRACT.md)
- [Engineering Orchestrator Specification](../../engines/ENGINEERING_ORCHESTRATOR.md)
