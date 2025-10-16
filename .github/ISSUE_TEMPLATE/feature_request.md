name: Özellik isteği
description: Yeni bir işlev talep edin
title: "feat: <kısa açıklama>"
labels: [enhancement]
body:
  - type: textarea
    attributes:
      label: Problem / Fırsat
      description: Çözmek istediğiniz problemi açıklayın
    validations:
      required: true
  - type: textarea
    attributes:
      label: Önerilen çözüm
      description: Kısa çözüm taslağı
    validations:
      required: true
  - type: textarea
    attributes:
      label: Kabul kriterleri
      description: Done sayılması için koşullar (madde madde)
    validations:
      required: true
  - type: textarea
    attributes:
      label: Ek notlar
    validations:
      required: false
