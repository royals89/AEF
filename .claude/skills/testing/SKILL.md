---
name: Testing
description: Best practices for functional, performance, and regression testing within AEF — distinguishing defect categories, testing against requirement intent, and verifying against defined thresholds. Use when verifying a code change, investigating a defect, or checking performance against configured thresholds.
---

# Testing

For use by `qa-engineer`, `performance-engineer`, and any agent verifying
implementation output.

## Core Practices

1. **Test against the original requirement's intent**, not only the
   implementing agent's interpretation of it — a defect can exist in
   correctly-implemented-but-wrong-requirement code.
2. **Categorize defects explicitly**: functional, performance, or
   security. Correct routing depends on this distinction — don't produce
   an undifferentiated list.
3. **State the threshold you're measuring against**, for any performance
   verification — a verdict without a stated threshold isn't actionable.
4. **Reproduce before reporting.** Every defect includes reproduction
   steps sufficient for someone else to verify independently.
5. **Regression matters as much as the fix.** When verifying a fix,
   confirm the original issue is resolved *and* the existing test suite
   still passes.

## Output Shape

- Test report: what was tested, against what requirement/threshold
- Defects found, categorized, with reproduction steps and severity
- Pass/fail verdict per category tested

## Related

- `.claude/shared/CODING_PRINCIPLES.md`
- `.claude/agents/qa-engineer.md`
- `.claude/agents/performance-engineer.md`
- `.claude/commands/test.md`
