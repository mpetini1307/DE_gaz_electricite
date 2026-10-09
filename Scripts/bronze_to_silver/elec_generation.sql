DROP TABLE IF EXISTS silver.elec_generation;

SELECT
	CAST([DateTime(UTC)] AS DATETIME) as [DateTime],
	AreaMapCode,
	ProductionType,
	CAST([ActualGenerationOutput MW ] AS FLOAT) as 'Generation(MWh)',
	CAST([ActualConsumption MW ] AS FLOAT) as 'Consumption(MWh)'
INTO silver.elec_generation
FROM bronze.generation
ORDER BY CAST([DateTime(UTC)] AS DATETIME) ASC