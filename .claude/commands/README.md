# .claude/commands

**Status:** Implemented (Sprint 5) — 11 working slash commands.

Each `.md` file is a loadable Claude Code command implementing the
specification from `docs/specifications/automation/commands/`. Commands
invoke agents under `.claude/agents/` and, where applicable, the workflows
catalogued in `docs/specifications/automation/workflows/WORKFLOW_LIBRARY.md`.

Note: Sprint 4 specified 12 commands including `release`; Sprint 5's
implementation scope named 11, omitting `release`. See the Sprint 5
completion report for this gap — `release`'s specification
(`docs/specifications/automation/commands/RELEASE.md`) is unimplemented
pending explicit direction.

See `docs/specifications/automation/AUTOMATION_ARCHITECTURE.md` for the
full design rationale.
