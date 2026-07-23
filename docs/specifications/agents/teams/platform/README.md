# Platform Team

## Purpose

Defines the Platform team's charter: the three agents responsible for
deployment automation, cloud infrastructure, and internal developer
platform concerns.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules every agent here satisfies.

## Charter

The Platform team is accountable for how implemented changes actually
run: deployment pipelines, cloud resources, and the shared tooling that
other agents' work depends on. Platform agents typically act after
Engineering and Quality agents have produced and verified a change, but
before it reaches production.

## Members

| Agent | Mandate summary |
|---|---|
| [DevOps Engineer](DEVOPS_ENGINEER.md) | Builds and maintains deployment pipelines and release automation |
| [Cloud Engineer](CLOUD_ENGINEER.md) | Designs and provisions cloud infrastructure |
| [Platform Engineer](PLATFORM_ENGINEER.md) | Maintains internal developer platform tooling and standards |

## Internal Collaboration

The Cloud Engineer typically provisions infrastructure that the DevOps
Engineer's pipelines deploy into; the Platform Engineer maintains the
shared tooling both rely on and is consulted (Advisory handoff) when a
platform-level standard is implicated by either agent's work.

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
