export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "files";
  readonly status: RewriteStatus;
  readonly baselinePath: string;
}

export const filesMetadata: DomainMetadata = {
  domain: "files",
  status: "scaffolded",
  baselinePath: "lib/crewai-files/src/crewai_files"
};
