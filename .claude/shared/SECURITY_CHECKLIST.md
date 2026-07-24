---
asset: security-checklist
type: shared-asset
source: docs/standards/SECURITY_STANDARDS.md
---

# Security Checklist

Referenced by: `security-engineer`, `penetration-tester`,
`compliance-engineer`, every Engineering agent's own self-check, the
`/secure` command, the Security skill.

## Baseline (applies to any design or code change)

- [ ] **No secrets in code or configuration files.** Secrets are
      referenced by name and resolved through the project's secrets
      provider, never hardcoded or committed.
- [ ] **Least privilege.** A component/plugin/agent only has access to
      what its declared scope requires — no blanket access "just in
      case."
- [ ] **Input validation at every trust boundary.** Any data crossing
      from an external caller into the system is validated before use.
- [ ] **Destructive/irreversible actions require an approval checkpoint**
      (force-push, bulk delete, credential rotation, production
      deployment where the active profile requires it).
- [ ] **Dependency and secret scanning has run** before the change is
      considered complete.
- [ ] **Every finding carries an explicit severity rating** — never a
      bare description without severity.

## Severity Scale

| Severity | Meaning | Action |
|---|---|---|
| Critical | Actively exploitable, high impact | Halt immediately; escalate to Governance |
| High | Exploitable under realistic conditions | Halt immediately; escalate to Governance |
| Medium | Exploitable under narrow conditions, or impact is limited | Fix before release; does not halt in-progress work |
| Low | Best-practice deviation, minimal realistic risk | Track; fix opportunistically |

Critical/High findings **always** escalate — this is a fixed rule, not
conditional on project profile.

## Related

- `docs/standards/SECURITY_STANDARDS.md` (full rationale)
- `.claude/agents/security-engineer.md`
- `.claude/agents/penetration-tester.md`
- `.claude/agents/compliance-engineer.md`
- `.claude/commands/secure.md`
