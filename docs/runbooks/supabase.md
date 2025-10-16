# Runbook: Supabase Çalışma Akışı

1) Giriş
- `npx supabase login --token "$SUPABASE_ACCESS_TOKEN"`

2) Proje
- Varsa mevcut projeyi kullan, yoksa oluştur (org/region gerekir).
- `supabase init` → `supabase/config.toml` oluşur.

3) Migration
- Yeni tablo/alan: `supabase migration new <ad>` → SQL yaz → `supabase db push`
- Her tablo için RLS: `ENABLE ROW LEVEL SECURITY` ve uygun policy.

4) Politika Örnekleri (fikrî)
- Gizli profil: sadece arkadaş ve kullanıcı erişebilir.
- Gönderi: sahip + arkadaşlar okuyabilir; silme/düzenleme sadece sahip.

5) Yerel Geliştirme (Opsiyonel)
- `supabase start` ile lokal container başlat; bağlantı bilgilerini `.env`’e ekle.

6) Sorun Giderme
- Bağlantı hataları: URL/KEY kontrol et.
- Migration çakışmaları: versiyonları sırala, yeniden oluştur.
