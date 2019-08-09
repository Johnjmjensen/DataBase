CREATE FUNCTION Holidays.UDF_GetFirstofMonth()
RETURNS DATE 
AS 
BEGIN
DECLARE @FirstFull DATE
SELECT @FirstFull =
	CAST
		(
		firstOfMonth
		+
		CAST
			(
			DATEPART
				(
				YEAR,
				GETDATE()
				) 
			AS VARCHAR(10))
		AS date) 
		
FROM 
	holidays.calcualtedHolidays
RETURN @firstFull
END