# Workflow: Documentation

## Definition

| Field | Value |
|---|---|
| **Name** | `documentation` |
| **Description** | Produces or updates documentation independent of a code-change workflow, for when documentation has fallen behind implementation. |
| **Trigger** | `document` command (see [document](../commands/DOCUMENT.md)) |
| **Inputs** | The scope of documentation needed (a component, feature, or the project as a whole); existing documentation to reconcile against |

## Steps

1. **Assess documentation gap** — Technical Writer compares existing docs
   against the current `project_profile` and recent workflow history (via
   Memory Manager) to identify what's stale or missing.
2. **Document** — Technical Writer produces/updates general documentation;
   API Documentation Engineer produces/updates API reference where an API
   contract is in scope.
3. **Review** — Code Reviewer reviews documentation embedded in code
   (e.g., inline comments); a human or Enterprise Architect resolves any
   inconsistency step 1 surfaced between existing docs, per
   [Technical Writer: Escalation](../../agents/teams/documentation/TECHNICAL_WRITER.md#escalation).

## Quality Gates

- [Documentation Standards' required structure](../../../standards/DOCUMENTATION_STANDARDS.md#required-structure)
  applies to every artifact produced in step 2.
- API reference (where produced) matches its source contract exactly, per
  [API Documentation Engineer: Quality Gates](../../agents/teams/documentation/API_DOCUMENTATION_ENGINEER.md#quality-gates).

## Governance

- No mandatory checkpoint by default — documentation workflows are
  typically low-risk. An active `config/` profile may still require
  review for documentation touching compliance-sensitive material (cross-
  reference with Compliance Engineer if step 1 surfaces this).

## Failure Behavior

- Step 1 surfaces a genuine inconsistency between existing docs (not just
  staleness): escalates per
  [Technical Writer: Escalation](../../agents/teams/documentation/TECHNICAL_WRITER.md#escalation) —
  workflow pauses on the inconsistent section rather than picking a
  version unilaterally, while proceeding on unaffected sections.
- Step 2's API documentation source contract is ambiguous: escalates back
  to the API Engineer, per
  [API Documentation Engineer: Escalation](../../agents/teams/documentation/API_DOCUMENTATION_ENGINEER.md#escalation).

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [Documentation Team](../../agents/teams/documentation/README.md)
- [document command](../commands/DOCUMENT.md)
