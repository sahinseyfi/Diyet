# Codex Çalışma Stratejisi (Uygulama Odağı)

Bu rehber, GPT‑5 Codex High’ın kullanıcıdan yardım almadan MVP’yi ilerletebilmesi için uygulanabilir bir oyun planıdır. Ürün kapsamı ve kuralları için `docs/prd.md` ve `AGENTS.md` referans alınmalıdır.

## Akış Özeti
- Triage → Taslak plan → Küçük değişiklik → Test/CI → Dağıtım → Gözlem → Yinelenen iyileştirme.

## Adım Adım
- Triage: Depoyu ve PRD’yi hızlıca tarayıp tek cümlelik plan çıkar.
- Kapsam kontrolü: Ürün belgeleri gerekiyorsa GPT‑5 High’a yönlendir.
- İş listesi: 3–6 maddelik, kısa ve ölçülebilir hedefler.
- Uygulama: En küçük dilim (vertical slice). Gereksiz soyutlamadan kaçın.
- Test: Hedeflenen kodu kapsayan minimal test, ardından genel test.
- Lint/Format: ruff/black çalıştır; gerekli düzeltmeleri uygula.
- CI: Kırılırsa runbook (docs/runbooks/ci.md) izlenir.
- Deploy: `npx vercel --prod --yes` (statik/Edge). Env’leri doğrula.
- Gözlem: Vercel Analytics; hata/performans geri bildirimi topla.

## Teknik İlkeler
- Modülerlik: `src/api`, `src/services`, `src/schemas`, `src/common` ayrımı.
- Bağımlılıklar: Minimum; gerektikçe ekle, `requirements.txt` güncelle.
- Hatalar: Anlamlı istisnalar, kullanıcı dostu mesajlar.
- Güvenlik: Sırlar sadece env/Secrets; günlükte maskeleme.
- Veritabanı: Migration+RLS politikaları her değişiklikte eşlik eder.
- Kapsama: %90 altına düşerse önce test ekle, sonra refactor.

## Ne Zaman Durdurmalı?
- Kırmızı CI; Prod deploy başarısız; Güvenlik ihlali şüphesi.
- Bu durumlarda ilk öncelik onarım ve geri dönüş planı.

## Karar Kayıtları (ADR)
- Önemli mimarî/teknik kararları `docs/adr/` altında belgeleyin.
