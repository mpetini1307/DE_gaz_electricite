DROP TABLE IF EXISTS silver.country

SELECT
	code as countryCode,
	pays as countryName,
	CAST(latitude AS FLOAT) as latitude,
	CAST(longitude AS FLOAT) as longitude
INTO silver.country
FROM bronze.country_info
	WHERE code != 'SH'