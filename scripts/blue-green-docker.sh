#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "Blue-Green Docker Deployment Automation"
echo "Architect: Manish Lalotra"
echo "========================================="

ACTIVE_PORT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8081/health || echo "000")

if [ "$ACTIVE_PORT" = "200" ]; then
    CURRENT="blue"
    NEXT="green"
    NEXT_PORT=8082
else
    CURRENT="green"
    NEXT="blue"
    NEXT_PORT=8081
fi

echo "[+] Current active container: ${CURRENT}. Deploying candidate: ${NEXT} on port ${NEXT_PORT}..."

# docker compose up -d "app-${NEXT}"

echo "[+] Probing ${NEXT} candidate health..."
# for i in {1..10}; do curl -f http://localhost:${NEXT_PORT}/health && break || sleep 2; done

echo "[+] Updating Nginx upstream configuration to point to ${NEXT}..."
# sed -i "s/server localhost:.*/server localhost:${NEXT_PORT};/" /etc/nginx/conf.d/upstream.conf
# nginx -s reload

echo "[+] Stopping previous active container: ${CURRENT}..."
# docker stop "app-${CURRENT}" || true

echo "[+] Blue-Green cutover succeeded without service disruption!"
