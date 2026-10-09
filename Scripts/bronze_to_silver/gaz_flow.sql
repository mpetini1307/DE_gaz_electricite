DROP TABLE IF EXISTS silver.gaz_flow
SELECT 
	pointKey,
	directionKey,
	CAST(SWITCHOFFSET(periodFrom, '+00:00') AS DATETIME2) as [DateTime(UTC)],
	CAST(value AS INT)/1000 as 'value[MWh]'
INTO silver.gaz_flow
FROM bronze.gaz_entry
UNION ALL
SELECT 
	pointKey,
	directionKey,
	CAST(SWITCHOFFSET(periodFrom, '+00:00') AS DATETIME2) as [DateTime(UTC)],
	CAST(value AS INT)/1000 as 'value[MWh]'
FROM bronze.gaz_exit

--SELECT * FROM bronze.gaz_entry
--SELECT * FROM bronze.gaz_exit
