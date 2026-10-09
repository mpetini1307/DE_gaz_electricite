DROP TABLE IF EXISTS silver.elec_load;
SELECT DISTINCT
	AreaMapCode,
	ROUND(AVG(CAST([TotalLoad MW] AS FLOAT)) OVER(PARTITION BY DATETRUNC(hour,CAST([DateTime(UTC)] AS DATETIME))),2) AS 'Load(MWh)',
	DATETRUNC(hour,CAST([DateTime(UTC)] AS DATETIME)) AS [DateTime(UTC)]
INTO silver.elec_load
FROM bronze.total_load
ORDER BY DATETRUNC(hour,CAST([DateTime(UTC)] AS DATETIME)) ASC

