#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for apache/casbin-website
# Runs on existing source tree (no clone). Installs deps and builds.
# Docusaurus 3.9.2, Yarn classic (v1), Node 20

# --- Node 20 via nvm ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ ! -f "${NVM_DIR}/nvm.sh" ]; then
    echo "[INFO] Installing nvm..."
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
# shellcheck source=/dev/null
. "${NVM_DIR}/nvm.sh"
nvm install 20
nvm use 20
echo "Node: $(node --version)"
echo "npm:  $(npm --version)"

# --- Yarn classic (v1) ---
npm install -g yarn@1
echo "Yarn: $(yarn --version)"

# --- Install dependencies ---
# Skip husky prepare script (not needed for build)
yarn install --frozen-lockfile --ignore-scripts

# --- Build ---
yarn build

echo "[DONE] Build complete."
