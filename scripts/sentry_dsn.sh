#!/usr/bin/env bash
set -euo pipefail

# Fetch Sentry DSN via Sentry API using a personal auth token (project:read)
# Then set SENTRY_DSN on Vercel for all environments.

if [ -f .env ]; then set -a; source .env; set +a; fi

need() { local n=$1; if [ -z "${!n-}" ]; then echo "[hata] $n eksik" >&2; exit 1; fi; }

need SENTRY_AUTH_TOKEN
need SENTRY_ORG
need SENTRY_PROJECT
need VERCEL_TOKEN

API_URL=${SENTRY_API_URL:-"https://sentry.io/api/0"}

echo "[sentry] DSN alınıyor: $SENTRY_ORG/$SENTRY_PROJECT"
JSON=$(curl -sS -H "Authorization: Bearer $SENTRY_AUTH_TOKEN" \
  "$API_URL/projects/$SENTRY_ORG/$SENTRY_PROJECT/keys/")

DSN=$(python3 - "$JSON" <<'PY'
import sys, json
data = json.loads(sys.argv[1]) if len(sys.argv) > 1 else json.load(sys.stdin)
if not data:
    sys.exit(2)
dsn = data[0].get("dsn", {}).get("public")
if not dsn:
    sys.exit(3)
print(dsn)
PY
)

if [ -z "$DSN" ]; then
  echo "[hata] DSN bulunamadı" >&2; exit 2
fi

echo "[sentry] DSN bulundu"

# Set on Vercel for all envs
for env in production preview development; do
  printf '%s' "$DSN" | npx -y vercel env add SENTRY_DSN "$env" --token "$VERCEL_TOKEN" >/dev/null 2>&1 || true
done

echo "[sentry] Vercel ortam değişkenleri güncellendi (SENTRY_DSN)"

