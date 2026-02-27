import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["packages/**/{test,tests}/**/*.test.ts"],
    globals: true,
    environment: "node",
    passWithNoTests: true
  }
});
