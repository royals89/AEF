---
name: Architecture
description: Best practices for solution and enterprise-level technical design within AEF — evaluating alternatives, documenting rationale, checking cross-project consistency, and identifying integration points. Use when designing a solution, reviewing a design against organizational standards, or assessing architectural risk.
---

# Architecture

For use by `solution-architect` and `enterprise-architect`, and any agent
consulting on design-level decisions.

## Core Practices

1. **State alternatives, not just the choice.** A design that shows only
   the selected approach is incomplete — document what else was
   considered and why it lost out.
2. **Check integration points against actual project state.** Don't
   assume a dependency graph; verify against the current project profile.
3. **Distinguish project-level from organization-level concerns.**
   Solution-level design optimizes for this requirement; enterprise-level
   review checks consistency with standards beyond this one project.
4. **Cross-project patterns are a resource, not a constraint to
   rediscover.** Check prior architectural decisions before proposing a
   new pattern from scratch.
5. **Cite the specific standard when rejecting or conditioning a
   design.** "This doesn't fit" is not a verdict; "this conflicts with
   [standard], specifically because..." is.

## Design Document Shape

- Requirement summary
- Chosen approach
- Alternatives considered, and why each was not chosen
- New integration points introduced
- Risk/tradeoff summary

## Related

- `.claude/skills/ai-engineering-core/SKILL.md`
- `.claude/agents/solution-architect.md`
- `.claude/agents/enterprise-architect.md`
- `docs/specifications/agents/teams/architecture/`
