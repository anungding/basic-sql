SELECT * FROM salaries;
-- 1. Apakah ada data yang NULL?
SELECT * FROM salaries 
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

-- 2. Melihat ada job title apa saja
SELECT distinct job_title FROM salaries;

-- 3. Job title apa saja yang berkaitan dengan data analis?
SELECT distinct job_title FROM salaries 
WHERE job_title LIKE "%DATA ANALYST%";

-- 4. Berapa rata-rata gaji data analyst?
SELECT AVG(salary) AS avg_yearly_salary  
FROM salaries 
WHERE job_title LIKE "%DATA ANALYST%";


SELECT (AVG(salary_in_usd) / 12) AS avg_monthly_salary 
FROM salaries 
WHERE job_title LIKE '%DATA ANALYST%';


SELECT ((AVG(salary_in_usd) / 12) * 16000) AS avg_monthly_salary_idr 
FROM salaries 
WHERE job_title LIKE '%DATA ANALYST%';


SELECT experience_level, (AVG(salary_in_usd) / 12) * 16000 AS avg_monthly_salary_idr
FROM salaries 
WHERE job_title LIKE '%DATA ANALYST%'
GROUP BY experience_level;

--

SELECT experience_level, employment_type, ((AVG(salary_in_usd) * 16000) / 12 ) AS avg_monthly_salary
FROM salaries 
WHERE job_title LIKE '%DATA ANALYST%'
group by experience_level, employment_type
order by experience_level, employment_type;

--
SELECT company_location, experience_level, employment_type, ((AVG(salary_in_usd) * 16000) / 12 ) AS avg_monthly_salary
FROM salaries 
WHERE job_title LIKE '%DATA ANALYST%'
group by company_location, experience_level, employment_type
order by  avg_monthly_salary DESC;



