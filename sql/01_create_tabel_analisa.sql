-- =====================================================================
-- Project   : Kimia Farma Performance Analytics 2020-2023
-- File      : 01_create_tabel_analisa.sql
-- Tujuan    : Membuat tabel analisa dari agregasi 4 tabel sumber
-- Sumber    : kf_final_transaction, kf_kantor_cabang, kf_product
--             (kf_inventory diimpor sesuai ketentuan, tidak dipakai di tabel ini)
-- Output    : kimia_farma.kf_tabel_analisa
-- =====================================================================

CREATE OR REPLACE TABLE `rakamin-kf-analytics-514117.kimia_farma.kf_tabel_analisa` AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating AS rating_cabang,              -- rating konsumen terhadap cabang
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price AS actual_price,                -- harga obat sebelum diskon
  t.discount_percentage,

  -- Persentase laba yang seharusnya diterima, berdasarkan tingkat harga
  CASE
    WHEN t.price <= 50000  THEN 0.10      -- <= Rp 50.000
    WHEN t.price <= 100000 THEN 0.15      -- > Rp 50.000 s.d. Rp 100.000
    WHEN t.price <= 300000 THEN 0.20      -- > Rp 100.000 s.d. Rp 300.000
    WHEN t.price <= 500000 THEN 0.25      -- > Rp 300.000 s.d. Rp 500.000
    ELSE 0.30                             -- > Rp 500.000
  END AS persentase_gross_laba,

  -- nett_sales = harga setelah diskon
  t.price * (1 - t.discount_percentage) AS nett_sales,

  -- nett_profit = nett_sales x persentase laba
  t.price * (1 - t.discount_percentage) *
  CASE
    WHEN t.price <= 50000  THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit,

  t.rating AS rating_transaksi            -- rating konsumen terhadap transaksi
FROM `rakamin-kf-analytics-514117.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-514117.kimia_farma.kf_kantor_cabang` c
  ON t.branch_id = c.branch_id
LEFT JOIN `rakamin-kf-analytics-514117.kimia_farma.kf_product` p
  ON t.product_id = p.product_id;
