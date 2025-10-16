# Runbook: Vercel Deploy

1) Proje Linki
- Klasör Vercel projesine bağlı mı? `.vercel/project.json` olmalı.
- Gerekirse: `npx vercel link --project <name> --yes --token "$VERCEL_TOKEN"`.

2) Env Değişkenleri
- List: `npx vercel env list --token "$VERCEL_TOKEN"`
- Ekle: `printf '%s' "$VALUE" | npx vercel env add KEY production` (preview/development için tekrarla)

3) Prod Deploy
- `npx vercel --prod --yes --token "$VERCEL_TOKEN"`

4) Sorun Giderme
- Build hataları: `npx vercel build --token "$VERCEL_TOKEN" --debug`
- Eksik env: env listesi ile karşılaştır.
- Statik servis: `index.html`/`vercel.json` kontrol et.
