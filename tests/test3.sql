SELECT 
    siparis_tarihi,
    sehir,
    ortalama_sicaklik
FROM {{ ref('fct_gunluk_satis_hava') }}
WHERE ortalama_sicaklik IS NOT NULL 
  AND (ortalama_sicaklik < -35.0 OR ortalama_sicaklik > 50.0)