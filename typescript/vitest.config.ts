import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["packages/**/test/**/*.test.ts"],
    globals: true,
    environment: "node",
    passWithNoTests: true
  }
});
