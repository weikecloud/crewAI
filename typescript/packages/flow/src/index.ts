export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "flow";
  readonly status: RewriteStatus;
  readonly baselinePath: string;
}

export const flowMetadata: DomainMetadata = {
  domain: "flow",
  status: "scaffolded",
  baselinePath: "lib/crewai/src/crewai/flow"
};
