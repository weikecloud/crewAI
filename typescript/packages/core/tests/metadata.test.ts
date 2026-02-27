import { describe, expect, it } from "vitest";

import { coreMetadata } from "../src/index";

describe("core metadata scaffold", () => {
  it("starts in scaffolded status with baseline paths", () => {
    expect(coreMetadata.status).toBe("scaffolded");
    expect(coreMetadata.baselinePaths.length).toBeGreaterThanOrEqual(3);
  });
});
