# Command: document

**Command ID:** `document`

## Purpose

Routes an implemented change (and, where applicable, its API contract) to
the Documentation team to produce or update project and API reference
documentation.

## Inputs

- Implemented change and its design document
- API specification, where the change includes one (from
  [API Engineer](../../agents/teams/engineering/API_ENGINEER.md))
- Existing project documentation, to update rather than duplicate

## Outputs

- Documentation artifact (from
  [Technical Writer](../../agents/teams/documentation/TECHNICAL_WRITER.md))
- API reference document (from
  [API Documentation Engineer](../../agents/teams/documentation/API_DOCUMENTATION_ENGINEER.md)),
  where applicable

## Preconditions

- Implementation is complete (or, for design-stage documentation, a
  design document exists).

## Workflow

Invokes [Technical Writer](../../agents/teams/documentation/TECHNICAL_WRITER.md)
as a Sequential-handoff step; invokes
[API Documentation Engineer](../../agents/teams/documentation/API_DOCUMENTATION_ENGINEER.md)
specifically when an API contract is present, per
[Documentation Team: Internal Collaboration](../../agents/teams/documentation/README.md#internal-collaboration).

## Success Criteria

- Documentation artifacts satisfy
  [Documentation Standards' required structure](../../../standards/DOCUMENTATION_STANDARDS.md#required-structure).
- API reference matches the API Engineer's contract exactly, per
  [API Documentation Engineer: Quality Gates](../../agents/teams/documentation/API_DOCUMENTATION_ENGINEER.md#quality-gates).

## Failure Handling

- **Existing docs contain an inconsistency the change surfaces**:
  escalated to a human or Enterprise Architect, per
  [Technical Writer: Escalation](../../agents/teams/documentation/TECHNICAL_WRITER.md#escalation).
- **API contract itself is ambiguous**: escalated back to the API
  Engineer, per
  [API Documentation Engineer: Escalation](../../agents/teams/documentation/API_DOCUMENTATION_ENGINEER.md#escalation) —
  never filled with an assumption.

## Related Documents

- [Command Contract](COMMAND_CONTRACT.md)
- [Documentation Team](../../agents/teams/documentation/README.md)
- [implement](IMPLEMENT.md)
- [release](RELEASE.md)
