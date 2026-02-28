export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "core";
  readonly status: RewriteStatus;
  readonly baselinePaths: readonly string[];
}

export const coreMetadata: DomainMetadata = {
  domain: "core",
  status: "scaffolded",
  baselinePaths: ["lib/crewai/src/crewai/agent.py", "lib/crewai/src/crewai/crew.py", "lib/crewai/src/crewai/task.py"]
};
