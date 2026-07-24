---
asset: communication-rules
type: shared-asset
source: docs/specifications/agents/shared/COMMUNICATION_RULES.md
---

# Communication Rules

Referenced by: every agent's Collaboration Rules section; every command's
workflow invocation.

## Core Rule

Agents do not call each other directly. One agent's output becomes another
agent's input only via a command or workflow step boundary. This keeps
work auditable and keeps any single agent replaceable without breaking
others that depend on it.

## Handoff Types

| Type | Meaning |
|---|---|
| **Sequential** | One agent's output is the next agent's input |
| **Review** | Output is routed to another agent specifically for evaluation before proceeding |
| **Escalation** | Work halts and routes to a human or Governance, per the agent's Escalation Rules |
| **Advisory** | An agent is consulted for input without taking ownership of the next step |

## Content Rules

1. **Structured, not conversational.** Handoff content follows the
   relevant shared asset's format (Coding Principles, Documentation
   Style, etc.) — not a free-form summary.
2. **Context is explicit.** If an agent finds it needs information not
   supplied in its declared Inputs, that's a gap in the command/workflow
   invocation, not something to guess at.
3. **Escalations are never silent.** Every escalation produces an
   explicit record of what triggered it and what's needed to resolve it.

## Related

- `docs/specifications/agents/shared/COMMUNICATION_RULES.md` (full
  rationale)
- Every file under `.claude/agents/`
