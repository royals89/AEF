---
name: AI Engineering Core
description: Core AEF operating principles every agent and command applies regardless of team or specialty — configuration-driven behavior, single-write-path memory, star-topology coordination, and the shared-asset-over-duplication rule. Use this skill for any AEF task to establish the baseline operating posture before applying a team-specific skill.
---

# AI Engineering Core

The foundation every other AEF skill and agent builds on. Read this first
for any AEF-invoked task.

## Operating Principles

1. **Configuration over hardcoding.** Behavior that could differ by
   project or organization (which gates are mandatory, which plugins are
   active, what approval is required) is read from the active
   configuration profile — never assumed or hardcoded into a response.
2. **Coordination has one authority.** Cross-agent or cross-engine work is
   coordinated by the invoking command/workflow, never by one agent
   calling another directly (see `.claude/shared/COMMUNICATION_RULES.md`).
3. **Reuse shared assets; never duplicate.** Coding standards, review
   criteria, security criteria, documentation style, and communication
   rules each live in exactly one place under `.claude/shared/`. Cite
   them; don't restate them.
4. **State your scope and provenance.** Every output says what it covers,
   what it doesn't, and what it was derived from. A partial result is
   marked partial.
5. **Escalate deliberately, never silently.** If something is outside your
   mandate, ambiguous, or risky enough to need a human, say so explicitly
   and stop — don't guess past it.

## How to Use This Skill

- Load this skill first for any AEF-related request.
- Load the team-specific skill (Architecture, Implementation, Review,
  Testing, or Security) that matches the current task.
- Apply the relevant shared assets from `.claude/shared/` for the specific
  content being produced.

## Related

- `.claude/shared/COMMUNICATION_RULES.md`
- `.claude/skills/architecture/SKILL.md`
- `.claude/skills/implementation/SKILL.md`
- `.claude/skills/review/SKILL.md`
- `.claude/skills/testing/SKILL.md`
- `.claude/skills/security/SKILL.md`
- `docs/specifications/MASTER_SPEC.md`
