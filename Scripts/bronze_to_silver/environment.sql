DROP TABLE IF EXISTS silver.emission_CO2
DROP TABLE IF EXISTS silver.degree_days

SELECT
	TIME_PERIOD as [Year],
	geo as 'Country',
	CAST(OBS_VALUE AS FLOAT) as [value(MtCO₂eq)]
INTO silver.emission_CO2
FROM bronze.emission_CO2

SELECT 
	TIME_PERIOD as [Year],
	geo as 'Country',
	CASE 
		WHEN indic_nrg  ='Cooling degree days' THEN 'Cooling'
		WHEN indic_nrg  ='Heating degree days' THEN 'Heating'
	END as 'degreeDayType',
	CAST(OBS_VALUE AS FLOAT) as [value(degree days)]
INTO silver.degree_days
FROM bronze.env_degres_jours
