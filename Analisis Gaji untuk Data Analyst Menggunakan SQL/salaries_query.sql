-- 1. Mengecek apakah ada data yang NULL di kolom tertentu
-- Menggunakan OR untuk mengecek setiap kolom dalam tabel `salaries` yang memiliki nilai NULL.
SELECT * 
FROM salaries
WHERE work_year IS NULL
   OR experience_level IS NULL
   OR employment_type IS NULL
   OR job_title IS NULL
   OR salary IS NULL
   OR salary_currency IS NULL
   OR salary_in_usd IS NULL
   OR employee_residence IS NULL
   OR remote_ratio IS NULL
   OR company_location IS NULL
   OR company_size IS NULL;

-- 2. Melihat semua jenis job title yang ada
-- Menggunakan DISTINCT untuk mendapatkan daftar unik `job_title`.
SELECT DISTINCT job_title 
FROM salaries;

-- 3. Melihat job title yang berkaitan dengan "Data Analyst"
-- Menggunakan LIKE untuk mencari job title yang mengandung "DATA ANALYST".
SELECT DISTINCT job_title 
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%';

-- 4. Berapa rata-rata gaji tahunan untuk Data Analyst?
-- Menggunakan fungsi AVG untuk menghitung rata-rata gaji tahunan.
SELECT AVG(salary) AS avg_yearly_salary  
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%';

-- Rata-rata gaji bulanan dalam USD untuk Data Analyst
-- Membagi rata-rata gaji tahunan dengan 12 untuk mendapatkan gaji bulanan.
SELECT (AVG(salary_in_usd) / 12) AS avg_monthly_salary_usd
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%';

-- Rata-rata gaji bulanan dalam IDR (kurs 1 USD = 16.000 IDR)
-- Mengalikan rata-rata gaji bulanan dalam USD dengan 16.000 untuk konversi ke IDR.
SELECT ((AVG(salary_in_usd) / 12) * 16000) AS avg_monthly_salary_idr
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%';

-- Rata-rata gaji bulanan dalam IDR berdasarkan tingkat pengalaman
-- Mengelompokkan rata-rata gaji bulanan berdasarkan `experience_level`.
SELECT 
    experience_level, 
    ((AVG(salary_in_usd) / 12) * 16000) AS avg_monthly_salary_idr
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%'
GROUP BY experience_level;

-- Rata-rata gaji bulanan dalam IDR berdasarkan tingkat pengalaman dan tipe pekerjaan
-- Menambahkan kolom `employment_type` untuk melihat gaji bulanan berdasarkan tingkat pengalaman dan tipe pekerjaan.
SELECT 
    experience_level, 
    employment_type, 
    ((AVG(salary_in_usd) / 12) * 16000) AS avg_monthly_salary_idr
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%'
GROUP BY experience_level, employment_type
ORDER BY experience_level, employment_type;

-- Rata-rata gaji bulanan dalam IDR berdasarkan lokasi perusahaan, tingkat pengalaman, dan tipe pekerjaan
-- Mengelompokkan berdasarkan lokasi perusahaan, tingkat pengalaman, dan tipe pekerjaan.
SELECT 
    company_location, 
    experience_level, 
    employment_type, 
    ((AVG(salary_in_usd) / 12) * 16000) AS avg_monthly_salary_idr
FROM salaries
WHERE job_title LIKE '%DATA ANALYST%'
GROUP BY 
    company_location, 
    experience_level, 
    employment_type
ORDER BY avg_monthly_salary_idr DESC;

-- Rata-rata gaji bulanan dalam IDR untuk tingkat pengalaman `EX` per tahun kerja
SELECT work_year, 
       (AVG(salary_in_usd / 12) * 16000) AS avg_monthly_salary_ex
FROM salaries
WHERE experience_level = 'EX' 
      AND job_title LIKE '%DATA ANALYST%'
GROUP BY work_year;

-- Rata-rata gaji bulanan dalam IDR untuk tingkat pengalaman `MI` per tahun kerja
SELECT work_year, 
       (AVG(salary_in_usd / 12) * 16000) AS avg_monthly_salary_mi
FROM salaries
WHERE experience_level = 'MI' 
      AND job_title LIKE '%DATA ANALYST%'
GROUP BY work_year;

-- Membandingkan gaji antara `EX` dan `MI` dengan menggunakan CTE (Common Table Expressions)
WITH ds_1 AS (
	SELECT 
		work_year, 
		(AVG(salary_in_usd / 12) * 16000) AS avg_monthly_salary_ex
	FROM salaries
	WHERE 
		experience_level = 'EX' 
		AND employment_type = 'FT'
		AND job_title LIKE '%DATA ANALYST%'
	GROUP BY work_year
), ds_2 AS (
	SELECT 
		work_year, 
		(AVG(salary_in_usd / 12) * 16000) AS avg_monthly_salary_mi
	FROM salaries
	WHERE 
		experience_level = 'MI' 
		AND employment_type = 'FT'
		AND job_title LIKE '%DATA ANALYST%'
	GROUP BY work_year
), ds_3 AS (
	SELECT DISTINCT work_year 
	FROM salaries
)
SELECT 
	ds_3.work_year, 
	ds_1.avg_monthly_salary_ex, 
	ds_2.avg_monthly_salary_mi,
	(ds_1.avg_monthly_salary_ex - ds_2.avg_monthly_salary_mi) AS difference
FROM ds_3 
LEFT JOIN ds_1 ON ds_3.work_year = ds_1.work_year
LEFT JOIN ds_2 ON ds_3.work_year = ds_2.work_year;
