# Runbook: CI Kırılmaları Nasıl Onarılır?

1) Logları Oku
- `gh run view <id> --log` ile son job loglarını incele.

2) Lint/Format
- Ruff hatası: `ruff check .` → önerileri uygula veya `--fix` kullan.
- Black format: `black .` → `--check` kırıldıysa otomatik düzelt ve commit.

3) Testler
- En hızlı kırılan testten başla. Yerelde: `pytest -q` veya `pytest tests/<modül>`.
- Kapsama düşüşü: ilgili modül için minimal test ekle. Hedef: `--cov-fail-under=90` geçsin.

4) Ortam/Secrets
- Test sırasında env gerekiyorsa GitHub Secrets üzerinden tanımlı mı kontrol et: `gh secret list`.

5) Tekrar Çalıştır
- PR/commit push et. CI’yi `gh run list` ve `gh run watch` ile takip et.

6) Kalıcı Düzeltmeler
- Sık kırılan kurallar için ruff/black ayarlarını `pyproject.toml` altında güncelle.
