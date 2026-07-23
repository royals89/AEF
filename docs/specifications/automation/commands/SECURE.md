# Command: secure

**Command ID:** `secure`

## Purpose

Routes a design or implemented change through the Security team — threat
modeling, active testing, and compliance verification — per
[Security Standards](../../../standards/SECURITY_STANDARDS.md).

## Inputs

- Solution design (for threat modeling) or implemented/deployed system
  (for penetration testing)
- The specific compliance standard(s) applicable, per the active
  `config/` profile

## Outputs

- Threat model artifact (from
  [Security Engineer](../../agents/teams/security/SECURITY_ENGINEER.md))
- Findings report with severity ratings (from
  [Penetration Tester](../../agents/teams/security/PENETRATION_TESTER.md))
- Compliance findings report (from
  [Compliance Engineer](../../agents/teams/security/COMPLIANCE_ENGINEER.md))

## Preconditions

- A design exists (for threat modeling) or an implemented/deployed system
  exists (for penetration testing) — `secure` adapts which Security agents
  it invokes based on what stage of the workflow it's called from.

## Workflow

Invokes the relevant [Security team](../../agents/teams/security/README.md)
agents as Advisory or Sequential handoffs depending on invocation point,
per
[Security Team: Internal Collaboration](../../agents/teams/security/README.md#internal-collaboration).

## Success Criteria

- Every finding produced carries an explicit severity rating (per
  [Security Engineer: Quality Gates](../../agents/teams/security/SECURITY_ENGINEER.md#quality-gates)
  and
  [Penetration Tester: Quality Gates](../../agents/teams/security/PENETRATION_TESTER.md#quality-gates)).
- Compliance findings cite the specific requirement violated, per
  [Compliance Engineer: Quality Gates](../../agents/teams/security/COMPLIANCE_ENGINEER.md#quality-gates).

## Failure Handling

- **Critical/high severity finding**: escalates immediately to the
  Governance Layer, per each Security agent's own Escalation clause — the
  workflow does not proceed past such a finding without sign-off.
- **Confirmed mandatory-standard compliance gap**: escalates to the
  Governance Layer per
  [Compliance Engineer: Escalation](../../agents/teams/security/COMPLIANCE_ENGINEER.md#escalation).

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Security Team](../../agents/teams/security/README.md)
- [Security Standards](../../../standards/SECURITY_STANDARDS.md)
- [test](TEST.md)
- [deploy](DEPLOY.md)
