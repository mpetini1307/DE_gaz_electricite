DROP TABLE IF EXISTS silver.elec_installed_capacity;

SELECT 
	CAST([Year] AS INT) AS [Year],
	AreaMapCode,
	ProductionType,
	CAST([AggregatedInstalledCapacity MW ] AS FLOAT) as 'InstalledCapacity(MW)'
INTO silver.elec_installed_capacity
FROM bronze.installed_capacity

SELECT * FROM silver.elec_installed_capacity

