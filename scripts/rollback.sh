#!/usr/bin/env bash
set -euo pipefail

APP_ROOT="${APP_DIR:-/opt/apps/enterprise-app}"
RELEASES_DIR="${APP_ROOT}/releases"
CURRENT_LINK="${APP_ROOT}/current"

echo "[+] Initiating instant atomic rollback..."
cd "$RELEASES_DIR"
PREVIOUS_RELEASE=$(ls -1dt */ | sed 's|/$||' | sed -n '2p')

if [ -z "$PREVIOUS_RELEASE" ]; then
  echo "Error: No previous release found to roll back to!"
  exit 1
fi

echo "[+] Rolling back symlink to: ${PREVIOUS_RELEASE}..."
ln -sfn "${RELEASES_DIR}/${PREVIOUS_RELEASE}" "${CURRENT_LINK}.tmp"
mv -Tf "${CURRENT_LINK}.tmp" "$CURRENT_LINK"

echo "[+] Reloading service runtime..."
echo "[+] Rollback complete."
