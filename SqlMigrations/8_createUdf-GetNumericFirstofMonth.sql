CREATE FUNCTION Holidays.UDF_getNumericFirstOfMonth()
RETURNS INT 
AS 
BEGIN
DECLARE @NumericFirst INT 
SELECT @NumericFirst=
	CAST([DayofWeek]-DATEPART(WEEKDAY,Holidays.UDF_getFirstofMonth()) AS INT)
FROM 
	holidays.calcualtedHolidays
RETURN @NumericFirst
END

