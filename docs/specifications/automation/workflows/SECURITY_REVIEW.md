# Workflow: Security Review

## Definition

| Field | Value |
|---|---|
| **Name** | `security-review` |
| **Description** | Threat models, actively tests, and verifies compliance for a system or change, with findings as the primary deliverable rather than a code change. |
| **Trigger** | `secure` command (see [secure](../commands/SECURE.md)), or scheduled per the active `config/` profile |
| **Inputs** | The system/design/change in scope; applicable compliance standard(s) per `config/` profile |

## Steps

1. **Threat model** — Security Engineer produces a threat model of the
   scoped system/design.
2. **Test** — Penetration Tester actively tests the implemented system
   (skipped if scope is design-only, pre-implementation).
3. **Verify compliance** — Compliance Engineer checks against named
   standards, potentially in parallel with steps 1–2, per
   [Security Team: Internal Collaboration](../../agents/teams/security/README.md#internal-collaboration).
4. **Consolidate findings** — findings from all three agents are
   cross-referenced (not duplicated) into a single findings report.

## Quality Gates

- Every finding across steps 1–3 carries an explicit severity rating, per
  each agent's own Quality Gates
  ([Security Engineer](../../agents/teams/security/SECURITY_ENGINEER.md#quality-gates),
  [Penetration Tester](../../agents/teams/security/PENETRATION_TESTER.md#quality-gates)).
- Step 3's findings cite the specific requirement violated, per
  [Compliance Engineer: Quality Gates](../../agents/teams/security/COMPLIANCE_ENGINEER.md#quality-gates).

## Governance

- Any critical/high severity finding, or any confirmed mandatory-standard
  compliance gap, escalates immediately to the Governance Layer — this is
  not conditional on the `config/` profile; it is the fixed rule stated in
  every Security team agent's own Escalation clause.

## Failure Behavior

- This workflow does not "fail" on finding issues — findings are its
  intended output. It fails only if a step cannot complete at all (e.g.,
  Penetration Tester cannot access a test environment), in which case the
  workflow halts and reports the blocker rather than producing an
  incomplete findings report presented as final.
- A critical/high finding halts any *other* in-flight workflow that
  depends on the affected system (e.g., a `deploy` in progress), per
  [deploy command: Failure Handling](../commands/DEPLOY.md#failure-handling) —
  this cross-workflow halt is coordinated via the `escalation.raised`
  event (see [Event Catalog](../events/EVENT_CATALOG.md#state-change-events-not-hook-derived)).

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [Security Team](../../agents/teams/security/README.md)
- [secure command](../commands/SECURE.md)
- [Event Catalog](../events/EVENT_CATALOG.md)
