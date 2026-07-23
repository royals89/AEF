# .claude/agents

**Status:** Not yet implemented (Sprint 3 — specifications complete, no loadable definitions yet)

This directory will hold loadable Claude Code agent definitions, once a
future sprint converts the specifications in
[`docs/specifications/agents/`](../../docs/specifications/agents/) into
actual runtime definitions Claude Code can load. See
[ADR 0002](../../docs/decisions/0002-agent-specifications-location.md) for
why the specifications live in `docs/` rather than here during Sprint 3,
and the [Agent Framework Specification's lifecycle](../../docs/specifications/agents/AGENT_FRAMEWORK_SPEC.md#2-agent-lifecycle)
for the Specified → Registered → Invoked → Retired progression this
directory is the "Registered" implementation of.

Populated starting a future sprint per
[`docs/roadmap/ROADMAP.md`](../../docs/roadmap/ROADMAP.md), and requires
explicit approval before work starts.
