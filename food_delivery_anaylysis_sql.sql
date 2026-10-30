/* ======================================================================
	PROJECT  : FOOD DELIVERY BUSINESS PERFORMANCE ANALYSIS USING SQL
	DATABASE : food_delivery_analysis
	SCHEMA   : food_delivery
	DBMS     : PostgreSQL
	TOOL     : pgAdmin 4
========================================================================= */

/* ======================================================================
	1. PERSIAPAN
========================================================================= */

--1.1 Membuat tabel customers
CREATE TABLE food_delivery.customers(
	customer_id VARCHAR(15) PRIMARY KEY,
	city VARCHAR(50),
	signup_date DATE
);

-- 1.2 Membuat tabel restaurts
CREATE TABLE food_delivery.restaurants(
	restaurant_id VARCHAR(15) PRIMARY KEY,
	cuisine VARCHAR(50),
	city VARCHAR(50),
	rating NUMERIC(2, 1)
);

-- 1.3 Membuat tabel menu_items
CREATE TABLE food_delivery.menu_items(
	item_id VARCHAR(15) PRIMARY KEY,
	restaurant_id VARCHAR(15),
	price NUMERIC(10, 2)
);

-- 1.4 Membuat tabel orders
CREATE TABLE food_delivery.orders(
	order_id VARCHAR(15) PRIMARY KEY,
	customer_id VARCHAR(15),
	restaurant_id VARCHAR(15),
	order_time DATE,
	delivery_time TIMESTAMP,
	status VARCHAR(20)
);

-- 1.5 Membuat tabel order_items
CREATE TABLE food_delivery.order_items(
	order_id VARCHAR(15),
	item_id VARCHAR(15),
	quantity INTEGER,
	price NUMERIC(10, 2)
);

-- 1.6 Menampilkan tabel customer
SELECT * FROM food_delivery.customers

-- 1.7 Menampilkan tabel menu_items
SELECT * FROM food_delivery.menu_items

-- 1.8 Menampilkan tabel order_items
SELECT * FROM food_delivery.order_items

-- 1.9 Menampilkan tabel orders
SELECT * FROM food_delivery.orders

-- 1.10 Menampilkan tabel restaurants
SELECT * FROM food_delivery.restaurants

/* ======================================================================
	2. DATA QUALITY CHECKS
========================================================================= */

-- 2.1 Memeriksa missing values pada setiap kolom di tabel customers
SELECT
    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS missing_customer_id,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(city), '') IS NULL
    ) AS missing_city,
    COUNT(*) FILTER (
        WHERE signup_date IS NULL
    ) AS missing_signup_date
FROM food_delivery.customers;
-- Tidak ditemukan missing values pada setiap kolom di tabel customers 

--2.2 Memeriksa missing values pada setiap kolom di tabel menu_items
SELECT
    COUNT(*) FILTER (
        WHERE item_id IS NULL
    ) AS missing_item_id,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(restaurant_id), '') IS NULL
    ) AS missing_restaurant_id,
    COUNT(*) FILTER (
        WHERE price IS NULL
    ) AS missing_price
FROM food_delivery.menu_items;
-- Tidak ditemukan missing values pada setiap kolom di tabel menu_items

-- 2.3 Memeriksa missing values pada setiap kolom di tabel order_items
SELECT
    COUNT(*) FILTER (
        WHERE order_id IS NULL
    ) AS missing_order_id,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(item_id), '') IS NULL
    ) AS missing_item_id,
    COUNT(*) FILTER (
        WHERE quantity IS NULL
    ) AS missing_quantity,
    COUNT(*) FILTER (
        WHERE price IS NULL
    ) AS missing_price
FROM food_delivery.order_items;
-- Tidak ditemukan missing values pada setiap kolom di tabel order_items

-- 2.4 Memeriksa missing values pada setiap kolom di tabel orders
SELECT
    COUNT(*) FILTER (
        WHERE order_id IS NULL
    ) AS missing_order_id,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(customer_id), '') IS NULL
    ) AS missing_customer_id,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(restaurant_id), '') IS NULL
    ) AS missing_restaurant_id,
    COUNT(*) FILTER (
        WHERE order_time IS NULL
    ) AS missing_order_time,
    COUNT(*) FILTER (
        WHERE delivery_time IS NULL
    ) AS missing_delivery_time,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(status), '') IS NULL
    ) AS missing_status
FROM food_delivery.orders;
-- Tidak ditemukan missing values pada setiap kolom di tabel orders

-- 2.5 Memeriksa missing values pada setiap kolom di tabel restaurants
SELECT
    COUNT(*) FILTER (
        WHERE restaurant_id IS NULL
    ) AS missing_restaurant_id,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(cuisine), '') IS NULL
    ) AS missing_cuisine,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(city), '') IS NULL
    ) AS missing_city,
    COUNT(*) FILTER (
        WHERE rating IS NULL
    ) AS missing_rating
FROM food_delivery.restaurants;
-- Tidak ditemukan missing values pada setiap kolom di tabel restaurants

-- 2.6 Memeriksa duplikasi pada customer_id
SELECT
	customer_id,
	COUNT(*) AS total_kemunculan
FROM
	food_delivery.customers
GROUP BY
	customer_id
HAVING
	COUNT(*) > 1;
-- Tidak ditemukan duplikasi pada kolom customer_id

-- 2.7 Memeriksa duplkasi pada kolom item_id
SELECT
	item_id,
	COUNT(*) AS total_kemunculan
FROM
	food_delivery.menu_items
GROUP BY
	item_id
HAVING
	COUNT(*) > 1;
-- Tidak ditemukan duplikasi pada kolom item_id

-- 2.8 Memeriksa duplikasi pada kolom order_id
SELECT
	order_id,
	COUNT(*) AS total_kemunculan
FROM
	food_delivery.orders
GROUP BY
	order_id
HAVING
	COUNT(*) > 1;
-- Tidak ditemukan duplikasi pada kolom order_id

-- 2.9 Memeriksa duplikasi pada kolom restaurant_id
SELECT
	restaurant_id,
	COUNT(*) AS total_kemunculan
FROM
	food_delivery.restaurants
GROUP BY
	restaurant_id
HAVING
	COUNT(*) > 1;
-- Tidak ditemukan duplikasi pada kolom restaurant_id

-- 2.10 Memeriksa duplikasi kombinasi order_id dan item_id 
SELECT
	order_id,
	item_id,
	COUNT(*) AS total_kemunculan
FROM
	food_delivery.order_items
GROUP BY
	order_id,
	item_id
HAVING
	COUNT(*) > 1;
-- Tidak ditemukan duplikasi pada kombinasi order_id dan item_id

/* Menetapkan kombinasi order_id dan item_id sebagai
Primary Key untuk memastikan setiap pasangan
pesanan dan item makanan bersifat unik.
*/
ALTER TABLE food_delivery.order_items
ADD CONSTRAINT order_items_pkey
PRIMARY KEY (order_id, item_id);

-- 2.11 Memeriksa referential integrity
-- Memeriksa apakah order_id pada tabel order_items memiliki pasangan pada tabel orders.
SELECT oi.order_id
FROM food_delivery.order_items AS oi
LEFT JOIN food_delivery.orders AS o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
-- Memeriksa apakah item_id pada tabel order_items memiliki pasangan pada tabel menu_items.
SELECT oi.item_id
FROM food_delivery.order_items AS oi
LEFT JOIN food_delivery.menu_items AS mi ON oi.item_id = mi.item_id
WHERE mi.item_id IS NULL;
-- Memeriksa apakah customer_id pada tabel orders memiliki pasangan pada tabel customers.
SELECT o.customer_id
FROM food_delivery.orders AS o
LEFT JOIN food_delivery.customers AS c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- Memeriksa apakah restaurant_id pada tabel orders memiliki pasangan pada tabel restaurants.
SELECT o.restaurant_id
FROM food_delivery.orders AS o
LEFT JOIN food_delivery.restaurants AS r ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

/* ======================================================================
	3. DATA EXPLORATION
========================================================================= */

-- 3.1 Jumlah baris setiap tabel
SELECT 'customers' AS nama_tabel, COUNT(*) AS total_baris
FROM food_delivery.customers
UNION ALL
SELECT 'restaurants', COUNT(*) FROM food_delivery.restaurants
UNION ALL
SELECT 'menu_items', COUNT(*) FROM food_delivery.menu_items
UNION ALL
SELECT 'orders', COUNT(*) FROM food_delivery.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM food_delivery.order_items;

-- 3.2 Memeriksa periode analisis berdasarkan order_time
SELECT
	MIN(order_time) AS tanggal_pesanan_pertama,
	MAX(order_time) AS tanggal_pesanan_terakhir
FROM food_delivery.orders;

-- 3.3 Jumlah pelanggan terdaftar berdasarkan kota pelanggan 
SELECT city, COUNT(*) AS jumlah_pelanggan
FROM food_delivery.customers
GROUP BY city
ORDER BY jumlah_pelanggan DESC;

-- 3.4 Distribusi restoran berdasarkan kota dan jenis masakan (cuisine)
SELECT
    city,
    cuisine,
    COUNT(*) AS total_restoran
FROM food_delivery.restaurants
GROUP BY city, cuisine
ORDER BY total_restoran DESC;

/* ======================================================================
	4. DATA ANALYSIS
========================================================================= */

/* Business Question 1 
Bagaimana tren jumlah pesanan dan nilai transaksi makanan dari pesanan 
berstatus Delivered dan Late selama periode Januari 2023 hingga Mei 2024?
*/

WITH monthly_performance AS (
    SELECT
        DATE_TRUNC('month', o.order_time)::DATE AS bulan,
        COUNT(DISTINCT o.order_id) AS total_pesanan,
        SUM(oi.quantity * oi.price) AS nilai_transaksi
    FROM food_delivery.orders AS o
    JOIN food_delivery.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status IN ('Delivered', 'Late')
    GROUP BY DATE_TRUNC('month', o.order_time)::DATE
),
monthly_comparison AS (
    SELECT
        bulan,
        total_pesanan,
        nilai_transaksi,
        LAG(nilai_transaksi) OVER (
            ORDER BY bulan
        ) AS nilai_transaksi_bulan_sebelumnya
    FROM monthly_performance
)
SELECT
    TO_CHAR(bulan, 'FMMonth YYYY') AS bulan,
    total_pesanan,
    ROUND(nilai_transaksi::NUMERIC, 2)
        AS nilai_transaksi_makanan,
    ROUND(
        nilai_transaksi_bulan_sebelumnya::NUMERIC,
        2
    ) AS nilai_transaksi_bulan_sebelumnya,
    ROUND(
        (
            nilai_transaksi - nilai_transaksi_bulan_sebelumnya
        ) / NULLIF(nilai_transaksi_bulan_sebelumnya, 0)
        * 100,
        2
    ) AS perubahan_nilai_transaksi_persen
FROM monthly_comparison AS mc
ORDER BY mc.bulan;

/* Business Question 2
Restoran mana yang memiliki nilai transaksi makanan tertinggi, 
dan bagaimana perbandingannya dengan jumlah pesanan 
serta rata-rata nilai per pesanan?
*/

WITH order_totals AS (
    SELECT
        o.order_id,
        o.restaurant_id,
        SUM(oi.quantity * oi.price) AS nilai_pesanan
    FROM food_delivery.orders AS o
    JOIN food_delivery.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status IN ('Delivered', 'Late')
    GROUP BY
        o.order_id,
        o.restaurant_id
)
SELECT
    restaurant_id,
    COUNT(*) AS total_pesanan,
    ROUND(
        SUM(nilai_pesanan)::NUMERIC,
        2
    ) AS total_nilai_transaksi,
    ROUND(
        AVG(nilai_pesanan)::NUMERIC,
        2
    ) AS rata_rata_nilai_pesanan
FROM order_totals
GROUP BY restaurant_id
ORDER BY total_nilai_transaksi DESC
LIMIT 5;

/* Business Question 3 
Kota mana yang memiliki jumlah pesanan dan nilai transaksi makanan tertinggi 
berdasarkan lokasi restoran?
*/

SELECT
    r.city AS kota_restoran,
    COUNT(DISTINCT o.order_id) AS total_pesanan,
    ROUND(
        SUM(oi.quantity * oi.price)::NUMERIC,
        2
    ) AS total_nilai_transaksi
FROM food_delivery.orders AS o
JOIN food_delivery.order_items AS oi
    ON o.order_id = oi.order_id
JOIN food_delivery.restaurants AS r
    ON o.restaurant_id = r.restaurant_id
WHERE o.status IN ('Delivered', 'Late')
GROUP BY r.city
ORDER BY total_nilai_transaksi DESC;

/* Business Question 4  
Seberapa besar proporsi pelanggan berulang dan kontribusinya 
terhadap total pesanan yang berstatus Delivered dan Late?
*/

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS total_pesanan
    FROM food_delivery.orders
    WHERE status IN ('Delivered', 'Late')
    GROUP BY customer_id
),
customer_segments AS (
    SELECT
        customer_id,
        total_pesanan,
        CASE
            WHEN total_pesanan = 1
                THEN 'Satu pesanan'
            ELSE 'Pelanggan berulang'
        END AS segmen_pelanggan
    FROM customer_orders
)
SELECT
    segmen_pelanggan,
    COUNT(*) AS total_pelanggan,
    SUM(total_pesanan) AS total_pesanan,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (),
        2
    ) AS persentase_pelanggan,
    ROUND(
        SUM(total_pesanan) * 100.0
        / SUM(SUM(total_pesanan)) OVER (),
        2
    ) AS persentase_pesanan
FROM customer_segments
GROUP BY segmen_pelanggan
ORDER BY total_pelanggan DESC;

/* Business Question 5 
Jenis masakan (cuisine) mana yang memiliki nilai transaksi makanan tertinggi, 
dan bagaimana perbandingannya dengan jumlah restoran serta jumlah pesanan?
*/

WITH order_totals AS (
    SELECT
        o.order_id,
        o.restaurant_id,
        SUM(oi.quantity * oi.price) AS nilai_pesanan
    FROM food_delivery.orders AS o
    JOIN food_delivery.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status IN ('Delivered', 'Late')
    GROUP BY
        o.order_id,
        o.restaurant_id
),
cuisine_performance AS (
    SELECT
        r.cuisine,
        COUNT(DISTINCT r.restaurant_id) AS total_restoran,
        COUNT(ot.order_id) AS total_pesanan,
        COALESCE(
            SUM(ot.nilai_pesanan),
            0
        ) AS total_nilai_transaksi
    FROM food_delivery.restaurants AS r
    LEFT JOIN order_totals AS ot
        ON r.restaurant_id = ot.restaurant_id
    GROUP BY r.cuisine
)
SELECT
    cuisine,
    total_restoran,
    total_pesanan,
    ROUND(
        total_nilai_transaksi::NUMERIC,
        2
    ) AS total_nilai_transaksi,
    ROUND(
        total_nilai_transaksi * 100.0
        / NULLIF(SUM(total_nilai_transaksi) OVER (), 0),
        2
    ) AS kontribusi_transaksi_persen
FROM cuisine_performance
ORDER BY total_nilai_transaksi DESC;


/* Business Question 6 
Bagaimana distribusi status pesanan, dan kota mana yang memiliki 
tingkat pembatalan pesanan tertinggi dan terendah berdasarkan lokasi restoran?
*/

-- Distribusi status pesanan
SELECT
    status,
    COUNT(*) AS total_pesanan,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (),
        2
    ) AS persentase_pesanan
FROM food_delivery.orders
GROUP BY status
ORDER BY total_pesanan DESC;

-- Tingkat pembatalan per kota restoran
SELECT
    r.city AS kota_restoran,
    COUNT(*) AS total_pesanan,
    COUNT(*) FILTER (
        WHERE o.status = 'Cancelled'
    ) AS total_pesanan_dibatalkan,
    ROUND(
        COUNT(*) FILTER (
            WHERE o.status = 'Cancelled'
        ) * 100.0 / COUNT(*),
        2
    ) AS tingkat_pembatalan_persen
FROM food_delivery.orders AS o
JOIN food_delivery.restaurants AS r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY tingkat_pembatalan_persen DESC;

/* Business Question 7 
Apakah restoran dengan rating tertinggi juga memiliki jumlah 
pesanan dan nilai transaksi makanan tertinggi?
*/

WITH order_totals AS (
    SELECT
        o.order_id,
        o.restaurant_id,
        SUM(oi.quantity * oi.price) AS nilai_pesanan
    FROM food_delivery.orders AS o
    JOIN food_delivery.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status IN ('Delivered', 'Late')
    GROUP BY
        o.order_id,
        o.restaurant_id
),
restaurant_performance AS (
    SELECT
        r.restaurant_id,
        r.rating,
        COUNT(ot.order_id) AS total_pesanan,
        ROUND(
            COALESCE(SUM(ot.nilai_pesanan), 0)::NUMERIC,
            2
        ) AS total_nilai_transaksi
    FROM food_delivery.restaurants AS r
    LEFT JOIN order_totals AS ot
        ON r.restaurant_id = ot.restaurant_id
    GROUP BY
        r.restaurant_id,
        r.rating
),
restaurant_ranking AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY rating DESC NULLS LAST
        ) AS peringkat_rating,
        RANK() OVER (
            ORDER BY total_pesanan DESC
        ) AS peringkat_pesanan,
        RANK() OVER (
            ORDER BY total_nilai_transaksi DESC
        ) AS peringkat_transaksi
    FROM restaurant_performance
)
SELECT
    restaurant_id,
    rating,
    total_pesanan,
    total_nilai_transaksi,
    peringkat_rating,
    peringkat_pesanan,
    peringkat_transaksi
FROM restaurant_ranking
WHERE
    peringkat_rating = 1
    OR peringkat_pesanan = 1
    OR peringkat_transaksi = 1
ORDER BY
    peringkat_rating,
    peringkat_pesanan,
    peringkat_transaksi,
    restaurant_id;


/* Business Question 8
Restoran mana yang memiliki proporsi pesanan berstatus Late tertinggi 
di antara pesanan berstatus Delivered dan Late, dengan minimal 10 pesanan 
dalam gabungan kedua status tersebut?
*/

SELECT
    restaurant_id,
    COUNT(*) AS total_pesanan,
    COUNT(*) FILTER (
        WHERE status = 'Late'
    ) AS total_pesanan_late,
    ROUND(
        COUNT(*) FILTER (
            WHERE status = 'Late'
        ) * 100.0 / COUNT(*),
        2
    ) AS persentase_late
FROM food_delivery.orders
WHERE status IN ('Delivered', 'Late')
GROUP BY restaurant_id
HAVING COUNT(*) >= 10
ORDER BY persentase_late DESC, total_pesanan DESC
LIMIT 5;

