# CrewAI TypeScript Rewrite Workspace

This directory hosts the staged TypeScript rewrite of the Python-first CrewAI
monorepo. The rewrite follows a contract-first approach:

1. Freeze Python behavior as the source of truth.
2. Build TypeScript packages behind explicit contracts.
3. Track parity at module level before feature cutover.

## Current phase

- Phase 0: baseline and parity matrix
- Phase 1: monorepo and test infrastructure scaffold

## Workspace layout

- `docs/phase-0-baseline.md`: frozen baseline, scope, and migration policy.
- `docs/parity-matrix.md`: module-by-module parity tracking.
- `docs/contracts/`: contract and fixture strategy.
- `packages/`: TypeScript rewrite packages.

## Commands

```bash
cd typescript
pnpm install
pnpm typecheck
pnpm test
pnpm build
```

## Package map

- `@crewai-rewrite/core`
- `@crewai-rewrite/flow`
- `@crewai-rewrite/llm`
- `@crewai-rewrite/mcp`
- `@crewai-rewrite/files`
- `@crewai-rewrite/tools`
- `@crewai-rewrite/cli`
- `@crewai-rewrite/compat`
