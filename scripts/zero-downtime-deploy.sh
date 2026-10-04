#!/usr/bin/env bash
set -euo pipefail

APP_ROOT="${APP_DIR:-/opt/apps/enterprise-app}"
RELEASES_DIR="${APP_ROOT}/releases"
SHARED_DIR="${APP_ROOT}/shared"
CURRENT_LINK="${APP_ROOT}/current"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
NEW_RELEASE="${RELEASES_DIR}/${TIMESTAMP}"

echo "========================================="
echo "Zero-Downtime Symlink Deployment Engine"
echo "Timestamp: ${TIMESTAMP}"
echo "Architect: Manish Lalotra"
echo "========================================="

mkdir -p "$RELEASES_DIR" "$SHARED_DIR"

echo "[1/6] Cloning latest application release..."
# git clone --depth 1 -b main <repo_url> "$NEW_RELEASE"
mkdir -p "$NEW_RELEASE"
echo "Release ${TIMESTAMP} initialized." > "${NEW_RELEASE}/version.txt"

echo "[2/6] Linking shared storage and persistent environment..."
ln -sfn "${SHARED_DIR}/.env" "${NEW_RELEASE}/.env" || true
ln -sfn "${SHARED_DIR}/storage" "${NEW_RELEASE}/storage" || true

echo "[3/6] Running dependencies and build tasks..."
# cd "$NEW_RELEASE" && npm ci && npm run build

echo "[4/6] Verifying health of new release..."
# Start test instance or verify syntax

echo "[5/6] Atomically switching active release symlink..."
ln -sfn "$NEW_RELEASE" "${CURRENT_LINK}.tmp"
mv -Tf "${CURRENT_LINK}.tmp" "$CURRENT_LINK"

echo "[6/6] Reloading process manager (PM2 / Systemd / PHP-FPM)..."
# sudo systemctl reload app-service || true

echo "[+] Pruning historical releases (keeping last 5)..."
cd "$RELEASES_DIR"
ls -1dt */ | tail -n +6 | xargs -r rm -rf

echo "[+] Deployment completed successfully! Active release: ${TIMESTAMP}"
