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

## Business Questions, Results & Key Insights
### Tren Jumlah Pesanan dan Nilai Transaksi Makanan
**Business Question**: Bagaimana tren jumlah pesanan dan nilai transaksi makanan dari pesanan berstatus Delivered dan Late selama periode Januari 2023 hingga Mei 2024?

**Analysis Method**: Data pesanan dikelompokkan berdasarkan bulan menggunakan DATE_TRUNC(). Fungsi LAG() digunakan untuk membandingkan nilai transaksi makanan dengan bulan sebelumnya, sedangkan persentase perubahan dihitung untuk melihat peningkatan atau penurunan secara bulanan.

**Output**: 
| bulan | total_pesanan | nilai_transaksi_makanan | nilai_transaksi_bulan_sebelumnya | perubahan_nilai_transaksi_persen |
|:---|---:|---:|---:|---:|
| January 2023 | 197 | 20688.38 | - | - |
| February 2023 | 196 | 20781.99 | 20688.38 | 0.45 |
| March 2023 | 228 | 25307.37 | 20781.99 | 21.78 |
| April 2023 | 216 | 24070.28 | 25307.37 | -4.89 |
| May 2023 | 200 | 22403.62 | 24070.28 | -6.92 |
| June 2023 | 213 | 24679.59 | 22403.62 | 10.16 |
| July 2023 | 229 | 26194.10 | 24679.59 | 6.14 |
| August 2023 | 194 | 22492.77 | 26194.10 | -14.13 |
| September 2023 | 204 | 23581.87 | 22492.77 | 4.84 |
| October 2023 | 212 | 23973.02 | 23581.87 | 1.66 |
| November 2023 | 191 | 22385.84 | 23973.02 | -6.62 |
| December 2023 | 213 | 22516.46 | 22385.84 | 0.58 |
| January 2024 | 204 | 21776.08 | 22516.46 | -3.29 |
| February 2024 | 211 | 21795.08 | 21776.08 | 0.09 |
| March 2024 | 201 | 24625.26 | 21795.08 | 12.99 |
| April 2024 | 178 | 19990.87 | 24625.26 | -18.82 |
| May 2024 | 101 | 11087.74 | 19990.87 | -44.54 |

Catatan: Mei 2024 hanya mencakup data hingga tanggal 15 Mei.

**Key Insights**:
- July 2023 mencatat jumlah pesanan tertinggi, yaitu 229 pesanan, dengan nilai transaksi makanan sebesar 26.194,10. Nilai tersebut juga menjadi yang tertinggi selama periode analisis.
- Peningkatan nilai transaksi bulanan terbesar terjadi pada Maret 2023, yaitu sebesar 21,78% dibandingkan Februari 2023.
- Penurunan terbesar pada bulan dengan cakupan data penuh terjadi pada April 2024, yaitu sebesar 18,82% dibandingkan Maret 2024.
- Pada Maret 2024, nilai transaksi kembali meningkat sebesar 12,99% setelah relatif stabil pada Januari dan Februari 2024.
- Nilai transaksi Mei 2024 tercatat turun 44,54% dibandingkan April. Namun, angka ini belum dapat dibandingkan secara langsung karena data Mei hanya mencakup setengah bulan.

### Restaurant Performance & Average Order Value
**Business Question**: Restoran mana yang memiliki nilai transaksi makanan tertinggi, dan bagaimana perbandingannya dengan jumlah pesanan serta rata-rata nilai per pesanan?

**Analysis Method**: Nilai transaksi dihitung dari perkalian jumlah item dan harga pada setiap pesanan. Selanjutnya, data dikelompokkan berdasarkan restoran untuk memperoleh total pesanan, total nilai transaksi, dan rata-rata nilai per pesanan atau AOV.

**Output**: 
| restaurant_id | total_pesanan | total_nilai_transaksi | rata-rata_nilai_pesanan |
|---|---:|---:|---:|
| R073 | 38 | 5169.48 | 136.04 |
| R096 | 43 | 4807.87 | 111.81 |
| R061 | 34 | 4520.73 | 132.96 |
| R088 | 34 | 4511.19 | 132.68 |
| R103 | 31 | 4313.13 | 139.13 |

**Key Insights**:
- R073 menjadi restoran dengan nilai transaksi makanan tertinggi, yaitu sebesar 5169.48 dari 38 pesanan, dengan Average Order Value (AOV) atau rata-rata nilai per pesanan sebesar 136.04.
- R096 mencatat jumlah pesanan terbanyak di antara lima restoran dengan nilai transaksi makanan tertinggi, yaitu 43 pesanan. Namun, nilai transaksinya sebesar 4807.87 masih lebih rendah dibandingkan R073 yang memiliki 38 pesanan.
- Perbandingan tersebut menunjukkan bahwa jumlah pesanan yang lebih banyak tidak selalu menghasilkan nilai transaksi makanan yang lebih tinggi. R073 memiliki nilai transaksi terbesar karena AOV-nya lebih tinggi dibandingkan R096, sehingga menghasilkan total nilai transaksi yang lebih besar meskipun jumlah pesanannya lebih sedikit.

### Restaurant City Performance
**Business Question**: Kota mana yang memiliki jumlah pesanan dan nilai transaksi makanan tertinggi berdasarkan lokasi restoran?

**Analysis Methode**: Pesanan dikelompokkan berdasarkan kota restoran menggunakan JOIN antara tabel orders, order_items, dan restaurants. Perbandingan dilakukan berdasarkan jumlah pesanan dan total nilai transaksi makanan.

**Output**:
| kota_restoran | total_pesanan | total_nilai_traksaksi |
|:---|---:|---:|
| Leeds | 708 | 75894.85 |
| Liverpool | 631 | 71663.30 |
| Bristol | 558 | 60738.83 |
| Manchester | 535 | 60261.93 |
| Birmingham | 469 | 55183.37 |
| London | 487 | 54608.04 |

**Key Insights**:
- Leeds menjadi kota dengan jumlah pesanan dan nilai transaksi makanan tertinggi berdasarkan lokasi restoran, yaitu sebanyak 708 pesanan dengan total nilai transaksi sebesar 75894.85.
- Liverpool menempati posisi kedua pada kedua indikator tersebut, dengan 631 pesanan dan nilai transaksi makanan sebesar 71663.30, diikuti oleh Bristol dengan 558 pesanan dan nilai transaksi sebesar 60738.83.
- Secara keseluruhan, Leeds merupakan kota dengan kontribusi terbesar terhadap aktivitas pemesanan dan nilai transaksi makanan selama periode analisis. Sementara itu, Birmingham memiliki jumlah pesanan terendah (469 pesanan) dan London mencatat nilai transaksi makanan terendah (54608.04).

## Customer Segmentation & Order Contribution
**Business Question**: Seberapa besar proporsi pelanggan berulang dan kontribusinya terhadap total pesanan yang berstatus Delivered dan Late?

**Analysis Method**: Pelanggan dikelompokkan berdasarkan jumlah pesanan yang berstatus Delivered dan Late. Pelanggan dengan satu pesanan dimasukkan ke segmen Satu pesanan, sedangkan pelanggan dengan lebih dari satu pesanan dimasukkan ke segmen Pelanggan berulang.

**Output**:
| segmen_pelanggan | total_pelanggan | total_pesanan | persentase_pelanggan | persentase_pesanan |
|:---|---:|---:|---:|---:|
| Pelanggan berulang | 1000 | 3035 | 73.91 | 89.58 |
| Satu pesanan | 353 | 353 | 26.09 | 10.42 |

**Key Insights**:
- Pelanggan berulang mencakup 73.91% dari total pelanggan yang memiliki pesanan berstatus Delivered atau Late, yaitu sebanyak 1000 pelanggan, dan berkontribusi sebesar 89.58% terhadap total pesanan dengan kedua status tersebut, atau sebanyak 3035 pesanan.
- Sebaliknya, pelanggan yang hanya melakukan satu pesanan mencakup 26.09% atau 353 pelanggan, dengan kontribusi sebesar 10.42% terhadap total pesanan berstatus Delivered atau Late, yaitu sebanyak 353 pesanan.
- Temuan ini menunjukkan bahwa pelanggan berulang mendominasi jumlah pelanggan sekaligus memberikan kontribusi terbesar terhadap total pesanan berstatus Delivered dan Late selama periode analisis.
