---
description: Move a verified change into a running environment via deployment automation.
argument-hint: [target environment]
---

# /deploy

Deploy the verified change to `$ARGUMENTS` (or the default target per the
active configuration profile, if not specified).

## What to do

1. Confirm all mandatory quality gates for the active configuration
   profile have passed (review, test, and security where applicable). If
   not, stop here — do not proceed to deployment on an unverified change.
2. Confirm target infrastructure is provisioned (invoke `cloud-engineer`
   first if it isn't).
3. Invoke `devops-engineer` to execute the deployment.
4. If the active configuration profile requires approval for this
   environment (e.g., `enterprise`, `trading` production targets), stop
   and request that approval before proceeding.
5. Confirm a rollback path exists before considering the deployment
   final.
6. Report the deployment result clearly.

## Preconditions

All mandatory quality gates have passed; target infrastructure exists or
can be provisioned.

## Success criteria

Deployment completes with a defined, working rollback path.

## Failure handling

- Mandatory gate not cleared: halt before invoking `devops-engineer` at
  all — this is a process failure upstream, not something to route
  around.
- Approval required but not obtained: halt and request it explicitly.
- Deployment fails mid-execution: invoke the rollback path; report both
  the failure and the rollback outcome.

## Related

`docs/specifications/automation/commands/DEPLOY.md` ·
`.claude/agents/devops-engineer.md`
