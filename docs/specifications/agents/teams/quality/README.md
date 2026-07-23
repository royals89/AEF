# Quality Team

## Purpose

Defines the Quality team's charter: the three agents responsible for
functional correctness, performance validation, and code review across AEF
workflows.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules every agent here satisfies.

## Charter

The Quality team is the primary implementer of the
[Review Checklist](../../shared/REVIEW_CHECKLIST.md) and a direct
operational link to the [Quality Gate Manager](../../../engines/QUALITY_GATE_MANAGER.md):
Quality agents' verdicts frequently *are* the gate result the Quality Gate
Manager reports, rather than being a separate parallel check.

## Members

| Agent | Mandate summary |
|---|---|
| [QA Engineer](QA_ENGINEER.md) | Verifies functional correctness through test execution and exploratory testing |
| [Performance Engineer](PERFORMANCE_ENGINEER.md) | Verifies performance characteristics against defined thresholds |
| [Code Reviewer](CODE_REVIEWER.md) | Reviews code changes for correctness, standards compliance, and maintainability |

## Internal Collaboration

The Code Reviewer typically reviews a change immediately after
implementation; the QA Engineer verifies it functionally, often against a
broader test suite than the implementing agent's own unit tests; the
Performance Engineer is invoked specifically when the workflow or the
active `config/` profile requires performance verification (not on every
change by default).

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
- [Quality Gate Manager Specification](../../../engines/QUALITY_GATE_MANAGER.md)
