SELECT 
    siparis_id,
    miktar,
    birim_fiyat,
    toplam_ciro
FROM {{ ref('fct_gunluk_satis_hava') }}
WHERE miktar <= 0 
   OR birim_fiyat <= 0 
   OR toplam_ciro < 0