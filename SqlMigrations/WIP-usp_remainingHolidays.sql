--CREATE PROCEDURE holidays.usp_remainingHolidays
--AS
SELECT 
	CASE
		WHEN DATEPART(
	dy,
	CONVERT(date,
		CAST([year] AS VARCHAR(10))
			+'-'+
		RIGHT('00' + CAST([Month] AS varchar(2)) , 2)
	+'-'+
		RIGHT('00' + CAST([day] AS varchar(2)) , 2)-- AS date
		)
			)- DATEPART(dy,GETDATE())  = 0 THEN '!Today!'
		ELSE DATEPART(
	dy,
	CONVERT(date,
		CAST([year] AS VARCHAR(10))
			+'-'+
		RIGHT('00' + CAST([Month] AS varchar(2)) , 2)
	+'-'+
		RIGHT('00' + CAST([day] AS varchar(2)) , 2)
		)
			)- DATEPART(dy,GETDATE()) AS VARCHAR(45))
		END
		AS 'Days until'
	, Holiday 
FROM 
	holidays.v_calaculatedHolidays
WHERE DATEPART(dy, CAST(CAST([day] AS VARCHAR(10))+'-'+CAST([month]AS VARCHAR(10))+'-'+CAST([year] AS VARCHAR(10)) AS DATE)) - DATEPART(dy,GETDATE())>-1--Filterout Past holidays
UNION
SELECT 
	CASE
		WHEN DATEPART(
	dy,
	CONVERT(date,
		CAST([year] AS VARCHAR(10))
			+'-'+
		RIGHT('00' + CAST([Month] AS varchar(2)) , 2)
	+'-'+
		RIGHT('00' + CAST([day] AS varchar(2)) , 2)-- AS date
		)
			),
 DATEPART(dy,GETDATE())- DATEPART(dy,GETDATE())  = 0 THEN '!Today!'
		ELSEDATEPART(
	dy,
	CONVERT(date,
		CAST([year] AS VARCHAR(10))
			+'-'+
		RIGHT('00' + CAST([Month] AS varchar(2)) , 2)
	+'-'+
		RIGHT('00' + CAST([day] AS varchar(2)) , 2)-- AS date
		)
			),
 DATEPART(dy,GETDATE())- DATEPART(dy,GETDATE()) AS VARCHAR(45))
		END
		AS 'Days until'
	, Holidayname 
FROM 
	holidays.V_staticHolidays
WHERE DATEPART(dy, CAST(CAST([day] AS VARCHAR(10))+'-'+CAST([month]AS VARCHAR(10))+'-'+CAST([year] AS VARCHAR(10)) AS DATE)) - DATEPART(dy,GETDATE())>-1--Filterout Past holidays

ORDER BY [Days until] ASC;