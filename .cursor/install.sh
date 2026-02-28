#!/usr/bin/env bash
set -euo pipefail

REQUIRED_NODE_MAJOR="22"
REQUIRED_PNPM_VERSION="10.26.0"
TS_WORKSPACE="/workspace/typescript"

echo "[cloud-agent] Ensuring Node.js ${REQUIRED_NODE_MAJOR}.x"
if command -v node >/dev/null 2>&1; then
  CURRENT_NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
else
  CURRENT_NODE_MAJOR=""
fi

if [[ "${CURRENT_NODE_MAJOR}" != "${REQUIRED_NODE_MAJOR}" ]]; then
  echo "[cloud-agent] Installing Node.js ${REQUIRED_NODE_MAJOR}.x via NodeSource"
  curl -fsSL "https://deb.nodesource.com/setup_${REQUIRED_NODE_MAJOR}.x" | sudo -E bash -
  sudo apt-get install -y nodejs
fi

echo "[cloud-agent] Enabling pnpm ${REQUIRED_PNPM_VERSION}"
if ! command -v corepack >/dev/null 2>&1; then
  npm install -g corepack
fi
corepack enable
corepack prepare "pnpm@${REQUIRED_PNPM_VERSION}" --activate

echo "[cloud-agent] node=$(node --version) pnpm=$(pnpm --version)"

if [[ -f "${TS_WORKSPACE}/package.json" ]]; then
  echo "[cloud-agent] Prewarming dependencies in ${TS_WORKSPACE}"
  cd "${TS_WORKSPACE}"
  pnpm install --frozen-lockfile --prefer-offline

  echo "[cloud-agent] Verifying TypeScript workspace commands"
  pnpm typecheck
  pnpm test
  pnpm build
else
  echo "[cloud-agent] Skip prewarm: ${TS_WORKSPACE}/package.json not found"
fi

echo "[cloud-agent] Environment setup completed"
