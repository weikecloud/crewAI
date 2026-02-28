# Phase 0 Baseline Freeze

Date: 2026-02-27

This document freezes the Python implementation baseline that the TypeScript
rewrite must match.

## Baseline inventory

### Source implementation

- Python source files: 737
  - `lib/crewai/src`: 475 files, 91,520 lines
  - `lib/crewai-tools/src`: 226 files, 20,684 lines
  - `lib/crewai-files/src`: 33 files, 8,045 lines
  - `lib/devtools/src`: 3 files, 1,170 lines
- Total Python source lines in baseline: 121,419

### Test baseline

- Python test files: 203
  - `lib/crewai/tests`: 171 files, 69,638 lines
  - `lib/crewai-tools/tests`: 24 files, 7,911 lines
  - `lib/crewai-files/tests`: 8 files, 2,365 lines
- Total Python test lines: 79,914

### Non-Python runtime code

- JavaScript files: 3 (2,497 lines)
- TypeScript files: 0

## Functional scope in rewrite

The rewrite targets feature parity for:

1. Core runtime (`Agent`, `Crew`, `Task`, execution lifecycle)
2. Flow engine (start/listen/router decorators and routing semantics)
3. LLM abstraction and tool-calling behavior
4. MCP client and transports (`stdio`, `http`, `sse`)
5. File processing and multimodal constraints
6. Tooling framework and high-priority tools
7. CLI commands and project scaffolding
8. Compatibility layer for transition adoption

## Migration policy

- Contract-first: TypeScript behavior must be validated against frozen Python
  behavior.
- No silent divergence: any intentional behavior change must be documented in
  the parity matrix and release notes.
- Incremental shipping: each domain migrates independently with green tests.

## Exit criteria for Phase 0

- Baseline inventory frozen
- Domain boundaries and ownership defined
- Parity matrix initialized
- Contract test strategy documented
