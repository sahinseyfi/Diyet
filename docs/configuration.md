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

