#!/usr/bin/env bash
set -euo pipefail

echo "[bootstrap] Başladı"

# Load .env if present
if [ -f .env ]; then
  set -a
  # shellcheck disable=SC1091
  source .env
  set +a
fi

# Checks
need_var() {
  local name=$1
  if [ -z "${!name-}" ]; then
    echo "[hata] $name eksik. .env dosyasında tanımlayın." >&2
    return 1
  fi
}

REPO_NAME=${REPO_NAME:-$(basename "$PWD")}

# Require tokens but DO NOT echo values
need_var GITHUB_TOKEN || exit 1
need_var VERCEL_TOKEN || exit 1
need_var SUPABASE_ACCESS_TOKEN || exit 1

# CLI availability
has() { command -v "$1" >/dev/null 2>&1; }

echo "[bootstrap] CLI kontrolleri yapılıyor"
for c in gh vercel supabase; do
  if ! has "$c"; then
    echo "[uyarı] $c yüklü değil. Lütfen yükleyin ve tekrar çalıştırın."
  fi
done

# Auth steps (best-effort; skip if CLI missing)
if has gh; then
  echo "[bootstrap] GitHub auth"
  echo "$GITHUB_TOKEN" | gh auth login --with-token >/dev/null
else
  echo "[uyarı] gh bulunamadı, GitHub adımları atlanacak"
fi

if has supabase; then
  echo "[bootstrap] Supabase auth"
  supabase login --token "$SUPABASE_ACCESS_TOKEN" >/dev/null
else
  echo "[uyarı] supabase CLI bulunamadı, Supabase adımları atlanacak"
fi

if has vercel; then
  echo "[bootstrap] Vercel auth doğrulanıyor"
  vercel whoami --token "$VERCEL_TOKEN" >/dev/null || true
else
  echo "[uyarı] vercel CLI bulunamadı, Vercel adımları atlanacak"
fi

# Git repo init/push
if [ -d .git ]; then
  echo "[bootstrap] Git deposu mevcut"
else
  echo "[bootstrap] Git deposu oluşturuluyor"
  git init -b main
  git add -A
  git commit -m "chore: initial scaffold"
fi

if has gh; then
  GH_USER=$(gh api user -q .login 2>/dev/null || true)
  REMOTE_URL=$(git remote get-url origin 2>/dev/null || true)
  if [ -z "$REMOTE_URL" ] && [ -n "$GH_USER" ]; then
    echo "[bootstrap] GitHub reposu kontrol ediliyor: $GH_USER/$REPO_NAME"
    if ! gh repo view "$GH_USER/$REPO_NAME" >/dev/null 2>&1; then
      gh repo create "$GH_USER/$REPO_NAME" --source=. --public --push --description "Diyet app scaffold" >/dev/null
      echo "[bootstrap] Repo oluşturuldu ve push edildi"
    else
      git remote add origin "https://github.com/$GH_USER/$REPO_NAME.git" 2>/dev/null || true
      git push -u origin main
      echo "[bootstrap] Mevcut repoya push edildi"
    fi
  fi
fi

# GitHub secrets (if available)
if has gh; then
  echo "[bootstrap] GitHub secrets güncelleniyor (opsiyonel alanlar atlanabilir)"
  for key in SUPABASE_URL SUPABASE_ANON_KEY; do
    val=${!key-}
    if [ -n "$val" ]; then
      gh secret set "$key" -b"$val" >/dev/null || true
    fi
  done
fi

# Vercel link + env
if has vercel; then
  echo "[bootstrap] Vercel link"
  if ! vercel link --project "$REPO_NAME" --yes --token "$VERCEL_TOKEN" >/dev/null 2>&1; then
    echo "[uyarı] Vercel link sırasında etkileşim gerekebilir; proje zaten bağlı olabilir."
  fi

  for key in SUPABASE_URL SUPABASE_ANON_KEY; do
    val=${!key-}
    if [ -n "$val" ]; then
      vercel env rm "$key" -y --token "$VERCEL_TOKEN" >/dev/null 2>&1 || true
      vercel env set "$key" "$val" --token "$VERCEL_TOKEN" >/dev/null || true
    fi
  done
fi

echo "[bootstrap] Tamamlandı"

