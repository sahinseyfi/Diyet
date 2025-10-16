# Diyet Sosyal – Ürün Gereksinimleri (PRD)

## Vizyon
Kullanıcıların kilo/vücut ölçüleri ve beslenme ilerlemelerini güvenli biçimde takip edip arkadaşlarıyla paylaşabildiği, beğeni/yorum etkileşimi olan bir “diyet için sosyal akış” deneyimi.

## Kapsam (MVP)
- Profil ve Gizlilik: Varsayılan gizli profil; ad, avatar, biyografi.
- Arkadaşlık: Karşılıklı onaylı “arkadaşlık” modeli (istek gönder/kabul/ret/kaldır/blokla).
- Ölçüler ve İlerleme: Tarihli kilo ve isteğe bağlı vücut ölçüleri; ilerleme grafikleri.
- Günlük Özet: Günlük alınan kalori ve kalori açığı; özet görünümleri.
- Öğün Paylaşımı: Foto(lar) + başlık + makro/kalori; düzenle/sil; görünürlük: arkadaşlar.
- Akış: Sadece arkadaş gönderileri; sayfalama/sonsuz kaydırma.
- Etkileşim: Beğeni (toggle), yorum (metin, 500 karakter sınırı), yorum silme.

## Kapsam Dışı (MVP)
DM/sohbet, gruplar/hashtag keşfet, gelişmiş bildirimler, abonelik/ödeme, rozet/oyunlaştırma.

## Kullanıcı Hikâyeleri (özet)
- Hesap oluşturma/giriş/çıkış, şifre sıfırlama.
- Profilimde kilo/ölçüleri tarihli kaydetmek ve grafiklerde görmek istiyorum.
- Günlük kalori ve kalori açığımı görmek istiyorum.
- Foto ve kısa açıklama ile öğün paylaşmak istiyorum; makro/kalorisi görünsün.
- Arkadaşlarımı ekleyip onaylamak ve akışta gönderilerini görmek istiyorum.
- Gönderilere beğeni atıp yorum yazmak istiyorum (max 500 karakter).

## Kabul Kriterleri (MVP)
- Kimlik: E‑posta doğrulama; hatalı girişte açık uyarı; güvenli çıkış.
- Arkadaşlık: İstek gönder/al; kabul/ret; engelle/engeli kaldır; gizli hesapta içerik sadece arkadaşlara görünür.
- Ölçüler: Zorunlu alan doğrulama; tarih gelecekte olamaz; sil/düzenle geri alınabilir; trend grafikleri.
- Günlük Özet: Toplam kalori otomatik hesap; hedefe göre açık/fazla; tarih değiştirme.
- Öğün: En az 1 foto veya metin; makro/kalori gösterimi; düzenle/sil; görünürlük arkadaşlar.
- Akış: Yalnız arkadaş gönderileri; kronolojik; boş durumda rehber metin.
- Beğeni/Yorum: Beğeni toggle; yorum 1–500 karakter; kendi yorumunu sil.
- Grafik Dönemleri: Kullanıcı özel tarih aralığı belirleyebilir (ör. başlangıç/bitış seçimi). Kısayol: 7/30/90 gün.

## NFR’ler
- Performans: p95 akış yüklenme <1.5 sn; etkileşim <300 ms.
- Güvenlik: Supabase Auth; RLS/RBAC; secrets sadece sunucu tarafında.
- Gizlilik: Varsayılan gizli profil; KVKK/GDPR uyumu; veri indir/sil talebi.
- Erişilebilirlik: WCAG 2.1 AA temel kriterler; klavye ile kullanım, kontrast, alt metin.
- Gözlemlenebilirlik: Temel log/metric; Vercel Analytics açık.

## Riskler ve Önlemler
- Tetikleyici içerik (yeme bozukluğu): Rapor/engelle; hassas içerik uyarıları; topluluk kuralları.
- Mahremiyet: Varsayılan gizlilik; ayrıntılı izinler; denetim izleri.
- Taciz/spam: Oran sınırlama; basit moderasyon; engelle/raporla akışları.
- Besin verisi doğruluğu: Kullanıcı kaynaklı; düzenleme izi ve uyarılar.

## Başarı Metrikleri
Aktivasyon (3 gün içinde 1 ölçü + 1 paylaşım), D7 tutma, ortalama beğeni/yorum, arkadaş bağlantıları, hedef ilerleme trendi.

## Yüksek Seviye Mimari
İstemci (web/TR) → Vercel (statik + gerekirse Edge/Serverless) → Supabase (Auth + Postgres + Storage). CI/CD GitHub Actions; gizli anahtarlar GitHub/Vercel ortam değişkenleri.

---

## İçerik Politikası (Topluluk Kuralları – Özet)
Bu kurallar, güvenli ve destekleyici bir ortam sağlamak için geçerlidir. İhlaller içerik kaldırma, geçici/kalmıcı kısıtlama ile sonuçlanabilir.

### 1) Güvenli ve Saygılı Davranış
- Nefret söylemi, taciz, tehdit, zorbalık ve ayrımcılık yasaktır.
- Kişisel saldırılar ve beden utandırma (body shaming) yasaktır.
- Yanıltıcı sağlık iddiaları teşviki yasaktır; tıbbi tavsiye niteliğinde içerik paylaşılamaz.

### 2) Hassas Sağlık İçerikleri
- Aşırı kalori kısıtlaması, pro-ana/pro-mia vb. zararlı akımlar teşvik edilemez.
- Tetikleyici içerikler (aşırı zayıflık/güçlü beden transformasyonları) için uyarı etiketi gerekir.
- Tıbbi risk barındıran içeriklerde “tıbbi tavsiye değildir” uyarısı gösterilir.

### 3) Görsel İçerik
- Açık saçıklık ve yetişkinlere yönelik içerikler yasaktır.
- Şiddet/rahatsız edici görüntüler yasaktır.
- Paylaşılan görseller kullanıcıya ait olmalı veya kullanım izni bulunmalıdır.

### 4) Gizlilik ve Güvenlik
- Kişisel veriler (adres, telefon, e‑posta, tıbbi kayıt) paylaşılamaz.
- Başkalarının verilerini izinsiz paylaşmak yasaktır.
- İhlal durumda içerik hızla kaldırılır; tekrarında hesap kısıtlanır.

### 5) Moderasyon ve Bildirim
- Raporla: Kullanıcılar uygunsuz içeriği/hesabı rapor edebilir.
- Engelle: Kullanıcı istediği hesabı engelleyebilir.
- Oran sınırlama: Spam/istismar önlemek için kısıtlar uygulanır.
- İtiraz: Kaldırılan içerikler için itiraz başvurusu kanalı sağlanır.

### 6) Yorumlar
- 1–500 karakter aralığı; spam/bağlantı yağmuru yasaktır.
- Uygunsuz dil filtrelenir; tekrarda yorum yetkisi kısıtlanabilir.

### 7) Uygulama
- Kurallara aykırı içerikler kaldırılır; tekrar eden ihlallerde geçici veya kalıcı yasak uygulanır.
- Kanuni bildirimler ve platform kuralları önceliklidir.

Not: Bu doküman ürün yönlendirmesi içindir; teknik tasarım/şema/API kapsamı dışındadır.
