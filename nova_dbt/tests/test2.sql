SELECT 
    siparis_id,
    indirim_orani
FROM {{ ref('fct_gunluk_satis_hava') }}
WHERE indirim_orani < 0.0 
   OR indirim_orani > 1.0