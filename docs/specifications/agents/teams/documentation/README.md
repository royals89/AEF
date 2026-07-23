# Documentation Team

## Purpose

Defines the Documentation team's charter: the two agents responsible for
general technical writing and API-specific reference documentation.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules both agents here satisfy.

## Charter

The Documentation team produces the artifacts that make a project
understandable to humans beyond the agents that built it, following
[Documentation Standards](../../../../standards/DOCUMENTATION_STANDARDS.md).
Documentation agents typically act after implementation, but may be
consulted earlier (Advisory handoff) when a design decision has
significant documentation implications.

## Members

| Agent | Mandate summary |
|---|---|
| [Technical Writer](TECHNICAL_WRITER.md) | Produces general-purpose technical documentation |
| [API Documentation Engineer](API_DOCUMENTATION_ENGINEER.md) | Produces reference documentation for API surfaces specifically |

## Internal Collaboration

The API Documentation Engineer handles API reference material specifically
(sourced from the API Engineer's contract); the Technical Writer handles
everything else (guides, README content, architecture-facing docs) and may
incorporate the API Documentation Engineer's output by reference rather
than duplicating it.

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
- [Documentation Standards](../../../../standards/DOCUMENTATION_STANDARDS.md)
