# AEF — AI Engineering Framework

**Status:** Sprint 1 — Foundation (specifications only, no runtime code)
**Version:** 1.0.0-sprint1

AEF is a reusable, vendor-neutral AI Engineering Framework designed to standardize
software engineering workflows for AI-assisted development. It runs inside
Claude Code today, with a runtime abstraction layer designed to support
additional AI coding runtimes in the future.

This is not a normal software project — it is an **AI Engineering Operating
System**: a configuration-driven, plugin-based framework for orchestrating
how AI coding agents analyze, plan, build, test, and govern software.

## Start Here

| If you want to... | Read |
|---|---|
| Understand what AEF is and why it exists | [docs/specifications/MASTER_SPEC.md](docs/specifications/MASTER_SPEC.md) |
| Understand the system architecture | [docs/architecture/ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) |
| Understand the repository layout | [docs/architecture/REPOSITORY_STRUCTURE.md](docs/architecture/REPOSITORY_STRUCTURE.md) |
| Follow engineering standards | [docs/standards/](docs/standards/) |
| Understand supported workflows | [docs/workflows/WORKFLOW_SPEC.md](docs/workflows/WORKFLOW_SPEC.md) |
| See what's planned next | [docs/roadmap/ROADMAP.md](docs/roadmap/ROADMAP.md) |
| Contribute | [docs/standards/CONTRIBUTION_GUIDE.md](docs/standards/CONTRIBUTION_GUIDE.md) |
| See why a decision was made | [docs/decisions/](docs/decisions/) |

## Sprint 1 Scope

Sprint 1 establishes **architecture and documentation only**. It intentionally
does **not** include agents, commands, hooks, or any runtime logic. Those are
scoped for Sprint 2 onward and require explicit approval before work begins —
see [docs/roadmap/ROADMAP.md](docs/roadmap/ROADMAP.md).

## Repository Structure (summary)

```
AEF/
├── .github/              CI/CD and repository automation (Sprint 2+)
├── .claude/               Claude Code runtime integration surface
│   ├── agents/            Agent definitions (Sprint 2+)
│   ├── commands/          Slash commands (Sprint 2+)
│   ├── hooks/             Lifecycle hooks (Sprint 2+)
│   ├── skills/             Skill packages (Sprint 2+)
│   ├── memory/            Persistent memory stores (Sprint 2+)
│   └── templates/         Reusable prompt/config templates
├── framework/             Core framework source (Sprint 2+)
│   ├── core/               Framework kernel, config loader, lifecycle
│   ├── orchestrator/       Orchestration engine
│   ├── analyzer/           Project analysis engine
│   ├── workflow/           Workflow engine
│   ├── bootstrap/          Bootstrap/init engine
│   ├── quality/            Quality gates
│   ├── governance/         Policy, approval, audit
│   └── shared/             Cross-cutting utilities
├── docs/                  All documentation (this is Sprint 1's deliverable)
├── standards/              Machine-readable standards (linting configs, schemas)
├── templates/              Project/document templates
├── domain-packs/           Domain-specific extension packs (Sprint 3+)
├── examples/                Example projects and usage
├── tests/                  Test suites (Sprint 2+)
├── tools/                  Developer tooling
└── scripts/                 Automation scripts
```

Full detail: [docs/architecture/REPOSITORY_STRUCTURE.md](docs/architecture/REPOSITORY_STRUCTURE.md)

## License

TBD — to be finalized before Sprint 2.
