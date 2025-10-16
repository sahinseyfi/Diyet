name: Hata bildirimi
description: Bir sorunu rapor edin
title: "bug: <kısa açıklama>"
labels: [bug]
body:
  - type: textarea
    attributes:
      label: Özet
      description: Sorunun kısa açıklaması
    validations:
      required: true
  - type: textarea
    attributes:
      label: Yeniden üretme adımları
      description: Adım adım nasıl tekrarlanacağını yazın
    validations:
      required: true
  - type: textarea
    attributes:
      label: Beklenen davranış
    validations:
      required: true
  - type: textarea
    attributes:
      label: Gerçekleşen davranış ve loglar
    validations:
      required: true
  - type: input
    attributes:
      label: Ortam
      description: Tarayıcı/OS; prod/dev
    validations:
      required: false
