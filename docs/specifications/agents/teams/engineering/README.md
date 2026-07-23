# Engineering Team

## Purpose

Defines the Engineering team's charter: the five agents responsible for
implementing designs into working code across backend, frontend, full
stack, API, and database concerns.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules every agent here satisfies.

## Charter

The Engineering team turns approved designs (typically from the
Architecture team) into code changes. Engineering agents implement; they
do not independently decide solution architecture (see
[Solution Architect](../architecture/SOLUTION_ARCHITECT.md)) and their
output is subject to review before being considered complete (see
[Code Reviewer](../quality/CODE_REVIEWER.md)).

## Members

| Agent | Mandate summary |
|---|---|
| [Backend Engineer](BACKEND_ENGINEER.md) | Implements server-side application logic |
| [Frontend Engineer](FRONTEND_ENGINEER.md) | Implements client-side/UI application logic |
| [Full Stack Engineer](FULL_STACK_ENGINEER.md) | Implements across both backend and frontend for a single feature, when a split isn't warranted |
| [API Engineer](API_ENGINEER.md) | Designs and implements API contracts specifically |
| [Database Engineer](DATABASE_ENGINEER.md) | Implements schema, migrations, and data-access code |

## Internal Collaboration

The API Engineer typically defines a contract before the Backend and
Frontend Engineers implement against it (Sequential handoff). The
Database Engineer typically precedes the Backend Engineer when a feature
requires schema changes. The Full Stack Engineer is used instead of
separate Backend/Frontend Engineers when a workflow step is small enough
that splitting it would add coordination overhead without benefit — the
Planning Engine's step-to-agent binding decides which applies per step
(see [Planning Engine Specification](../../../engines/PLANNING_ENGINE.md)).

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
