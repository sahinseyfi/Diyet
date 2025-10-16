
## Model-Specific Planning Flow (GPT‑5 vs GPT‑5 Codex)

These rules constrain what the agent should produce depending on the active model to keep responsibilities clean and avoid mixing deliverables.

- Two-phase flow: plan product with GPT‑5 High, then implement technical design with GPT‑5 Codex High.

- If running on GPT‑5 High (general reasoning):
  - Do NOT produce: detailed technical design, `src/` and `tests/` tree, OpenAPI spec or ERD, starter scaffolding, or an execution task plan.
  - Instead: politely inform the user that these are Codex responsibilities and suggest switching to GPT‑5 Codex High for those outputs.

- If running on GPT‑5 Codex High (coding-focused):
  - Do NOT produce: PRD, user stories, acceptance criteria, NFRs, risks, or the high‑level target architecture diagram and component responsibilities.
  - Instead: politely inform the user that these are GPT‑5 High responsibilities and suggest switching to GPT‑5 High for those outputs.

- If a request spans both scopes:
  - Ask which phase to tackle first and advise switching models accordingly.

- Suggested short nudges (Turkish):
  - GPT‑5 High → Codex: "Şu anda GPT‑5 (genel muhakeme) bağlamındayım; teknik tasarım ve kod üretimi için GPT‑5 Codex High'a geçmenizi öneririm."
  - Codex → GPT‑5 High: "Şu anda GPT‑5 Codex (kod odaklı) bağlamındayım; PRD, hikâyeler ve yüksek seviye planlama için GPT‑5 High'a geçmenizi öneririm."

Detection: determine the current model from harness metadata when available; if uncertain, ask the user which model is active and proceed accordingly. If guidance here conflicts with other tips, this section takes precedence for planning/production scope.

## Kullanıcı Profili ve Operasyonel Tercihler (TR)

Bu depo için varsayılan kullanıcı profili ve beklentiler şöyledir. Bu tercih kuralları, "Model-Specific Planning Flow" kapsam kısıtlarıyla birlikte uygulanır.

- Dil: Varsayılan yanıt dili Türkçe. Kod parçaları, komutlar ve ham CLI çıktıları hariç tüm açıklamalar Türkçe olmalı.
- Teknik seviye: Kullanıcı kodlama bilmiyor; mümkün olduğunca ajan işlemleri kendisi gerçekleştirir, kullanıcıdan komut çalıştırması beklenmez.
- Platformlar: Supabase + Vercel + GitHub tercih edilir. Alternatif platformlara yalnızca kullanıcı isterse yönelin.
- Yürütme yöntemi: Tüm mümkün işlemler token ve CLI'lar üzerinden, etkileşimsiz (headless) yapılır.
  - GitHub: `gh` CLI. Kimlik doğrulama `GITHUB_TOKEN` (repo, workflow izinleri) ile yapılır.
  - Vercel: `vercel` CLI. Kimlik doğrulama `VERCEL_TOKEN` ile; komutlarda `--token` veya ortam değişkeni kullanılır. Etkileşimleri atlamak için `--yes/--confirm` tercih edilir.
  - Supabase: `supabase` CLI. Kimlik doğrulama `SUPABASE_ACCESS_TOKEN` ile; `supabase login` gerekirse token kullanır.
- Güvenlik: Token/secrets asla çıktılarda gösterilmez veya kaydedilmez. Ortam değişkenleri ya da `.env` kullanılır; gerekli anahtarlar dokümante edilir. Eksikse kullanıcıdan temin edilmesi istenir.
- Operasyon kapsamı: Ajan, mümkün olduğunda şu işlemleri CLI ile üstlenir: depo oluşturma/bağlama (GitHub), çevresel değişkenleri/secrets tanımlama, Supabase proje ve veritabanı oluşturma/şema yönetimi, Vercel proje bağlama ve dağıtım, CI/CD entegrasyonu. Yıkıcı işlemler (silme/override) öncesi açık onay istenir.
- Hata toleransı: Etkileşimli adımlar gerekiyorsa non-interactive bayraklar ve varsayılanlar kullanılır; bu mümkün değilse kullanıcıdan bir defalık doğrulama istenir ve kalıcı yapılandırma yapılır.
- İzlenebilirlik: Ajan çalıştırdığı komutları ve etkilerini özetler; sırları maskeleyerek minimal günlük paylaşır.

## Codex Çalışma Stratejisi (MVP ve Sonrası)

Bu bölüm, GPT‑5 Codex High’ın kullanıcı müdahalesi olmadan ilerleyebilmesi için önerilen işlem adımlarını içerir. Bu strateji, yukarıdaki “Model-Specific Planning Flow” kurallarıyla birlikte uygulanır.

1) Başlangıç Taraması
- `AGENTS.md`, `docs/prd.md`, `README.md`, `pyproject.toml`, CI workflow’larını oku.
- Planı güncelle (kısa, doğrusal adımlar). Kapsam dışı taleplerde modele göre kullanıcıyı uyar.

2) Görev Ayrımı ve Kapsam Kontrolü
- Ürüne dair istekler → GPT‑5 High (PRD/akış). Teknik üretim → Codex.
- Her değişiklikte “en küçük dilim” yaklaşımı: küçük PR’lar, hızlı geri bildirim.

3) Uygulama İlkeleri
- Dizinler: `src/api`, `src/services`, `src/schemas`, `src/common`, testler `tests/`.
- Kod stili: black (88), ruff. Commit mesajı: Conventional Commits.
- Test yaklaşımı: önce birim test, sonra entegrasyon; kapsama ≥%90.

4) Doğrulama ve CI
- `pytest` → ruff → black → coverage sırası. CI kırılırsa önce lint/format, sonra test, en son env/secrets.
- Hızlı düzeltme: eksik kapsama için minimal test, format hatasında otomatik düzeltme.

5) Ortam ve Gizli Bilgiler
- Sırlar `.env` ve platform Secrets’ta tutulur. Asla loglama.
- CLI’ler: `gh`, `vercel`, `supabase`. Non‑interactive bayraklar ve token’lar ile çalış.

6) Veri ve Şema Değişimleri
- Supabase migration komutlarıyla ilerle. DDL değişiklikleri için versiyonlu migration yaz.
- RLS politikalarını her tablo ekinde tanımla; varsayılan “gizli profil” modele göre filtre uygula.

7) Gözlemlenebilirlik ve Hata Yönetimi
- Vercel Analytics açık. Gerekirse Sentry/benzeri ekle (kullanıcı onayıyla).
- Runbook’lar: `docs/runbooks/ci.md`, `docs/runbooks/deploy.md`, `docs/runbooks/supabase.md`.

8) Karar Kaydı
- Mimarî kararları `docs/adr/` altında ADR formatında kaydet.

9) Yol Haritası
- Kısa vadeli backlog/MVP → `docs/roadmap.md`.
- Fazlar ilerledikçe güncelle ve Issue/PR şablonlarıyla ilişkilendir.
