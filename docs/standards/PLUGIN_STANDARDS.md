# Plugin Standards

## Purpose

Defines what a Domain Pack must provide to be loadable by AEF's Plugin
Manager, in service of the "Plugin-based Architecture" principle.

## Scope

Applies to all Domain Packs under `domain-packs/`. Does not apply to the
Plugin Manager's own implementation (see
[Coding Standards](CODING_STANDARDS.md) for that).

## Responsibilities

Each Domain Pack owner is responsible for their pack meeting this standard
before it is added to `domain-packs/`; the Plugin Manager is responsible for
rejecting, not silently ignoring, a pack that doesn't.

## Design Decisions

- **Manifest required.** Every Domain Pack declares, in a manifest at its
  root: its name, SemVer version (see
  [Versioning Strategy](VERSIONING_STRATEGY.md)), the AEF core version
  range it's compatible with, and the extension points it attaches to.
- **No reaching into core internals.** A Domain Pack interacts with AEF
  exclusively through the extension-point interfaces published by
  `framework/shared/`. Direct imports of `framework/<component>/` internals
  are a standards violation, not a style preference — it's what keeps the
  core replaceable per the "Modular Components" principle.
- **Self-contained.** A Domain Pack's dependencies are scoped to itself; it
  does not assume or require another specific Domain Pack be present unless
  explicitly declared as a dependency in its manifest.
- **Contract-tested.** Per [Testing Standards](TESTING_STANDARDS.md), every
  Domain Pack ships a contract test suite proving it satisfies the
  extension-point interfaces it claims to implement.

## Minimum Pack Structure (Sprint 3+)

```
domain-packs/<pack-name>/
├── manifest.<ext>       Pack metadata and compatibility declaration
├── README.md             Purpose, scope, usage
├── src/                    Implementation
└── tests/                   Contract + unit tests
```

## Future Extension Points

- A pack registry/discovery mechanism beyond the local `domain-packs/`
  directory (e.g., pulling packs from an external registry).
- Formal pack certification levels (community vs. verified).

## Related Documents

- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Versioning Strategy](VERSIONING_STRATEGY.md)
- [Testing Standards](TESTING_STANDARDS.md)
