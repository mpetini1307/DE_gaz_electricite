DROP TABLE IF EXISTS silver.elec_flow;

WITH to_write AS (
SELECT DISTINCT
	OutAreaMapCode,
	InAreaMapCode,
    ROUND(AVG(CAST([Flow MW] AS FLOAT)) OVER(PARTITION BY DATETRUNC(hour,CAST([DateTime(UTC)] AS DATETIME))),2) AS 'Flow(MWh)',
    DATETRUNC(hour,CAST([DateTime(UTC)] AS DATETIME)) AS [DateTime(UTC)]
FROM bronze.flow
WHERE ( OutAreaMapCode IN (SELECT DISTINCT code FROM bronze.country_info) )
	AND ( InAreaMapCode IN (SELECT DISTINCT code FROM bronze.country_info) )
	AND ResolutionCode = 'PT15M'

UNION ALL 

SELECT 
	OutAreaMapCode,
	InAreaMapCode,
    CAST([Flow MW] AS FLOAT) AS 'Flow(MWh)',
    CAST([DateTime(UTC)] AS DATETIME) AS [DateTime(UTC)]
FROM bronze.flow
WHERE ( OutAreaMapCode IN (SELECT DISTINCT code FROM bronze.country_info) )
	AND ( InAreaMapCode IN (SELECT DISTINCT code FROM bronze.country_info) )
	AND ResolutionCode = 'PT60M'
)
SELECT 
	*
INTO silver.elec_flow
FROM to_write