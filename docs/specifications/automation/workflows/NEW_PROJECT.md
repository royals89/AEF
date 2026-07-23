# Workflow: New Project

## Definition

| Field | Value |
|---|---|
| **Name** | `new-project` |
| **Description** | Establishes AEF management of a repository from scratch: structure, configuration, and an initial project profile. |
| **Trigger** | `bootstrap` command (see [bootstrap](../commands/BOOTSTRAP.md)) |
| **Inputs** | `target_path`, `profile` (optional) |

## Steps

1. **Scaffold** — Bootstrap Engine creates structure and seeds
   configuration (see
   [Bootstrap Engine Specification](../../engines/BOOTSTRAP_ENGINE.md)).
2. **Discover** — Discovery Engine runs an initial full scan, producing
   the first `project_profile`.
3. **Baseline document** — Technical Writer produces an initial project
   README/overview, referencing the seeded configuration and detected
   stack (Sequential handoff, per
   [Communication Rules](../../agents/shared/COMMUNICATION_RULES.md#handoff-types)).

## Quality Gates

- [Review Checklist](../../agents/shared/REVIEW_CHECKLIST.md) baseline
  applies to the Technical Writer's output.
- Step 1 and 2 are engine steps, not agent steps, and are gated by
  [Bootstrap Engine Success Criteria](../../engines/BOOTSTRAP_ENGINE.md#lifecycle)
  and
  [Discovery Engine outputs being non-corrupt](../../engines/DISCOVERY_ENGINE.md#error-handling)
  respectively, rather than the agent-output checklist.

## Governance

- No mandatory governance checkpoint by default. The active `config/`
  profile may add one (e.g., `enterprise` requiring sign-off before a new
  project is AEF-managed) — this workflow does not assume a checkpoint
  where the profile doesn't declare one, per
  [Configuration Specification: Profiles as data, not code](../../CONFIGURATION_SPEC.md#design-decisions).

## Failure Behavior

- Step 1 failure (conflict) halts the workflow per
  [Bootstrap Engine error handling](../../engines/BOOTSTRAP_ENGINE.md#error-handling) —
  steps 2–3 do not run against a partially-conflicted scaffold.
- Step 2 failure is non-fatal to the workflow (per
  [bootstrap command failure handling](../commands/BOOTSTRAP.md#failure-handling))
  but blocks step 3, since the Technical Writer's baseline document
  depends on a project profile.

## Related Documents

- [Workflow Library](WORKFLOW_LIBRARY.md)
- [bootstrap command](../commands/BOOTSTRAP.md)
- [Bootstrap Engine Specification](../../engines/BOOTSTRAP_ENGINE.md)
