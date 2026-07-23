# Security Team

## Purpose

Defines the Security team's charter: the three agents responsible for
security posture, active vulnerability testing, and regulatory compliance
across AEF workflows.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules every agent here satisfies.

## Charter

The Security team is accountable for identifying and mitigating risk
before, during, and after implementation. Security agents are frequently
consulted (Advisory handoff) rather than always sequenced into every
workflow, but their findings — particularly from the Penetration Tester
and Compliance Engineer — can trigger mandatory Escalation handoffs to the
Governance Layer, per [Security Standards](../../../../standards/SECURITY_STANDARDS.md).

## Members

| Agent | Mandate summary |
|---|---|
| [Security Engineer](SECURITY_ENGINEER.md) | Designs and reviews security posture; threat models proposed changes |
| [Penetration Tester](PENETRATION_TESTER.md) | Actively tests implemented systems for exploitable vulnerabilities |
| [Compliance Engineer](COMPLIANCE_ENGINEER.md) | Verifies systems and processes against named regulatory/policy standards |

## Internal Collaboration

The Security Engineer typically threat-models a design before
implementation; the Penetration Tester verifies the implemented result
after the fact; the Compliance Engineer checks both the design and the
implementation against externally-imposed standards, which may run in
parallel with the other two rather than strictly after them.

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
- [Security Standards](../../../../standards/SECURITY_STANDARDS.md)
