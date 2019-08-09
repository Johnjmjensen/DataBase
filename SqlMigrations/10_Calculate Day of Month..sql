CREATE VIEW holidays.v_calaculatedHolidays
AS
SELECT 
	CAST(DATEPART
		(
		Day,
		DATEADD
			(
			WEEKDAY,
			Holidays.UDF_getNumericFirstOfMonth(),
			DATEADD
				(
				Week,
				WeekOfMonth,
				Holidays.UDF_getFirstofMonth()
				)
			)
		)AS INT) AS day,
	CAST(FirstOfMonth AS INT) AS  month,
	CAST(DATEPART(YEAR,GETDATE())AS INT) AS year,
	Name AS holiday
FROM 
	holidays.calcualtedHolidays;