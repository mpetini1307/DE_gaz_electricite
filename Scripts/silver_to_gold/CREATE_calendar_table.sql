CREATE OR ALTER PROCEDURE sp_create_calender_dim_table
	@start_date date,
	@end_date date
as
BEGIN
	with recursive_cte as (
		Select @start_date as cal_date

		union all

		Select dateadd(dd,1,cal_date) as cal_date
		from recursive_cte
		where cal_date < @end_date
	)
	SELECT
	CONVERT(INT, REPLACE(CAST(cal_date AS CHAR(10)),'-', '')) AS dateId, 
	cal_date,
	datepart(year,cal_date) as cal_year,
	datepart(dayofyear,cal_date) as cal_year_day,
	datepart(quarter,cal_date) as cal_quarter, 
	datepart(month,cal_date) as cal_month,
	datename(month,cal_date) as cal_month_name,
	datepart(day,cal_date) as cal_month_day,
	datepart(week,cal_date) as cal_week,
	datepart(weekday,cal_date) as cal_week_day,
	datename(weekday,cal_date) as cal_day_name
	into gold.Dim_Date
	from recursive_cte 
	option (maxrecursion 0)
END;

-- Execute Sp : sp_create_calender_dim_table
DROP TABLE IF EXISTS gold.Dim_Date
EXEC sp_create_calender_dim_table @start_date = '2014-01-01', @end_date = '2026-12-31' 

-- Check the cal_dim_new table

