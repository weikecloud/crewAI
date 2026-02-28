export type RewriteStatus = "scaffolded" | "in_progress" | "parity_verified";

export interface DomainMetadata {
  readonly domain: "compat";
  readonly status: RewriteStatus;
  readonly purpose: string;
}

export const compatMetadata: DomainMetadata = {
  domain: "compat",
  status: "scaffolded",
  purpose: "Host adapters and shims used for staged migration from Python runtime to TypeScript runtime."
};
