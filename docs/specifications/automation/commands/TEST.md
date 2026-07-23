# Command: test

**Command ID:** `test`

## Purpose

Routes an implemented and reviewed code change to the
[QA Engineer](../../agents/teams/quality/QA_ENGINEER.md) for functional
verification, and to the
[Performance Engineer](../../agents/teams/quality/PERFORMANCE_ENGINEER.md)
when the active `config/` profile mandates performance verification.

## Inputs

- Code change (post-`review`)
- The original requirement, for testing against intent
- Performance thresholds, per the active `config/` profile, if performance
  testing applies

## Outputs

- Test report per
  [QA Engineer: Primary Outputs](../../agents/teams/quality/QA_ENGINEER.md#primary-outputs),
  and a performance findings report where applicable

## Preconditions

- Code change has cleared `review` (or is explicitly supplied for
  standalone testing).

## Workflow

Invokes [QA Engineer](../../agents/teams/quality/QA_ENGINEER.md) as a
Sequential-handoff step; invokes
[Performance Engineer](../../agents/teams/quality/PERFORMANCE_ENGINEER.md)
in parallel or subsequently when the active `config/` profile requires it,
per [Quality Team: Internal Collaboration](../../agents/teams/quality/README.md#internal-collaboration).

## Success Criteria

- Test report distinguishes defects by category (functional, performance,
  security) per
  [QA Engineer: Quality Gates](../../agents/teams/quality/QA_ENGINEER.md#quality-gates).
- No unaddressed functional defect remains when `test` is reported
  complete.

## Failure Handling

- **Functional defect found**: escalated back to the implementing agent,
  per [QA Engineer: Escalation](../../agents/teams/quality/QA_ENGINEER.md#escalation);
  `test` reports incomplete until resolved and re-verified.
- **Performance threshold failure**: escalated to the relevant Engineering
  agent, per
  [Performance Engineer: Escalation](../../agents/teams/quality/PERFORMANCE_ENGINEER.md#escalation).
- **Ambiguous/contradictory requirement discovered during testing**:
  escalated to a human rather than resolved unilaterally.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [QA Engineer](../../agents/teams/quality/QA_ENGINEER.md)
- [Performance Engineer](../../agents/teams/quality/PERFORMANCE_ENGINEER.md)
- [review](REVIEW.md)
- [secure](SECURE.md)
