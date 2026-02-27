# Contract Test Strategy

Contract tests are the guardrails for feature parity between Python baseline
and the TypeScript rewrite.

## Contract sources

1. Python unit and integration tests in:
   - `lib/crewai/tests`
   - `lib/crewai-tools/tests`
   - `lib/crewai-files/tests`
2. Golden fixtures captured from Python runtime behavior.

## Contract workflow

1. Select one domain and one behavior slice.
2. Capture Python input/output fixtures for that slice.
3. Reproduce behavior in TypeScript package tests.
4. Compare outputs and side effects deterministically.
5. Mark parity in `docs/parity-matrix.md`.

## Determinism rules

- Freeze random seeds when needed.
- Use normalized timestamps/ids in fixtures.
- Record external API interactions via test doubles for repeatability.

## Acceptance gate

A contract is complete only when the TypeScript implementation demonstrates
behavior equivalence for:

- output shape and semantic content,
- error classes and failure mode semantics,
- event ordering when ordering is part of behavior.
