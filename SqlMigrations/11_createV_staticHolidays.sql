CREATE VIEW holidays.V_staticHolidays
AS
SELECT
	[day],
	[month],
	DATEPART(YEAR,GETDATE()) AS [year],
	HolidayName
FROM holidays.holidays