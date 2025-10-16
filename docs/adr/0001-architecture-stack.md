# ADR 0001: Temel Yığın (Supabase + Vercel + GitHub)

Tarih: 2025-10-16

Durum: Kabul edildi

Bağlam
- Ürün TR odaklı MVP; hızlı teslim ve basit yönetim öncelikli.
- Kullanıcı gizliliği ve güvenlik: varsayılan gizli profil, RLS ihtiyacı.

Karar
- Veritabanı ve kimlik: Supabase (Postgres + Auth + Storage).
- Barındırma: Vercel (statik + gerekirse Edge/Serverless fonksiyonlar).
- CI/CD ve kaynak kontrol: GitHub Actions + GitHub repo.

Sonuçlar
- Avantajlar: Hızlı prototipleme, yönetilen servisler, kolay CI/CD.
- Dezavantajlar: Vendor bağımlılığı; kota/limit riskleri.
- Azaltım: Soyutlama katmanı, veri dışa aktarma, düzenli yedek.
