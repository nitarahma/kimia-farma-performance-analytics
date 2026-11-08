# Kimia Farma Performance Analytics 2020-2023

Proyek *Final Task* Rakamin Academy x Kimia Farma (Big Data Analytics, Project-Based Internship).
Tujuannya mengevaluasi kinerja bisnis Kimia Farma tahun 2020-2023 menggunakan Google BigQuery dan Looker Studio.

## Tools
- Google BigQuery (SQL)
- Google Looker Studio
- GitHub

## Dataset
| Tabel | Isi |
|---|---|
| `kf_final_transaction` | Data transaksi (672.458 baris, 2020-2023) |
| `kf_kantor_cabang` | Data cabang, kota, provinsi, dan rating cabang |
| `kf_product` | Data produk dan kategori |
| `kf_inventory` | Data stok produk per cabang |

## Struktur Repository
```
├── README.md
└── sql/
    ├── 01_create_tabel_analisa.sql
    └── 02_validasi.sql
```

## Langkah Pengerjaan
1. Membuat project BigQuery `Rakamin_KF_Analytics` dan dataset `kimia_farma`.
2. Mengimpor 4 file CSV menjadi tabel BigQuery (nama tabel sama dengan nama file tanpa `.csv`).
3. Memeriksa kualitas data: tidak ada nilai kosong, tidak ada duplikat `transaction_id`, dan semua `product_id` serta `branch_id` ada di tabel referensi.
4. Membuat tabel analisa `kf_tabel_analisa` dengan menggabungkan tabel transaksi, cabang, dan produk (`sql/01_create_tabel_analisa.sql`).
5. Memvalidasi hasil: jumlah baris, hasil join, dan perhitungan manual (`sql/02_validasi.sql`).
6. Membuat dashboard di Looker Studio dari tabel analisa.

## Kolom Tabel Analisa
| Kolom | Keterangan |
|---|---|
| `transaction_id` | Kode ID transaksi |
| `date` | Tanggal transaksi |
| `branch_id`, `branch_name`, `kota`, `provinsi` | Informasi cabang |
| `rating_cabang` | Penilaian konsumen terhadap cabang |
| `customer_name` | Nama customer |
| `product_id`, `product_name` | Informasi produk |
| `actual_price` | Harga obat sebelum diskon |
| `discount_percentage` | Persentase diskon |
| `persentase_gross_laba` | Persentase laba berdasarkan tingkat harga |
| `nett_sales` | Harga setelah diskon |
| `nett_profit` | Keuntungan yang diperoleh Kimia Farma |
| `rating_transaksi` | Penilaian konsumen terhadap transaksi |

## Rumus
- `nett_sales = actual_price x (1 - discount_percentage)`
- `nett_profit = nett_sales x persentase_gross_laba`

| Harga obat | Persentase laba |
|---|---|
| <= Rp 50.000 | 10% |
| > Rp 50.000 - Rp 100.000 | 15% |
| > Rp 100.000 - Rp 300.000 | 20% |
| > Rp 300.000 - Rp 500.000 | 25% |
| > Rp 500.000 | 30% |

## Dashboard
- Dashboard Looker Studio: 

## Author
Nita Rahmawati
