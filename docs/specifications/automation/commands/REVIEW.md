# Command: review

**Command ID:** `review`

## Purpose

Routes an implemented code change to the
[Code Reviewer](../../agents/teams/quality/CODE_REVIEWER.md) agent for
evaluation against [Coding Standards](../../../standards/CODING_STANDARDS.md)
and the [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md).

## Inputs

- Code change (from an `implement` step or supplied directly)
- The design/contract the change implements against, for correctness
  comparison

## Outputs

- Review comments plus verdict (approve / request-changes), per
  [Code Reviewer: Primary Outputs](../../agents/teams/quality/CODE_REVIEWER.md#primary-outputs)

## Preconditions

- A code change exists to review (either freshly produced by `implement`
  or explicitly supplied).

## Workflow

Invokes the [Code Reviewer](../../agents/teams/quality/CODE_REVIEWER.md)
agent as a Review-handoff step (per
[Communication Rules](../../agents/shared/COMMUNICATION_RULES.md#handoff-types)),
mediated by the Workflow Engine — `review` does not call the Code Reviewer
directly, consistent with
[Communication Rules: agents do not call each other directly](../../agents/shared/COMMUNICATION_RULES.md#core-rule-agents-do-not-call-each-other-directly).

## Success Criteria

- A verdict is produced (approve or request-changes) with review comments
  satisfying the [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md)
  baseline.

## Failure Handling

- **No code change supplied**: halts before invoking the Code Reviewer.
- **Request-changes verdict**: routed back to the implementing agent (per
  [Code Reviewer: Escalation](../../agents/teams/quality/CODE_REVIEWER.md#escalation));
  the `review` command itself is not "failed" by a request-changes
  outcome — that is a normal, successful review result.
- **Unresolvable review disagreement**: escalated to a human, per
  [Code Reviewer: Escalation](../../agents/teams/quality/CODE_REVIEWER.md#escalation).

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Code Reviewer](../../agents/teams/quality/CODE_REVIEWER.md)
- [implement](IMPLEMENT.md)
- [test](TEST.md)
