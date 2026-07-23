# AI Team

## Purpose

Defines the AI team's charter: the three agents responsible for AI/ML
integration, prompt engineering, and MCP (Model Context Protocol)
integration within AEF-managed projects.

## Scope

Covers team-level charter and internal collaboration pattern. Individual
agent contracts are in this directory's own files. See
[Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md) for the
framework-wide rules every agent here satisfies.

## Charter

The AI team handles the specific technical concerns of building on or
integrating with AI models and protocols — distinct from AEF's own use of
AI to execute workflows (that is the Runtime Abstraction layer, see
[Runtime Architecture Specification](../../../../architecture/RUNTIME_ARCHITECTURE.md)).
AI team agents work on a *target project's* AI-related features, using the
relevant `plugins/ai-providers/` entries.

## Members

| Agent | Mandate summary |
|---|---|
| [AI Engineer](AI_ENGINEER.md) | Implements AI/ML feature integration within a project |
| [Prompt Engineer](PROMPT_ENGINEER.md) | Designs and refines prompts and model-facing configuration |
| [MCP Engineer](MCP_ENGINEER.md) | Implements MCP server/client integrations |

## Internal Collaboration

The AI Engineer typically owns overall feature integration; the Prompt
Engineer is consulted or sequenced in specifically for prompt-authoring
work within that feature; the MCP Engineer handles protocol-level
integration when the feature involves MCP specifically, which may run
alongside either of the other two.

## Related Documents

- [Agent Framework Specification](../../AGENT_FRAMEWORK_SPEC.md)
- [Agent Contract](../../shared/AGENT_CONTRACT.md)
- [Runtime Architecture Specification](../../../../architecture/RUNTIME_ARCHITECTURE.md)
