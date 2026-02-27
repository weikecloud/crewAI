export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "mcp";
  readonly status: RewriteStatus;
  readonly baselinePath: string;
}

export const mcpMetadata: DomainMetadata = {
  domain: "mcp",
  status: "scaffolded",
  baselinePath: "lib/crewai/src/crewai/mcp"
};
