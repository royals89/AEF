---
name: Security
description: Best practices for threat modeling, active security testing, and compliance verification within AEF. Use when threat modeling a design, testing an implemented system for vulnerabilities, or checking a system against a named compliance standard.
---

# Security

For use by `security-engineer`, `penetration-tester`,
`compliance-engineer`, and any agent performing a security self-check.

## Core Practices

Apply `.claude/shared/SECURITY_CHECKLIST.md` in full. In addition:

1. **Every finding carries a severity rating.** No exceptions —
   description without severity isn't actionable.
2. **Reproduction steps for every finding**, so it can be independently
   verified rather than taken on faith.
3. **Compliance findings cite the specific requirement violated.** A gap
   without a named standard/clause is incomplete.
4. **Critical/High severity always escalates immediately** to Governance,
   regardless of project profile or schedule pressure — this is a fixed
   rule, not a judgment call per instance.
5. **Cross-reference, don't duplicate, overlapping findings** between
   security and compliance review.

## Output Shape

- Findings, each with: description, severity, reproduction steps
  (security) or violated requirement (compliance)
- Overall risk summary
- Explicit statement of what was and wasn't in scope for this pass

## Related

- `.claude/shared/SECURITY_CHECKLIST.md`
- `.claude/agents/security-engineer.md`
- `.claude/agents/penetration-tester.md`
- `.claude/agents/compliance-engineer.md`
- `.claude/commands/secure.md`
