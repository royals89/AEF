# Security Standards

## Purpose

Defines the security baseline for AEF itself and for any project AEF
operates on, in service of the "Security by Design" architecture principle
(see [Architecture Specification](../architecture/ARCHITECTURE.md#architecture-principles)).

## Scope

Covers secure-by-default requirements for framework components, Domain
Packs, and the Governance Layer's security-relevant responsibilities. Does
not cover the security posture of individual downstream projects that adopt
AEF — that remains those projects' responsibility, informed by these
standards.

## Responsibilities

- The **Governance Layer** owns policy definition and enforcement (which
  actions require approval, what gets audited).
- The **Plugin Manager** owns the sandboxing boundary between the core and
  Domain Packs.
- Every component owner is responsible for threat-modeling their component
  before implementation begins in Sprint 2.

## Design Decisions

- **No secrets in configuration files.** Configuration schemas (see
  [Architecture Specification](../architecture/ARCHITECTURE.md#core-framework))
  must never include a field intended to hold a secret value directly;
  secrets are referenced by name and resolved through a secrets-provider
  interface (defined in Sprint 2).
- **Least privilege for Domain Packs.** A Domain Pack only receives access
  to the extension points it declares in its manifest — not blanket access
  to `framework/` internals.
- **Approval gates for destructive or irreversible actions.** The Workflow
  Engine must route any step classified as destructive (e.g., force-push,
  bulk delete, credential rotation) through a Governance Layer approval
  checkpoint before execution.
- **Audit by default.** Every governance decision (approved, rejected,
  auto-approved-by-policy) is written to the audit trail; audit logging is
  not optional per-component.

## Baseline Requirements (Sprint 2+ implementation)

1. Dependency scanning is part of the default Quality Gate set.
2. Static analysis / secret-scanning runs before any commit AEF generates is
   considered complete.
3. Domain Packs are versioned and their compatibility/integrity checked
   before loading (see [Architecture Specification](../architecture/ARCHITECTURE.md#plugin-manager--domain-packs)).
4. Any AEF component that calls out to an external service does so through
   a declared, reviewable interface — no ad-hoc network calls buried in
   business logic.

## Future Extension Points

- Formal threat model per component, produced at the start of Sprint 2.
- Pluggable secrets-provider backends (local, vault, cloud KMS).
- Configurable governance policies per organization (e.g., stricter
  approval requirements for regulated industries via a Domain Pack).

## Related Documents

- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Testing Standards](TESTING_STANDARDS.md)
- [Review Standards](REVIEW_STANDARDS.md)
- [Decision Log Template](../decisions/DECISION_LOG_TEMPLATE.md)
