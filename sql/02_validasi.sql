-- =====================================================================
-- File   : 02_validasi.sql
-- Tujuan : Validasi hasil tabel analisa
-- =====================================================================

-- 1. Jumlah baris (harus 672458), join gagal (harus 0), rentang tanggal
SELECT
  COUNT(*) AS total_baris,
  COUNTIF(branch_name IS NULL OR product_name IS NULL) AS join_gagal,
  MIN(date) AS tgl_awal,
  MAX(date) AS tgl_akhir,
  ROUND(SUM(nett_sales)) AS total_nett_sales,
  ROUND(SUM(nett_profit)) AS total_nett_profit
FROM `rakamin-kf-analytics-514117.kimia_farma.kf_tabel_analisa`;

-- 2. Cek manual satu transaksi (harga 118.700, diskon 5%)
--    Hasil benar: laba 0.20, nett_sales 112765, nett_profit 22553
SELECT actual_price, discount_percentage, persentase_gross_laba, nett_sales, nett_profit
FROM `rakamin-kf-analytics-514117.kimia_farma.kf_tabel_analisa`
WHERE transaction_id = 'TRX5844188';
