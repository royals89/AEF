# .claude/agents

**Status:** Implemented (Sprint 5) — 24 working agent definitions across
8 teams.

Each `.md` file is a loadable Claude Code subagent definition (frontmatter
+ system prompt) implementing the specification from
`docs/specifications/agents/teams/`. Every agent references
`.claude/shared/` for coding, review, security, documentation, and
communication rules rather than duplicating them, and cites its relevant
`.claude/skills/` entries.

See `docs/specifications/agents/AGENT_FRAMEWORK_SPEC.md` for the full
design rationale (contract, lifecycle, capabilities, registration).
