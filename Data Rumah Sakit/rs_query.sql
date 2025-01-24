-- 1. Menampilkan pasien dengan data yang NULL atau string kosong
-- Query ini akan memeriksa jika ada data NULL atau string kosong pada kolom-kolom penting
SELECT
    no,
    no_register,
    nama_pasien,
    ruangan,
    penyakit,
    dokter_penanggung_jawab,
    tanggal_masuk,
    tanggal_keluar,
    status
FROM patients
WHERE
    no IS NULL OR no_register IS NULL OR nama_pasien IS NULL OR
    ruangan IS NULL OR penyakit IS NULL OR dokter_penanggung_jawab IS NULL OR
    tanggal_masuk IS NULL OR tanggal_keluar IS NULL OR status IS NULL OR
    TRIM(no) = '' OR TRIM(no_register) = '' OR TRIM(nama_pasien) = '' OR
    TRIM(ruangan) = '' OR TRIM(penyakit) = '' OR TRIM(dokter_penanggung_jawab) = '' OR
    TRIM(tanggal_masuk) = '' OR TRIM(tanggal_keluar) = '' OR TRIM(status) = '';

-- 2. Menghitung total pasien dirawat
SELECT COUNT(*) FROM patients;

-- 3. Jumlah pasien berdasarkan penyakit
SELECT penyakit, COUNT(penyakit) 
FROM patients GROUP BY penyakit
ORDER BY penyakit DESC;

-- 4. Perbandingan pasien masuk dengan keluar berdasarkan bulan
-- Query ini membagi tanggal_masuk dan tanggal_keluar berdasarkan bulan untuk analisis tren pasien masuk dan keluar

-- Pasien masuk per bulan
SELECT 
	CAST(SUBSTRING_INDEX(tanggal_masuk, '/', 1) AS UNSIGNED) AS bulan_masuk, 
	COUNT(*) AS jumlah_pasien
FROM patients
WHERE tanggal_masuk <> ''
  AND tanggal_masuk IS NOT NULL
GROUP BY bulan_masuk
ORDER BY bulan_masuk;

-- Pasien keluar per bulan
SELECT 
    CAST(SUBSTRING_INDEX(tanggal_keluar, '/', 1) AS UNSIGNED) AS bulan_keluar, 
    COUNT(*) AS jumlah_pasien
FROM patients
WHERE tanggal_keluar <> ''
  AND tanggal_keluar IS NOT NULL
GROUP BY bulan_keluar
ORDER BY bulan_keluar;

-- Gabungkan pasien masuk dan keluar dalam satu tabel per bulan
WITH masuk AS (
    SELECT 
        CAST(SUBSTRING_INDEX(tanggal_masuk, '/', 1) AS UNSIGNED) AS bulan,
        COUNT(*) AS jumlah_masuk
    FROM patients
    WHERE tanggal_masuk <> '' 
      AND tanggal_masuk IS NOT NULL
    GROUP BY bulan
),
keluar AS (
    SELECT 
        CAST(SUBSTRING_INDEX(tanggal_keluar, '/', 1) AS UNSIGNED) AS bulan,
        COUNT(*) AS jumlah_keluar
    FROM patients
    WHERE tanggal_keluar <> '' 
      AND tanggal_keluar IS NOT NULL
    GROUP BY bulan
)
SELECT 
    COALESCE(masuk.bulan, keluar.bulan) AS bulan,  
    COALESCE(masuk.jumlah_masuk, 0) AS jumlah_masuk,  
    COALESCE(keluar.jumlah_keluar, 0) AS jumlah_keluar
FROM masuk
LEFT JOIN keluar ON masuk.bulan = keluar.bulan 
ORDER BY bulan;

-- 5. Jumlah pasien per ruangan R, A, P
SELECT LEFT(ruangan, 1) AS nama_ruangan, 
       COUNT(*) AS jumlah_pasien
FROM patients
GROUP BY LEFT(ruangan, 1)
ORDER BY jumlah_pasien DESC;


-- 6. Jumlah pasien per status
SELECT status, COUNT(status) AS jumlah_pasien 
FROM patients
GROUP BY status
ORDER BY status DESC;


-- 7. Jumlah dokter dengan pasien terbanyak
SELECT dokter_penanggung_jawab, COUNT(dokter_penanggung_jawab) AS jumlah 
FROM patients
GROUP BY dokter_penanggung_jawab
ORDER BY jumlah DESC;
