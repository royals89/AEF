---
name: Implementation
description: Best practices for writing code against an approved design — backend, frontend, full-stack, API, database, infrastructure, and AI-feature implementation. Use whenever producing a code change, migration, pipeline configuration, or prompt/config change.
---

# Implementation

For use by Backend, Frontend, Full Stack, API, Database, DevOps, Cloud,
Platform, AI, Prompt, and MCP Engineers.

## Core Practices

Follow `.claude/shared/CODING_PRINCIPLES.md` for every change. In
addition:

1. **Implement against the contract you were given, not your own
   interpretation of it.** If the design or API contract doesn't cover a
   case you hit, escalate back rather than inventing behavior.
2. **Match the detected stack.** Use the project's actual language,
   framework, and conventions (from the project profile) — don't impose
   an unrelated pattern because it's more familiar.
3. **Schema/infrastructure changes need a rollback path stated up front**,
   before the change is considered complete, not added afterward if asked.
4. **State failure/fallback behavior explicitly** for anything that calls
   an external system (API, AI provider, cloud resource) — a call without
   defined failure handling is incomplete.
5. **Tests are part of the change, not a follow-up task.**

## Output Shape

- The code/config change itself
- What it implements against (design/contract reference)
- Tests included
- Any explicit gaps or assumptions flagged for review

## Related

- `.claude/shared/CODING_PRINCIPLES.md`
- `.claude/skills/testing/SKILL.md`
- `.claude/agents/backend-engineer.md` (and other Engineering/Platform/AI
  team agents)
- `docs/specifications/agents/teams/engineering/`
