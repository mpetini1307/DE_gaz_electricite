DROP TABLE silver.gaz_interconnections

SELECT DISTINCT
	pointKey,
	directionKey,
	CAST(tpTsoValidFrom AS DATE) as 'ValidFrom',
	CAST(tpTsoValidTo AS DATE) as 'ValidTo',
	tSOCountry as import_country,
	adjacentCountry as export_country,
	CASE
		WHEN pointType IN ('Cross-Border Transmission IP between EU and ExtEU',
							'Cross-Border Transmission IP between EU and Non-EU (import)',
							'Cross-Border Transmission IP within EU',
							'Transmission Point') THEN 'Transmission'
		WHEN pointType IN ('Distribution Point', 'Aggregated Point - Final Consumers') THEN 'Consumption'
		WHEN pointType = 'Storage point' THEN 'Storage'
		ELSE pointType
	END pointType
INTO silver.gaz_interconnections
FROM bronze.gaz_interconnections


UPDATE silver.gaz_interconnections
SET export_country = 'LNG'
WHERE pointType = 'LNG Entry Point'

DELETE FROM silver.gaz_interconnections
WHERE pointType = 'Trading Point'

DELETE FROM silver.gaz_interconnections
WHERE pointType = 'Transmission' AND export_country = 'BE'
