# TypeScript Rewrite Parity Matrix

Status legend:

- `not_started`
- `in_progress`
- `parity_blocked`
- `parity_verified`

| Domain | Python Baseline | TS Target Package | Baseline Evidence | Status |
| --- | --- | --- | --- | --- |
| Core runtime | `lib/crewai/src/crewai/{agent.py,crew.py,task.py}` | `@crewai-rewrite/core` | `lib/crewai/tests/test_crew.py`, `test_task.py` | `not_started` |
| Flow engine | `lib/crewai/src/crewai/flow/` | `@crewai-rewrite/flow` | `lib/crewai/tests/test_flow.py` | `not_started` |
| LLM abstraction | `lib/crewai/src/crewai/{llm.py,llms/}` | `@crewai-rewrite/llm` | `lib/crewai/tests/test_llm.py` | `not_started` |
| MCP integration | `lib/crewai/src/crewai/mcp/` | `@crewai-rewrite/mcp` | `lib/crewai/tests/mcp/` | `not_started` |
| File processing | `lib/crewai-files/src/crewai_files/` | `@crewai-rewrite/files` | `lib/crewai-files/tests/` | `not_started` |
| Tool framework | `lib/crewai-tools/src/crewai_tools/tools/` | `@crewai-rewrite/tools` | `lib/crewai-tools/tests/tools/` | `not_started` |
| CLI | `lib/crewai/src/crewai/cli/` | `@crewai-rewrite/cli` | `lib/crewai/tests/cli/` | `not_started` |
| Compatibility | Cross-package adapters | `@crewai-rewrite/compat` | Integration regression suites | `not_started` |

## Parity rules

1. A domain can move to `parity_verified` only with:
   - passing TypeScript tests for that domain,
   - passing contract comparison fixtures against Python outputs,
   - no unresolved critical deltas.
2. Any intentionally changed behavior must be documented next to the domain
   before release cutover.
