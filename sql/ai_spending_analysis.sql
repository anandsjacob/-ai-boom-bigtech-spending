CREATE DATABASE IF NOT EXISTS bigtech;
USE bigtech;

CREATE TABLE big_tech (
  company       VARCHAR(20),
  fiscal_year   VARCHAR(8),
  fy_end        DATE,
  analysis_year INT,
  revenue       INT,
  op_income     INT,
  net_income    INT,
  rnd           INT,
  capex         INT
);
LOAD DATA LOCAL INFILE 'C:/Users/sheji/big_tech_sql.csv'
INTO TABLE big_tech
FIELDS TERMINATED BY ','
IGNORE 1 LINES;
SELECT company, COUNT(*) AS years FROM big_tech GROUP BY company;
SELECT revenue FROM big_tech
WHERE company = 'NVIDIA' AND analysis_year = 2025;
SELECT COUNT(*) FROM big_tech;

# year revenue growth

SELECT company, analysis_year, revenue,
       LAG(revenue) OVER (PARTITION BY company ORDER BY analysis_year) AS prev_revenue,
       ROUND((revenue / LAG(revenue) OVER (PARTITION BY company ORDER BY analysis_year) - 1) * 100, 1) AS yoy_growth_pct
FROM big_tech
ORDER BY company, analysis_year;
WITH growth AS (
  SELECT company, analysis_year,
         ROUND((revenue / LAG(revenue) OVER (PARTITION BY company ORDER BY analysis_year) - 1) * 100, 1) AS yoy_growth_pct
  FROM big_tech
)
SELECT * FROM growth
WHERE yoy_growth_pct IS NOT NULL
ORDER BY yoy_growth_pct DESC
LIMIT 10;

#building KPI's 

CREATE OR REPLACE VIEW big_tech_kpi AS
SELECT company, fiscal_year, analysis_year, revenue, op_income, net_income, rnd, capex,
  ROUND((revenue / LAG(revenue) OVER (PARTITION BY company ORDER BY analysis_year) - 1) * 100, 1) AS rev_growth_pct,
  ROUND(op_income  / revenue * 100, 1) AS op_margin_pct,
  ROUND(net_income / revenue * 100, 1) AS net_margin_pct,
  ROUND(rnd   / revenue * 100, 1) AS rnd_pct,
  ROUND(capex / revenue * 100, 1) AS capex_pct,
  ROUND(capex / op_income, 2)     AS capex_to_opinc,
  CASE WHEN analysis_year <= 2022 THEN 'Pre-AI (2018-22)' ELSE 'AI boom (2023-25)' END AS period
FROM big_tech;

#before vs after the AI boom

SELECT company, period,
  ROUND(AVG(rev_growth_pct), 1) AS avg_growth,
  ROUND(AVG(op_margin_pct), 1)  AS avg_op_margin,
  ROUND(AVG(rnd_pct), 1)        AS avg_rnd_pct,
  ROUND(AVG(capex_pct), 1)      AS avg_capex_pct
FROM big_tech_kpi
GROUP BY company, period
ORDER BY company, period;

# how much did each metric change?

SELECT company,
  ROUND(AVG(CASE WHEN period LIKE 'AI%'  THEN capex_pct END)
      - AVG(CASE WHEN period LIKE 'Pre%' THEN capex_pct END), 1)     AS capex_pct_change,
  ROUND(AVG(CASE WHEN period LIKE 'AI%'  THEN op_margin_pct END)
      - AVG(CASE WHEN period LIKE 'Pre%' THEN op_margin_pct END), 1) AS op_margin_change,
  ROUND(AVG(CASE WHEN period LIKE 'AI%'  THEN rev_growth_pct END)
      - AVG(CASE WHEN period LIKE 'Pre%' THEN rev_growth_pct END), 1) AS growth_change
FROM big_tech_kpi
GROUP BY company;

# who spent more on capex than they earned?

SELECT company, analysis_year, capex, op_income, capex_to_opinc
FROM big_tech_kpi
WHERE capex > op_income
ORDER BY analysis_year, company;

#the buyers vs the seller

SELECT analysis_year,
  SUM(CASE WHEN company <> 'NVIDIA' THEN capex END)   AS big4_capex,
  SUM(CASE WHEN company =  'NVIDIA' THEN revenue END) AS nvda_revenue,
  ROUND(SUM(CASE WHEN company = 'NVIDIA' THEN revenue END)
      / SUM(CASE WHEN company <> 'NVIDIA' THEN capex END) * 100, 1) AS nvda_pct_of_capex
FROM big_tech
GROUP BY analysis_year
ORDER BY analysis_year;

#yearly ranking by capex intensity

SELECT analysis_year, company, capex_pct,
  RANK() OVER (PARTITION BY analysis_year ORDER BY capex_pct DESC) AS capex_rank
FROM big_tech_kpi
ORDER BY analysis_year, capex_rank;

#who raised capex and still improved margin?

WITH chg AS (
  SELECT company,
    ROUND(AVG(CASE WHEN period LIKE 'AI%'  THEN capex_pct END)
        - AVG(CASE WHEN period LIKE 'Pre%' THEN capex_pct END), 1)     AS capex_pct_change,
    ROUND(AVG(CASE WHEN period LIKE 'AI%'  THEN op_margin_pct END)
        - AVG(CASE WHEN period LIKE 'Pre%' THEN op_margin_pct END), 1) AS op_margin_change
  FROM big_tech_kpi
  GROUP BY company
)
SELECT * FROM chg
WHERE capex_pct_change > 0 AND op_margin_change > 0
ORDER BY op_margin_change DESC;

