# runtime

**Status:** Structure only (Sprint 2 — contract defined, no implementation yet)

Runtime Adapters: one directory per supported AI coding runtime
(`claude-code/`), plus `shared/` for adapter-contract utilities common to
all of them. See
[Runtime Architecture Specification](../docs/architecture/RUNTIME_ARCHITECTURE.md)
for the full adapter contract and how to add a new runtime (e.g., Codex
CLI, Gemini CLI) without modifying `framework/`.
