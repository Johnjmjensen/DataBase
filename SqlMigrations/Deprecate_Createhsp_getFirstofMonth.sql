
CREATE FUNCTION Holidays.UDF_getFirstofMonth()
RETURNS DATE 
AS 
BEGIN
DECLARE @FirstFull DATE
SELECT @FirstFull =
	CAST
		(
		firstOfMonth
		+'-1-'+
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