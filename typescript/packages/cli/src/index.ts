export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "cli";
  readonly status: RewriteStatus;
  readonly baselinePath: string;
  readonly commandCount: number;
}

export const cliMetadata: DomainMetadata = {
  domain: "cli",
  status: "scaffolded",
  baselinePath: "lib/crewai/src/crewai/cli/cli.py",
  commandCount: 14
};
