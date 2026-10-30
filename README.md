# FOOD DELIVERY BUSINESS PERFORMANCE ANALYSIS 

## Project Overview
Proyek ini menganalisis kinerja bisnis platform layanan pesan-antar makanan (food delivery) menggunakan SQL dan PostgreSQL. Analisis mencakup tren jumlah pesanan dan nilai transaksi makanan, kontribusi restoran mitra dan kota, perilaku pelanggan, performa jenis masakan (cuisine), serta distribusi status pesanan.

Dengan memanfaatkan lima tabel yang saling berelasi, proyek ini menggunakan SQL untuk memeriksa kualitas data, mengeksplorasi karakteristik dataset, dan menjawab delapan pertanyaan bisnis. Hasil analisis digunakan untuk mengidentifikasi pola transaksi dan temuan yang relevan sebagai dasar pertimbangan dalam pengambilan keputusan bisnis platform.

## Analysis Objectives
Proyek ini bertujuan untuk:
- Mengidentifikasi tren jumlah pesanan dan nilai transaksi makanan dari waktu ke waktu.
- Mengetahui restoran dan kota dengan nilai transaksi makanan tertinggi.
- Memahami proporsi pelanggan berulang serta kontribusinya terhadap total pesanan.
- Mengidentifikasi jenis masakan dengan kontribusi transaksi terbesar.
- Menganalisis distribusi status pesanan dan tingkat pembatalan berdasarkan kota restoran.
- Membandingkan performa restoran berdasarkan rating, jenis masakan, dan lokasi.
- Mengidentifikasi restoran dengan proporsi pesanan terlambat (Late) tertinggi.

## Dataset Overview
Dataset yang digunakan berasal dari Kaggle: [Dataset Food Delivery](https://www.kaggle.com/datasets/nudratabbas/sql-practice-dataset-2-medium-queries)
Dataset simulasi ini mencakup informasi pelanggan, restoran, menu makanan, pesanan, dan detail item dalam setiap pesanan. 

## Database Structure
Database terdiri dari lima tabel:

| Tabel | Deskripsi |
|:---|:---|
| customers | ID pelanggan, kota pelanggan, dan tanggal pendaftaran |
| menu_items | ID item menu, ID restoran, dan harga item |
| order_items | ID pesanan, ID item menu, jumlah item yang dipesan, dan harga item |
| orders | ID pesanan, ID pelanggan, ID restoran, tanggal pemesanan, waktu pengiriman, dan status pesanan |
| restaurants | ID restoran, jenis masakan, kota restoran, dan rating |

## Dataset Scope
| Tabel | Jumlah baris |
|:---|:---:|
| customers | 1.500 |
| menu_items | 400 |
| order_items | 12.391 |
| orders | 5.000 |
| restaurants | 120|

Periode data pesanan berdasarkan tanggal pemesanan: 1 Januari 2023 – 15 Mei 2024.

## Tools & Technologies
- PostgreSQL - Sistem manajemen database relasional untuk menyimpan dan mengolah data.
- pgAdmin 4 - Antarmuka untuk mengelola database dan menjalankan query SQL.
- SQL - Bahasa query untuk pemeriksaan kualitas data, eksplorasi data, dan analisis bisnis.
- GitHub - Platform untuk menyimpan dan mendokumentasikan project.

## Analysis Workflow
1. Persiapan Database
2. Pemeriksaan Kualitas Data (Data Quality Checks)
3. Eksplorasi Data
4. Analisis Bisnis

