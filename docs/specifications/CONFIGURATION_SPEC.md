# Configuration Specification

## Purpose

Defines AEF's configuration model, introduced in full in Sprint 2: how
configuration is structured, how named **profiles** (`enterprise`,
`startup`, `ai-platform`, `trading`) work, and why profile *behavior* is
never hardcoded into framework components.

## Scope

Covers the configuration model and profile mechanism. Does not cover the
specific settings any individual engine reads from configuration — those
are documented in each engine's own specification under
[docs/specifications/engines/](engines/), which reference this document
for the layering and profile rules they follow.

## The Configuration Model

Configuration lives under `config/`:

```
config/
├── schema/                JSON-Schema-style definitions for every config surface
└── profiles/
    ├── enterprise/          Profile-specific configuration values
    ├── startup/
    ├── ai-platform/
    └── trading/
```

This extends the layered configuration approach established in
[Logging & Configuration Standards](../standards/LOGGING_AND_CONFIGURATION_STANDARDS.md#design-decisions--configuration):
framework defaults ship first, a selected profile's values override those
defaults, and project- or environment-specific overrides apply last. A
profile is a named, reusable *layer* in that precedence chain — not a
separate configuration system.

## What a Profile Is

A profile is a **named bundle of configuration values** — nothing more. It
sets things like:

- Which Quality Gates are mandatory versus optional (see
  [Quality Gate Manager Specification](../specifications/engines/QUALITY_GATE_MANAGER.md)).
- Which governance checkpoints require approval (see
  [Security Standards](../standards/SECURITY_STANDARDS.md)).
- How deep Discovery's scans go (see
  [Discovery Engine Specification](../specifications/engines/DISCOVERY_ENGINE.md)).
- Default `plugins/` selections where Discovery's detection is ambiguous.

A profile is **not**:

- A code path. No framework component contains an `if profile ==
  "enterprise"` branch. Every profile-dependent decision is expressed as a
  configuration value that generic engine logic reads, per "Configuration
  over Hardcoding" (see
  [Architecture Specification](../architecture/ARCHITECTURE.md#architecture-principles)).
- A fixed, closed list. `enterprise`, `startup`, `ai-platform`, and
  `trading` are the four profiles scaffolded in Sprint 2 as examples/starting
  points; adding a fifth profile is a configuration change (a new directory
  under `config/profiles/`), not a framework code change.

## The Four Starting Profiles

| Profile | Illustrative emphasis (configuration values only — no hardcoded behavior) |
|---|---|
| `enterprise` | Deeper Discovery scans; more mandatory Quality Gates and governance checkpoints; stricter Security-category plugin defaults |
| `startup` | Lighter-weight gate set; fewer mandatory approval checkpoints; optimized for iteration speed |
| `ai-platform` | AI-Providers-category plugin defaults tuned for model-serving workloads; governance checkpoints around model/data handling |
| `trading` | Stricter change-approval and audit requirements; Security-category plugin defaults tuned for financial-system posture |

The "illustrative emphasis" column is deliberately non-binding — the actual
values live in each profile's `config/profiles/<name>/` directory once
populated (Sprint 2+ implementation), not in this document, so this
specification doesn't drift out of sync with the real configuration values
it describes (see
[Documentation Standards](../standards/DOCUMENTATION_STANDARDS.md#design-decisions):
cross-referencing over duplication).

## Configuration Precedence

From lowest to highest precedence (highest wins on conflict):

1. Framework defaults (`framework/core/` — shipped with AEF itself).
2. Selected profile (`config/profiles/<name>/`).
3. Project-level override (a project's own configuration file at its
   repository root, once the Core Framework's config loader implementation
   defines its exact location in Sprint 2+ follow-through).
4. Environment-specific override (e.g., CI environment variables).

This precedence order is defined once by the Core Framework's config
loader/validator (see
[Architecture Specification](../architecture/ARCHITECTURE.md#core-framework))
and applied uniformly — no engine implements its own precedence logic.

## Schema Validation

Every configuration surface — framework defaults, each profile, project
overrides — validates against a schema in `config/schema/`. Invalid
configuration at any layer fails fast, per
[Logging & Configuration Standards](../standards/LOGGING_AND_CONFIGURATION_STANDARDS.md#design-decisions--configuration),
rather than silently falling back to defaults or partially applying.

## Design Decisions

- **Profiles as data, not code**, per the discussion above — this is the
  central design commitment of this specification and the reason the
  Sprint 2 bootstrap prompt explicitly requires "do not hardcode profile
  behavior."
- **Profiles are additive layers, not mutually exclusive modes.** A project
  could, in principle, layer a custom override on top of a starting profile
  rather than needing a fifth profile defined from scratch for every
  variation — the same precedence chain used for project-level overrides
  handles this without new mechanism.
- **`config/schema/` is separate from `config/profiles/`** so the shape of
  configuration (schema) and specific value sets (profiles) can evolve
  independently — a new profile doesn't require touching the schema unless
  it needs an entirely new configuration field.

## Future Extension Points

- Profile inheritance/composition (e.g., a project-specific profile that
  extends `enterprise` with two overrides) beyond simple layering.
- A profile validation/linting tool in `tools/` that checks a profile
  against `config/schema/` without needing a full AEF run.
- Organization-supplied custom profiles distributed similarly to Domain
  Packs (see [Plugin Standards](../standards/PLUGIN_STANDARDS.md)).

## Related Documents

- [Logging & Configuration Standards](../standards/LOGGING_AND_CONFIGURATION_STANDARDS.md)
- [Architecture Specification](../architecture/ARCHITECTURE.md)
- [Plugin Architecture Specification](../architecture/PLUGIN_ARCHITECTURE.md)
- [Quality Gate Manager Specification](engines/QUALITY_GATE_MANAGER.md)
- [Discovery Engine Specification](engines/DISCOVERY_ENGINE.md)
