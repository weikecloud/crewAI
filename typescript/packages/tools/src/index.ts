export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "tools";
  readonly status: RewriteStatus;
  readonly baselinePath: string;
  readonly exportedToolCount: number;
}

export const toolsMetadata: DomainMetadata = {
  domain: "tools",
  status: "scaffolded",
  baselinePath: "lib/crewai-tools/src/crewai_tools/tools",
  exportedToolCount: 89
};
