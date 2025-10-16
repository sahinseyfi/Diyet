Konfigürasyon ve Gerekli Ortam Değişkenleri

Bu proje; GitHub, Vercel ve Supabase ile entegre çalışır. Aşağıdaki anahtarları `.env` dosyasına ekleyin (değerleri asla commit etmeyin):

Uygulama/Backend
- SUPABASE_URL=
- SUPABASE_ANON_KEY=
- SUPABASE_SERVICE_ROLE_KEY= (opsiyonel, yalnız backend tarafında kullanın)

CI/CD ve CLI Erişimi
- GITHUB_TOKEN= (repo ve workflow izinli, `gh` CLI için)
- VERCEL_TOKEN= (Vercel CLI için)
- SUPABASE_ACCESS_TOKEN= (Supabase CLI için)
- (Opsiyonel) Sentry otomatik DSN alma:
- SENTRY_AUTH_TOKEN= (Sentry personal token; scope: project:read)
- SENTRY_ORG= (örn. diyet)
- SENTRY_PROJECT= (örn. diyet-web)
 
Uygulama Logları (Logtail)
- LOGTAIL_SOURCE_TOKEN= (Better Stack Logtail Source Token)

Notlar
- `GITHUB_TOKEN` GitHub CLI ile etkileşimsiz repo/yayın işlemleri için gereklidir.
- `VERCEL_TOKEN` dağıtım ve proje bağlama adımlarında kullanılır.
- `SUPABASE_ACCESS_TOKEN` Supabase proje oluşturma, migration ve bağlantı işlemlerinde kullanılır.

Güvenlik
- Token/secrets değerlerini hiçbir zaman konsolda veya loglarda açık yazmayın.
- Yerelde `.env` kullanın; CI/CD ortamında ilgili platformların Secrets ekranından tanımlayın.

Kurulum Kısa Akışı
1) `.env` dosyasını `.env.example` üzerinden doldurun.
2) `make install` ile geliştirici bağımlılıklarını kurun.
3) `make check` ile fmt/lint/test akışını çalıştırın.
4) GitHub repo bağlantısı/CI, Vercel ve Supabase bağlama adımlarını CLI ile gerçekleştirin.

Sentry DSN (Opsiyonel, token ile otomatik)
- `.env` içine `SENTRY_AUTH_TOKEN`, `SENTRY_ORG`, `SENTRY_PROJECT`, `VERCEL_TOKEN` ekleyin.
- `make sentry-dsn` komutu ile DSN Sentry API'den çekilir ve Vercel'e (production/preview/development) `SENTRY_DSN` olarak yazılır.

Logtail (Better Stack) Kurulumu
- Better Stack Logs hesabı → Yeni "Source" oluştur → `LOGTAIL_SOURCE_TOKEN` kopyala.
- Vercel ortam değişkeni ekle: `printf '%s' "$LOGTAIL_SOURCE_TOKEN" | npx vercel env add LOGTAIL_SOURCE_TOKEN production` (preview/development için tekrarla).
- Test: Canlı sitede "Logtail Test Logu" butonuna bas veya `/api/logtail-test` çağır.

Sentry Triage (Otomatik Öğrenme Sistemi)
- GitHub Secrets olarak şu anahtarları ekleyin: `SENTRY_AUTH_TOKEN` (scope: project:read), `SENTRY_ORG`, `SENTRY_PROJECT`.
- Workflow: `.github/workflows/sentry_triage.yml` her saat triage raporu üretir ve `docs/sentry_report.md` dosyasını günceller.
- İlk 5 kritik hata için repo’da otomatik GitHub issue açılır (etiketler: `sentry`, `bug`).
- Manuel tetikleme: Actions sekmesinde “Sentry Triage” → “Run workflow”.
