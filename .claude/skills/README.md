# .claude/skills

**Status:** Implemented (Sprint 5) — 6 reusable skills.

Each subdirectory is a Claude Code Skill (`SKILL.md` with frontmatter +
guidance). `ai-engineering-core` is the baseline every AEF task loads
first; the other five (`architecture`, `implementation`, `review`,
`testing`, `security`) provide team-specific practices and are cited by
the relevant agents under `.claude/agents/`.

Skills reference `.claude/shared/` for concrete checklists/standards
rather than duplicating them.
