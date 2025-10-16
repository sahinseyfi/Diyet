#!/usr/bin/env bash
set -euo pipefail

# Generates Sentry issues report under docs/ from Sentry API.
# Requires: SENTRY_AUTH_TOKEN (project:read), SENTRY_ORG, SENTRY_PROJECT

if [ -f .env ]; then set -a; source .env; set +a; fi

need() { local n=$1; if [ -z "${!n-}" ]; then echo "[hata] $n eksik" >&2; exit 1; fi; }

need SENTRY_AUTH_TOKEN
need SENTRY_ORG
need SENTRY_PROJECT

API=https://sentry.io/api/0
OUT_JSON=docs/sentry_issues.json
OUT_MD=docs/sentry_report.md

mkdir -p docs

echo "[sentry] Issues çekiliyor: $SENTRY_ORG/$SENTRY_PROJECT"
RAW=$(curl -sS -H "Authorization: Bearer $SENTRY_AUTH_TOKEN" \
  "$API/projects/$SENTRY_ORG/$SENTRY_PROJECT/issues/?limit=20&query=is:unresolved&expand=stats&statsPeriod=14d")

# Save structured JSON for later use (GitHub Action can parse)
echo "$RAW" | jq '[.[] | {
  id: .id,
  shortId: .shortId,
  title: .title,
  level: .level,
  culprit: .culprit,
  firstSeen: .firstSeen,
  lastSeen: .lastSeen,
  count: (try (.count|tonumber) catch 0),
  userCount: (try (.userCount|tonumber) catch 0),
  type: .type,
  permalink: .permalink
}]' > "$OUT_JSON"

NOW=$(date -u +"%Y-%m-%d %H:%M:%SZ")

{
  echo "# Sentry Özeti"
  echo "\nGüncelleme: $NOW (UTC) — Proje: $SENTRY_ORG/$SENTRY_PROJECT"
  echo "\nEn son 20 çözülmemiş hata (son 14 gün):\n"
  echo "| Kısa ID | Seviye | Son Görülme | Sayaç | Başlık |"
  echo "|---|---|---|---|---|"
  jq -r '.[] | "| \(.shortId) | \(.level) | \(.lastSeen) | \(.count) | [\(.title)](\(.permalink)) |"' < "$OUT_JSON"
  echo "\nNotlar:"
  echo "- Sentry Issues üzerinden ayrıntılara gidin.\n- `scripts/sentry_dsn.sh` ve `scripts/sentry_report.sh` ile otomasyon sağlandı."
} > "$OUT_MD"

echo "[sentry] Rapor üretildi: $OUT_MD"

