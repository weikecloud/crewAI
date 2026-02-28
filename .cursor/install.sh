#!/usr/bin/env bash
set -euo pipefail

REQUIRED_NODE_MAJOR="22"
REQUIRED_PNPM_VERSION="10.26.0"
TS_WORKSPACE="/workspace/typescript"
LOCKFILE_PATH="${TS_WORKSPACE}/pnpm-lock.yaml"
CACHE_DIR="${HOME}/.cache/cursor-cloud-agent"
CACHE_KEY_FILE="${CACHE_DIR}/typescript-prewarm.key"
SETUP_SCHEMA_VERSION="3"
FORCE_CLOUD_SETUP="${FORCE_CLOUD_SETUP:-0}"
RUN_SMOKE_ON_CACHE_HIT="${RUN_SMOKE_ON_CACHE_HIT:-1}"
SMOKE_CHECK_COMMAND="${SMOKE_CHECK_COMMAND:-pnpm exec tsc -p tsconfig.json --noEmit --pretty false}"

mkdir -p "${CACHE_DIR}"

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

compute_lockfile_hash() {
  local lockfile="$1"
  if [[ -f "${lockfile}" ]]; then
    sha256sum "${lockfile}" | awk '{print $1}'
  else
    echo "no-lockfile"
  fi
}

build_cache_key() {
  local lock_hash="$1"
  local node_version
  local pnpm_version
  node_version="$(node --version)"
  pnpm_version="$(pnpm --version)"
  echo "${SETUP_SCHEMA_VERSION}|${node_version}|${pnpm_version}|${lock_hash}"
}

if [[ -f "${TS_WORKSPACE}/package.json" ]]; then
  LOCK_HASH="$(compute_lockfile_hash "${LOCKFILE_PATH}")"
  CURRENT_CACHE_KEY="$(build_cache_key "${LOCK_HASH}")"
  EXISTING_CACHE_KEY=""
  if [[ -f "${CACHE_KEY_FILE}" ]]; then
    EXISTING_CACHE_KEY="$(<"${CACHE_KEY_FILE}")"
  fi

  if [[ "${FORCE_CLOUD_SETUP}" != "1" && "${CURRENT_CACHE_KEY}" == "${EXISTING_CACHE_KEY}" ]]; then
    echo "[cloud-agent] TypeScript workspace unchanged; skipping install/test/build"
    if [[ "${RUN_SMOKE_ON_CACHE_HIT}" == "1" ]]; then
      echo "[cloud-agent] Running lightweight smoke check on cache hit"
      cd "${TS_WORKSPACE}"
      eval "${SMOKE_CHECK_COMMAND}"
    else
      echo "[cloud-agent] Smoke check disabled (RUN_SMOKE_ON_CACHE_HIT=${RUN_SMOKE_ON_CACHE_HIT})"
    fi
    echo "[cloud-agent] Set FORCE_CLOUD_SETUP=1 to force a full setup run"
    echo "[cloud-agent] Environment setup completed"
    exit 0
  fi

  echo "[cloud-agent] Prewarming dependencies in ${TS_WORKSPACE} (incremental run)"
  cd "${TS_WORKSPACE}"
  pnpm install --frozen-lockfile --prefer-offline

  echo "[cloud-agent] Verifying TypeScript workspace commands (typecheck/test/build)"
  pnpm typecheck
  pnpm test
  pnpm build

  printf "%s" "${CURRENT_CACHE_KEY}" > "${CACHE_KEY_FILE}"
else
  echo "[cloud-agent] Skip prewarm: ${TS_WORKSPACE}/package.json not found"
fi

echo "[cloud-agent] Environment setup completed"
