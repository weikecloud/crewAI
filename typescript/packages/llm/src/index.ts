export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "llm";
  readonly status: RewriteStatus;
  readonly baselinePath: string;
}

export const llmMetadata: DomainMetadata = {
  domain: "llm",
  status: "scaffolded",
  baselinePath: "lib/crewai/src/crewai/llm.py"
};
