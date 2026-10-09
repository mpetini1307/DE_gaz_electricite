DROP TABLE IF EXISTS silver.population_by_age
DROP TABLE IF EXISTS silver.total_population

SELECT
	CAST(TIME_PERIOD AS INT) as [Year],
	CASE 
		WHEN indic_de = 'Proportion of population aged 0-14 years' THEN '0-14'
		WHEN indic_de = 'Proportion of population aged 15-24 years' THEN '15-24'
		WHEN indic_de = 'Proportion of population aged 25-49 years' THEN '25-49'
		WHEN indic_de = 'Proportion of population aged 50-64 years' THEN '50-64'
		WHEN indic_de = 'Proportion of population aged 65-79 years' THEN '65-79'
		WHEN indic_de = 'Proportion of population aged 80 years and more' THEN '80+'
	END as 'age',
	geo as 'Country',
	CAST(OBS_VALUE  AS FLOAT) as 'value(%)'
INTO silver.population_by_age
FROM bronze.pop_by_aged


SELECT 
	CAST(TIME_PERIOD AS INT) as [Year],
	geo as 'Country',
	CAST(OBS_VALUE  AS FLOAT) as [count]
INTO silver.total_population
FROM bronze.population_totale
WHERE indic_de = 'Population on 1 January - total'