# FOOD DELIVERY BUSINESS PERFORMANCE ANALYSIS 

## Project Overview
Proyek ini menganalisis kinerja bisnis platform layanan pesan-antar makanan (food delivery) menggunakan SQL dan PostgreSQL. Analisis mencakup tren jumlah pesanan dan nilai transaksi makanan, kontribusi restoran mitra dan kota berdasarkan lokasi restoran, perilaku pelanggan, performa jenis masakan (cuisine), distribusi status pesanan, serta perbandingan rating dan kinerja transaksi restoran.

Dengan memanfaatkan lima tabel yang saling berelasi, proyek ini menggunakan SQL untuk memeriksa kualitas data, mengeksplorasi karakteristik dataset, dan menjawab delapan pertanyaan bisnis. Hasil analisis digunakan untuk mengidentifikasi pola transaksi dan temuan yang relevan sebagai dasar pertimbangan dalam pengambilan keputusan bisnis platform.

## Analysis Objectives
Analisis ini bertujuan untuk mengevaluasi kinerja bisnis platform layanan pesan-antar makanan melalui pengolahan dan analisis data transaksi menggunakan SQL. Fokus analisis mencakup identifikasi tren pemesanan dan nilai transaksi makanan, kontribusi restoran mitra dan wilayah operasional, perilaku pemesanan pelanggan, serta performa jenis masakan. Selain itu, analisis dilakukan untuk mengevaluasi distribusi status pesanan, tingkat pembatalan, dan proporsi keterlambatan pengiriman, serta membandingkan rating restoran dengan jumlah pesanan dan nilai transaksi makanan. Hasil analisis diharapkan dapat memberikan gambaran mengenai kinerja bisnis, mengidentifikasi pola dan area yang memerlukan perhatian lebih lanjut, serta menghasilkan insight berbasis data sebagai bahan pertimbangan dalam pengambilan keputusan bisnis.

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

## Cuisine Performance
**Business Performance**: Jenis masakan (cuisine) mana yang memiliki nilai transaksi makanan tertinggi, dan bagaimana perbandingannya dengan jumlah restoran serta jumlah pesanan?

**Analysis Method**: Data transaksi dikelompokkan berdasarkan jenis masakan. Analisis membandingkan jumlah restoran, jumlah pesanan, total nilai transaksi makanan, serta persentase kontribusi setiap jenis masakan terhadap keseluruhan nilai transaksi.

**Output**:
| cuisine | total_restoran | total_pesanan | total_nilai_transaksi | kontribusi_transaksi_persen |
|:---|---:|---:|---:|---:|
| Thai | 26 | 759 | 86894.49 | 22.97 |
| Indian | 22 | 607 | 69969.33 | 18.49 |
| Mexican | 20 | 557 | 62341.32 | 16.48 |
| American | 19 | 584 | 62318.18 | 16.47 |
| Italian | 20 | 545 | 59408.08 | 15.70 |
| Chinese | 13 | 336 | 37418.92 | 9.89 |

**Key Insights**:
- Thai menjadi jenis masakan dengan nilai transaksi makanan tertinggi sebesar 86894.49 atau 22.97% dari total nilai transaksi makanan, didukung oleh 26 restoran dan 759 pesanan, yang juga merupakan jumlah restoran dan pesanan terbanyak dibandingkan jenis masakan lainnya.
- Indian menempati posisi kedua dengan nilai transaksi makanan sebesar 69969.33 atau 18.49%, didukung oleh 22 restoran dan 607 pesanan.
- American menghasilkan nilai transaksi makanan sebesar 62318.18 dari 584 pesanan dan 19 restoran, sedangkan Mexican mencatat nilai transaksi sedikit lebih tinggi, yaitu 62341.32, meskipun memiliki jumlah pesanan lebih sedikit (557 pesanan) dan jumlah restoran lebih banyak (20 restoran).
- Secara keseluruhan, Thai memberikan kontribusi nilai transaksi makanan terbesar sekaligus memiliki jumlah restoran dan pesanan tertinggi. Namun, perbandingan antara American dan Mexican menunjukkan bahwa jumlah pesanan yang lebih tinggi tidak selalu menghasilkan nilai transaksi makanan yang lebih besar.

## Order Status Distribution & Cancellation Rates
**Business Question**: Bagaimana distribusi status pesanan, dan kota mana yang memiliki tingkat pembatalan pesanan tertinggi dan terendah berdasarkan lokasi restoran?

**Analysis Method**: Analisis dilakukan dalam dua bagian. Pertama, menghitung jumlah dan persentase pesanan berdasarkan status. Kedua, menghitung tingkat pembatalan setiap kota restoran dengan membandingkan jumlah pesanan Cancelled terhadap seluruh pesanan di kota tersebut.

**Output**:
Distribusi status pesanan
| status | total_pesanan | persentase_pesanan |
|:---|---:|---:|
| Delivered | 1717 | 34.34 |
| Late | 1671 | 33.42 |
| Cancelled | 1612 | 32.24 |

Tingkat pembatalan pesanan berdasarkan kota restoran
| kota_restoran | total_pesanan | total_pesanan_dibatalkan | tingkat_pembatalan_persen |
|:---|---:|---:|---:|
| Liverpool | 947 | 316 | 33.37 |
| Leeds | 1060 | 352 | 33.21 |
| London | 721 | 234 | 32.45 |
| Birmingham | 694 | 225 | 32.42 |
| Manchester | 790 | 255 | 32.28 |
| Bristol | 788 | 230 | 29.19 |

**Key Insights**: 
- Dari total 5000 pesanan, status Delivered memiliki proporsi terbesar, yaitu 34.34% atau 1717 pesanan, diikuti Late sebesar 33.42% atau 1671 pesanan, dan Cancelled sebesar 32.24% atau 1612 pesanan. Distribusi ketiga status tersebut relatif merata.
- Liverpool menjadi kota dengan tingkat pembatalan pesanan tertinggi berdasarkan lokasi restoran, yaitu 33.37% atau 316 pesanan dibatalkan dari total 947 pesanan.
- Bristol mencatat tingkat pembatalan pesanan terendah, yaitu 29.19% atau 230 pesanan dibatalkan dari total 788 pesanan.
- Meskipun Leeds memiliki jumlah pembatalan terbanyak, yaitu 352 pesanan, tingkat pembatalannya sebesar 33.21% masih lebih rendah dibandingkan Liverpool. Hal ini menunjukkan bahwa jumlah pesanan yang dibatalkan tidak selalu mencerminkan tingkat pembatalan tertinggi, karena tingkat pembatalan dihitung berdasarkan proporsi pesanan yang dibatalkan terhadap total pesanan di masing-masing kota.

## Restaurant Performance 
**Business Question**: Apakah restoran dengan rating tertinggi juga memiliki jumlah pesanan dan nilai transaksi makanan tertinggi?

**Analysis Method**: Menghitung jumlah pesanan dan total nilai transaksi makanan setiap restoran dari pesanan berstatus Delivered dan Late. Menggunakan fungsi RANK() untuk menentukan peringkat restoran secara terpisah berdasarkan rating, jumlah pesanan, dan nilai transaksi makanan. Hasilnya difilter untuk menampilkan restoran yang menempati peringkat pertama pada minimal satu dari ketiga indikator tersebut, kemudian dibandingkan untuk mengetahui apakah restoran dengan rating tertinggi juga memiliki jumlah pesanan dan nilai transaksi makanan tertinggi.

**Output**:
| restaurant_id | rating | total_pesanan | total_nilai_transaksi | peringkat_rating | peringkat_pesanan | peringkat_transaksi |
|:---|---:|---:|---:|---:|---:|---:|
| R115 | 5.0 | 30 | 3757.24 | 1 | 46 | 22 |
| R020 | 5.0 | 24 | 2525.61 | 1 | 88 | 98 |
| R030 | 5.0 | 24 | 2254.77 | 1 | 88 | 109 |
| R096 | 4.0 | 43 | 4807.87 | 59 | 1 | 2 |
| R073 | 3.3 | 38 | 5169.48 | 101 | 4 | 1 |

**Key Insights**:
- R115, R030, dan R020 sama-sama memiliki rating tertinggi, yaitu 5.0. Namun, ketiganya memiliki jumlah pesanan dan nilai transaksi makanan yang berbeda, serta tidak menempati posisi tertinggi pada kedua indikator tersebut.
- R096 mencatat jumlah pesanan tertinggi, yaitu 43 pesanan, dengan rating 4.0 dan nilai transaksi makanan sebesar 4807.87.
- R073 menghasilkan nilai transaksi makanan tertinggi sebesar 5169.48 dari 38 pesanan, meskipun memiliki rating 3.3.
- Hasil analisis menunjukkan bahwa restoran dengan rating tertinggi tidak sekaligus memiliki jumlah pesanan maupun nilai transaksi makanan tertinggi. Restoran dengan rating lebih rendah juga dapat mencatat performa transaksi yang lebih tinggi.

## Restaurants with the Highest Late Order Rates
**Business Question**: Restoran mana yang memiliki proporsi pesanan berstatus Late tertinggi di antara pesanan berstatus Delivered dan Late, dengan minimal 10 pesanan dalam gabungan kedua status tersebut?

**Analysis Method**: Proporsi pesanan Late dihitung dengan membandingkan jumlah pesanan Late terhadap total pesanan Delivered dan Late pada setiap restoran. Analisis dibatasi pada restoran dengan minimal 10 pesanan dalam gabungan kedua status tersebut.

**Output**: 
| restaurant_id | total_pesanan | total_pesanan_late | persentase_late |
|:---|---:|---:|---:|
| R085 | 31 | 23 | 74.19 |
| R093 | 31 | 22 | 70.97 |
| R053 | 26 | 17 | 65.38 |
| R064 | 31 | 20 | 64.52 |
| R044 | 25 | 16 | 64.00 |

**Key Insights**:
- R085 memiliki proporsi pesanan berstatus Late tertinggi, yaitu 74.19% atau 23 dari 31 pesanan berstatus Delivered dan Late, sehingga menempati peringkat pertama di antara restoran yang memenuhi kriteria minimal 10 pesanan.
- R093 menempati posisi kedua dengan proporsi pesanan Late sebesar 70.97% atau 22 dari 31 pesanan, diikuti R053 sebesar 65.38% atau 17 dari 26 pesanan.
- R064 dan R044 melengkapi lima restoran dengan proporsi pesanan Late tertinggi, masing-masing sebesar 64.52% (20 dari 31 pesanan) dan 64.00% (16 dari 25 pesanan).
- Hasil analisis menunjukkan bahwa kelima restoran tersebut memiliki proporsi pesanan Late di atas 60%, sehingga pesanan dari restoran-restoran tersebut perlu diperhatikan lebih lanjut untuk mengetahui penyebab keterlambatannya. Keterlambatan tidak selalu disebabkan oleh restoran, tetapi juga dapat dipengaruhi oleh proses pengiriman atau faktor lainnya.

# Business Recommendations
Berdasarkan hasil analisis, terdapat beberapa rekomendasi yang dapat menjadi bahan pertimbangan untuk meningkatkan kinerja bisnis platform:
1. Mempertahankan pelanggan berulang. Pelanggan berulang menyumbang 89,58% dari total pesanan berstatus Delivered dan Late. Platform dapat mempertimbangkan program loyalitas atau penawaran khusus untuk mendorong pelanggan tetap aktif melakukan pemesanan.
2. Mengevaluasi strategi pengembangan restoran mitra. Restoran dengan rating tertinggi tidak selalu memiliki jumlah pesanan atau nilai transaksi makanan tertinggi. Oleh karena itu, evaluasi kinerja restoran sebaiknya mempertimbangkan beberapa indikator, seperti rating, jumlah pesanan, dan nilai transaksi makanan.
3. Memanfaatkan performa jenis masakan untuk strategi promosi. Masakan Thai memberikan kontribusi nilai transaksi makanan terbesar, yaitu 22,97%. Temuan ini dapat menjadi pertimbangan dalam menentukan prioritas promosi, dengan membandingkan jumlah pesanan, jumlah restoran, dan nilai transaksi makanan pada setiap jenis masakan.
4. Meninjau proses pembatalan pesanan. Liverpool memiliki tingkat pembatalan tertinggi sebesar 33,37%. Platform dapat melakukan analisis lanjutan untuk memahami faktor yang menyebabkan pembatalan dan menentukan langkah perbaikan yang sesuai.
5. Menyelidiki keterlambatan pengiriman. R085 memiliki proporsi pesanan berstatus Late tertinggi sebesar 74,19%. Platform dapat memprioritaskan pemeriksaan proses pemenuhan dan pengiriman pesanan yang terkait dengan restoran tersebut, tanpa langsung menyimpulkan bahwa keterlambatan disebabkan oleh pihak restoran.

# Project Limitations
- Dataset yang digunakan merupakan data simulasi, sehingga hasil analisis tidak secara langsung menggambarkan kondisi bisnis platform pesan-antar makanan yang sebenarnya.
- Nilai transaksi makanan dihitung berdasarkan jumlah item dan harga dalam pesanan berstatus Delivered dan Late. Nilai ini tidak merepresentasikan pendapatan bersih atau keuntungan platform.

# Conclusion
Analisis menggunakan SQL dan PostgreSQL ini memberikan gambaran mengenai kinerja transaksi, perilaku pelanggan, kontribusi restoran dan jenis masakan, serta kondisi operasional pesanan pada platform food delivery. Hasil analisis menunjukkan bahwa pelanggan berulang memberikan kontribusi terbesar terhadap jumlah pesanan berstatus Delivered dan Late, sementara performa restoran berdasarkan rating tidak selalu sejalan dengan jumlah pesanan maupun nilai transaksi makanan. Selain itu, perbedaan tingkat pembatalan antarwilayah dan proporsi pesanan Late pada sejumlah restoran menunjukkan adanya area yang dapat diteliti lebih lanjut. Secara keseluruhan, proyek ini menunjukkan bagaimana SQL dapat digunakan untuk mengolah data relasional, menghitung indikator kinerja bisnis, membandingkan hasil antarsegmen, dan menghasilkan insight yang relevan sebagai dasar pertimbangan pengambilan keputusan bisnis.
