-- Menampilkan semua data dari tabel 'pegadaian_transactions'
SELECT * FROM pegadaian_transactions;

-- ===========================
-- DASHBOARD
-- ===========================

-- Mengecek data yang memiliki nilai NULL pada kolom-kolom penting
SELECT * 
FROM pegadaian_transactions 
WHERE id IS NULL
   OR channel IS NULL
   OR sub_branch IS NULL
   OR branch IS NULL
   OR area IS NULL
   OR region IS NULL
   OR tgl_transaksi IS NULL
   OR product_code IS NULL
   OR product IS NULL
   OR jenis_product IS NULL
   OR jumlah_transaksi IS NULL
   OR total_transaksi IS NULL;

-- Menghitung total jumlah transaksi
SELECT COUNT(id) AS total_transaction 
FROM pegadaian_transactions;

-- Menghitung total jumlah region yang unik
SELECT COUNT(DISTINCT region) AS total_region  
FROM pegadaian_transactions;

-- Menghitung total jumlah produk yang unik
SELECT COUNT(DISTINCT product) AS total_product 
FROM pegadaian_transactions;

-- Menghitung total jenis produk yang unik
SELECT COUNT(DISTINCT jenis_product) AS total_jenis_product 
FROM pegadaian_transactions;

-- Menghitung total area yang unik
SELECT COUNT(DISTINCT area) AS total_area 
FROM pegadaian_transactions;

-- Menghitung total cabang yang unik
SELECT COUNT(DISTINCT branch) AS total_branch 
FROM pegadaian_transactions;

-- Menghitung total sub-cabang yang unik
SELECT COUNT(DISTINCT sub_branch) AS total_sub_branch 
FROM pegadaian_transactions;

-- ===========================
-- CHANNEL
-- ===========================

-- Menampilkan total transaksi berdasarkan channel, diurutkan dari total transaksi terbesar
SELECT channel, SUM(total_transaksi) AS total_transaksi
FROM pegadaian_transactions
GROUP BY channel
ORDER BY total_transaksi DESC;

-- ===========================
-- JENIS TRANSAKSI
-- ===========================

-- Menghitung jumlah transaksi berdasarkan jenis transaksi, diurutkan dari jumlah terbesar
SELECT jenis_transaksi, COUNT(jenis_transaksi) AS jumlah_transaksi
FROM pegadaian_transactions
GROUP BY jenis_transaksi
ORDER BY jumlah_transaksi DESC;

-- Menampilkan total transaksi berdasarkan jenis transaksi, diurutkan dari total transaksi terbesar
SELECT jenis_transaksi, SUM(total_transaksi) AS total_transaksi
FROM pegadaian_transactions
GROUP BY jenis_transaksi
ORDER BY total_transaksi DESC;

-- ===========================
-- JENIS PRODUK
-- ===========================

-- Menghitung jumlah produk berdasarkan jenis produk, diurutkan dari jumlah terbesar
SELECT product, COUNT(product) AS jumlah_product
FROM pegadaian_transactions
GROUP BY product
ORDER BY jumlah_product DESC;

-- Menampilkan total transaksi berdasarkan produk, diurutkan dari total transaksi terbesar
SELECT product, SUM(total_transaksi) AS total_transaction
FROM pegadaian_transactions
GROUP BY product
ORDER BY total_transaction DESC;

-- ===========================
-- REGION
-- ===========================

-- Menghitung jumlah transaksi berdasarkan region, diurutkan dari jumlah terbesar
SELECT region, COUNT(region) AS jumlah_region
FROM pegadaian_transactions
GROUP BY region
ORDER BY jumlah_region DESC;

-- Menampilkan total transaksi berdasarkan region, diurutkan dari total transaksi terbesar
SELECT region, SUM(total_transaksi) AS total_transaction
FROM pegadaian_transactions
GROUP BY region
ORDER BY total_transaction DESC;
