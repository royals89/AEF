# Automation Rules

## Purpose

Defines the rules that automatically connect commands, workflows, events,
hooks, and agents — the mechanism by which, e.g., firing `before-deployment`
actually causes a governance approval check to run, without that check
being hardcoded into the DevOps Engineer, the Workflow Engine, or the
`deploy` command itself.

## Scope

Covers the automation rule contract and the standard rule set this sprint
establishes. Does not cover the underlying hook/event mechanics (see
[Hook Framework](hooks/HOOK_FRAMEWORK.md) and
[Event Catalog](events/EVENT_CATALOG.md)) or workflow step definitions
(see [Workflow Library](workflows/WORKFLOW_LIBRARY.md)). Does not cover
runtime implementation — see
[ADR 0003](../../decisions/0003-automation-specifications-location.md).

## Automation Rule Contract

Every automation rule declares:

| Field | Description |
|---|---|
| **Rule ID** | Unique, kebab-case identifier |
| **Trigger** | The event (see [Event Catalog](events/EVENT_CATALOG.md)) this rule reacts to |
| **Condition** | What must be true about the event's payload for the rule to fire (e.g., "active `config/` profile is `enterprise`") |
| **Action** | What the rule does when triggered and its condition is met — invoke an agent, halt a workflow, emit a notification, write an audit record |
| **Scope** | Which commands/workflows this rule applies to (a rule may be global or scoped to specific ones) |

## Rules Are Configuration, Not Code

Per "Configuration over Hardcoding" (see
[Architecture Principles](../../architecture/ARCHITECTURE.md#architecture-principles)),
automation rules are data a future implementation reads and evaluates —
never inline conditionals added to an engine, agent, or command
specification. This is the entire reason the hook/event layer exists (see
[Automation Architecture: Why This Layering](AUTOMATION_ARCHITECTURE.md#why-this-layering-not-a-simpler-one)):
without it, every new piece of automation behavior would require editing
framework code instead of adding a rule.

## Standard Rule Set

These are the baseline rules this sprint establishes, connecting the
pieces specified above. A future implementation may add project-specific
rules on top; it should not need to remove or contradict these without an
explicit Decision Record, since they encode safety-relevant defaults.

| Rule ID | Trigger | Condition | Action |
|---|---|---|---|
| `gate-deployment-on-quality` | `before-deployment` | Any mandatory Quality Gate for the active `config/` profile has not passed | Halt (per [Hook Framework: Before hooks can halt](hooks/HOOK_FRAMEWORK.md#design-decisions)) |
| `gate-deployment-on-approval` | `before-deployment` | Active `config/` profile requires deployment approval (e.g., `enterprise`, `trading`) | Halt until Governance Layer approval is recorded |
| `route-critical-security-finding` | `escalation.raised` | Escalating agent is a Security team agent and severity is critical/high | Halt any in-flight workflow depending on the affected system; notify Governance Layer |
| `queue-post-generation-review` | `after-generation` | Producing agent's capability category (per [Capability Catalog](../agents/shared/CAPABILITY_CATALOG.md)) is Implementation | Queue the output for `review` |
| `queue-post-implementation-test` | `after-file-modification` | Change is part of an `implement`-triggered workflow | Queue affected scope for `test` once all planned file modifications for the step complete |
| `refresh-profile-on-drift` | `after-file-modification` | Cumulative file modifications since last `analyze` exceed the active `config/` profile's staleness threshold | Trigger incremental `analyze` |
| `annotate-commit-with-workflow` | `after-commit` | Always | Write commit hash and workflow/step reference to Memory Manager workflow history |
| `notify-on-halt` | `workflow.halted` | Always | Emit a notification (channel determined by `config/` profile) to the Project Manager's tracked status |
| `enforce-commit-conventions` | `before-commit` | Commit message or branch name doesn't match [Git & Branching Standards](../../standards/GIT_BRANCHING_STANDARDS.md) | Halt with the specific convention violated |
| `schedule-post-deploy-verification` | `after-deployment` | Deployment succeeded and active `config/` profile requires it (e.g., `trading`) | Trigger `secure` and/or `test` against the deployed environment |

## Rule Evaluation Order

When multiple rules share the same Trigger, they are evaluated in the
order listed in this catalog unless a future implementation's
configuration declares an explicit priority — this catalog's ordering is
itself the default priority, not merely documentation order. A halting
rule (e.g., `gate-deployment-on-quality`) short-circuits evaluation of
subsequent rules on the same trigger, consistent with
[Hook Framework: Before hooks can halt](hooks/HOOK_FRAMEWORK.md#rules).

## Design Decisions

- **A fixed baseline rule set, extensible but not removable without an
  ADR.** This mirrors the [Review Checklist](../agents/shared/REVIEW_CHECKLIST.md)'s
  baseline-plus-extension pattern: project-specific rules add to this set;
  they don't silently override safety-relevant defaults like
  `gate-deployment-on-quality`.
- **Rules reference Capability Catalog categories and `config/` profile
  fields, never a specific agent or plugin by name**, consistent with
  "Configuration over Hardcoding" and the Planning Engine's own
  capability-driven discovery (see
  [Agent Framework Specification: Registration and Discovery](../agents/AGENT_FRAMEWORK_SPEC.md#5-registration-and-discovery)) —
  this keeps rules valid even as specific agents/plugins are added or
  swapped.

## Future Extension Points

- Rule authoring interface/schema, once automation rules are implemented
  (a future sprint).
- Per-project custom rules layered via the same precedence mechanism
  already defined for configuration (see
  [Configuration Specification: Configuration Precedence](../CONFIGURATION_SPEC.md#configuration-precedence)).
- Rule conflict detection (two rules with contradictory Actions on the
  same Trigger/Condition) — noted here as a gap this sprint's design
  doesn't yet resolve mechanically, only by evaluation order.

## Related Documents

- [Automation Architecture](AUTOMATION_ARCHITECTURE.md)
- [Hook Framework](hooks/HOOK_FRAMEWORK.md)
- [Event Catalog](events/EVENT_CATALOG.md)
- [Workflow Library](workflows/WORKFLOW_LIBRARY.md)
- [Configuration Specification](../CONFIGURATION_SPEC.md)
