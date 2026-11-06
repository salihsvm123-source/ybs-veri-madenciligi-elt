with satislar as (
    select * from {{ ref('stg_satislar') }}
),

hava as (
    select * from {{ ref('stg_hava_durumu') }}
)

select
    s.siparis_id,
    s.siparis_tarihi,
    
    -- Tarih ve Gün Detayları (Zaman Boyutu):
    strftime(s.siparis_tarihi, '%A') as gun_adi_ingilizce,
    case extract(dow from s.siparis_tarihi)
        when 0 then 'Pazar'
        when 1 then 'Pazartesi'
        when 2 then 'Salı'
        when 3 then 'Çarşamba'
        when 4 then 'Perşembe'
        when 5 then 'Cuma'
        when 6 then 'Cumartesi'
    end as gun_adi,
    case 
        when extract(dow from s.siparis_tarihi) in (0, 6) then true 
        else false 
    end as hafta_sonu_mu,

    s.musteri_id,
    s.sehir,
    s.bolge,
    s.satis_kanali,
    s.kategori,
    s.urun_adi,
    s.miktar,
    s.birim_fiyat,
    s.maliyet,
    s.indirim_orani,
    s.toplam_ciro,
    s.net_kar,
    
    -- Hava Durumu Verileri:
    h.ortalama_sicaklik,
    h.max_sicaklik,
    h.min_sicaklik,
    coalesce(h.yagis_miktari, 0.0) as yagis_miktari,
    h.ruzgar_hizi,
    coalesce(h.hava_durumu_ozeti, 'Bilinmiyor') as hava_durumu
from satislar s
left join hava h
    on s.siparis_tarihi = h.tarih
    and lower(trim(s.sehir)) = lower(trim(h.sehir))