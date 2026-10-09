DROP TABLE IF EXISTS silver.gaz_storage_capacity
SELECT 
	code,
	CAST(gasDayStart AS DATE) as [Date],
	CAST(updatedAt AS DATETIME) as updatedAt,
	ROUND(CAST(workingGasVolume AS FLOAT),2) as 'technicalCapacity[TWh]',
	LAG(ROUND(CAST(workingGasVolume AS FLOAT),2)) OVER (ORDER BY gasDayStart) as 'Capacity_day_before'
INTO silver.gaz_storage_capacity
FROM bronze.gaz_storage_capacity
