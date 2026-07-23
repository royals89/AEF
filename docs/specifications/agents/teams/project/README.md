# Project Team

## Purpose

Defines the Project team's charter: the three agents responsible for
project coordination, process facilitation, and requirements analysis
across AEF workflows.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules every agent here satisfies.

## Charter

The Project team is accountable for the non-technical coordination that
makes a workflow's technical work land correctly: interpreting what was
actually requested, tracking progress, and facilitating process. Project
agents frequently act at the start of a workflow (before Discovery/
Planning even runs, when a request first needs interpreting) and again at
the end (status reporting), rather than only in the middle like most
Engineering work.

## Members

| Agent | Mandate summary |
|---|---|
| [Project Manager](PROJECT_MANAGER.md) | Tracks progress and coordinates across agents/teams for a given initiative |
| [Scrum Master](SCRUM_MASTER.md) | Facilitates structured process (planning, retrospectives) and removes process blockers |
| [Business Analyst](BUSINESS_ANALYST.md) | Interprets requests into structured, testable requirements |

## Internal Collaboration

The Business Analyst typically acts first, turning a raw request into
requirements the Solution Architect can design against; the Project
Manager tracks the resulting workflow's progress throughout; the Scrum
Master is invoked specifically when a workflow calls for structured
process facilitation (e.g., a multi-step initiative needing a planning
session), not on every workflow by default.

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
