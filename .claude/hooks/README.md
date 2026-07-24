# .claude/hooks

**Status:** Implemented (Sprint 5) — 12 lifecycle hook scripts plus a
manifest wiring them to invocation points.

Each `.sh` file implements one lifecycle hook from
`docs/specifications/automation/hooks/HOOK_FRAMEWORK.md`. Before-hooks
exit non-zero to halt; after-hooks are observation-only and never block
(consistent with the Hook Framework's fixed rule).

Commands under `.claude/commands/` invoke the relevant hook script at the
matching point in their own instructions. `hooks-manifest.json` documents
which command invokes which hook, and notes optional wiring into Claude
Code's native `PreToolUse`/`PostToolUse` hook events via
`.claude/settings.json` for the hooks where that correspondence is
natural (file modification and commit hooks).

See `docs/specifications/automation/hooks/HOOK_FRAMEWORK.md` for full
rationale and `docs/specifications/automation/AUTOMATION_RULES.md` for the
baseline rules these hooks enforce by default.
