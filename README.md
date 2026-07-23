# AEF — AI Engineering Framework

**Status:** Sprint 4 — Automation Framework (specifications only, no runtime code)
**Version:** 1.0.0-sprint4

AEF is a reusable, vendor-neutral AI Engineering Framework designed to standardize
software engineering workflows for AI-assisted development. It runs inside
Claude Code today, with a Runtime Abstraction layer designed to support
additional AI coding runtimes (e.g., Codex CLI, Gemini CLI) in the future
without changes to the framework core.

This is not a normal software project — it is an **AI Engineering Operating
System**: a configuration-driven, plugin-based framework for orchestrating
how AI coding agents discover, plan, build, test, and govern software.

## Start Here

| If you want to... | Read |
|---|---|
| Understand what AEF is and why it exists | [docs/specifications/MASTER_SPEC.md](docs/specifications/MASTER_SPEC.md) |
| Understand the system architecture | [docs/architecture/ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) |
| Understand the repository layout | [docs/architecture/REPOSITORY_STRUCTURE.md](docs/architecture/REPOSITORY_STRUCTURE.md) |
| Understand runtime adapters (Claude Code, and how to add new ones) | [docs/architecture/RUNTIME_ARCHITECTURE.md](docs/architecture/RUNTIME_ARCHITECTURE.md) |
| Understand the plugin system | [docs/architecture/PLUGIN_ARCHITECTURE.md](docs/architecture/PLUGIN_ARCHITECTURE.md) |
| Understand configuration and profiles | [docs/specifications/CONFIGURATION_SPEC.md](docs/specifications/CONFIGURATION_SPEC.md) |
| Read a specific engine's full contract | [docs/specifications/engines/](docs/specifications/engines/) |
| Understand the agent framework (contract, lifecycle, teams) | [docs/specifications/agents/AGENT_FRAMEWORK_SPEC.md](docs/specifications/agents/AGENT_FRAMEWORK_SPEC.md) |
| Read a specific agent's specification | [docs/specifications/agents/teams/](docs/specifications/agents/teams/) |
| Understand the automation layer (commands, hooks, events, workflows) | [docs/specifications/automation/AUTOMATION_ARCHITECTURE.md](docs/specifications/automation/AUTOMATION_ARCHITECTURE.md) |
| Read a specific command's specification | [docs/specifications/automation/commands/](docs/specifications/automation/commands/) |
| Read a specific reusable workflow | [docs/specifications/automation/workflows/](docs/specifications/automation/workflows/) |
| Follow engineering standards | [docs/standards/](docs/standards/) |
| Understand supported workflows | [docs/workflows/WORKFLOW_SPEC.md](docs/workflows/WORKFLOW_SPEC.md) |
| See what's planned next | [docs/roadmap/ROADMAP.md](docs/roadmap/ROADMAP.md) |
| Contribute | [docs/standards/CONTRIBUTION_GUIDE.md](docs/standards/CONTRIBUTION_GUIDE.md) |
| See why a decision was made | [docs/decisions/](docs/decisions/) |

## Sprint 4 Scope

Sprint 4 builds the **Automation Framework**: the layer that connects
users, workflows, runtime engines, and engineering agents. A Command
Contract plus 12 command specifications (bootstrap, analyze, plan,
implement, review, test, secure, document, deploy, release, doctor,
update — see
[docs/specifications/automation/commands/](docs/specifications/automation/commands/)).
A Hook Framework covering 12 lifecycle hooks in six before/after pairs
(see
[docs/specifications/automation/hooks/](docs/specifications/automation/hooks/)).
An Event Catalog with ordering and retry-strategy rules (see
[docs/specifications/automation/events/](docs/specifications/automation/events/)).
A Workflow Library with seven reusable workflows — New Project, New
Feature, Bug Fix, Refactoring, Security Review, Documentation, Release
(see
[docs/specifications/automation/workflows/](docs/specifications/automation/workflows/)).
Automation Rules connecting all of the above (see
[docs/specifications/automation/AUTOMATION_RULES.md](docs/specifications/automation/AUTOMATION_RULES.md)).
It intentionally does **not** include templates, domain packs, or runtime
code — see [docs/roadmap/ROADMAP.md](docs/roadmap/ROADMAP.md) for what
requires explicit approval before it begins.

## Repository Structure (summary)

```
AEF/
├── .github/              CI/CD and repository automation (future sprint)
├── .claude/               Claude Code runtime integration surface
│   ├── agents/             Agent definitions (future sprint)
│   ├── commands/           Slash commands (future sprint)
│   ├── hooks/               Lifecycle hooks (future sprint)
│   ├── skills/               Skill packages (future sprint)
│   ├── memory/               Claude Code's Memory Manager backing store (future sprint)
│   └── templates/           Reusable prompt/config templates
├── runtime/                Runtime Adapters (Sprint 2)
│   ├── claude-code/           Claude Code Runtime Adapter
│   └── shared/                 Adapter-contract utilities shared across runtimes
├── framework/              Core framework source (future sprint for implementation)
│   ├── core/                  Framework kernel, config loader, lifecycle, runtime abstraction interface
│   ├── orchestrator/          Engineering Orchestrator
│   ├── discovery/              Discovery Engine
│   ├── planning/               Planning Engine
│   ├── workflow/               Workflow Engine
│   ├── bootstrap/              Bootstrap Engine
│   ├── quality/                 Quality Gate Manager
│   ├── governance/              Policy, approval, audit
│   ├── memory/                   Memory Manager
│   └── shared/                   Plugin Manager and cross-cutting utilities
├── plugins/                 Technical-capability plugins (Sprint 2)
│   ├── languages/, frameworks/, databases/, cloud-providers/, ai-providers/, security/
├── config/                  Configuration model and profiles (Sprint 2)
│   ├── schema/                 Configuration schemas
│   └── profiles/                enterprise, startup, ai-platform, trading
├── assets/                   Static assets
├── docs/                     All documentation (Sprint 1–4's primary deliverable)
├── standards/                 Machine-readable standards (linting configs, schemas)
├── templates/                 Project/document templates
├── domain-packs/              Industry/domain-vertical extension packs (Sprint 8+)
├── examples/                    Example projects and usage
├── tests/                     Test suites (future sprint)
├── tools/                     Developer tooling
└── scripts/                     Automation scripts
```

Full detail: [docs/architecture/REPOSITORY_STRUCTURE.md](docs/architecture/REPOSITORY_STRUCTURE.md)

## License

TBD — to be finalized before implementation begins.
