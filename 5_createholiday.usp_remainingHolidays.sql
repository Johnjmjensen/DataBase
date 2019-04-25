SET NOEXEC OFF;
SET ANSI_NULL_DFLT_ON ON;
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET QUOTED_IDENTIFIER ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

/*Creation script ;*/

PRINT CONCAT
(
	'/***********************************************/', CAST(0x0D0A AS CHAR(2)),
	'Login:		', ORIGINAL_LOGIN(), CAST(0x0D0A AS CHAR(2)),
	'Server:		', @@SERVERNAME, CAST(0x0D0A AS CHAR(2)),
	'Database:	', DB_NAME(), CAST(0x0D0A AS CHAR(2)),
	'Processed:	', SYSDATETIMEOFFSET(), CAST(0x0D0A AS CHAR(2)),
	'/***********************************************/'
);
GO
CREATE PROCEDURE holidays.usp_remainingHolidays
AS
DECLARE @Nov1 Date =
	(
	SELECT CAST(CAST('11-01-'AS varchar(10))+CAST(DATEPART(YEAR,GETDATE()) AS VARCHAR(10))AS date)  /*WEEK of November 1st*/ 
	)
PRINT @Nov1

DECLARE @Thursday INT=
	(
	SELECT 5-DATEPART(WEEKDAY,@nov1)
	)
DECLARE @thanksgiving INT =
	(
	SELECT DATEPART(Day,DATEADD(WEEKDAY,@thursday,DATEADD(Week,3,@Nov1)))
	)
DECLARE @Holiday TABLE
(
[day] INT
,[month] INT
,[year] INT
,Holiday VARCHAR(100))
INSERT INTO @Holiday ([day],[month],[year],Holiday)
VALUES
	(07,04,DATEPART(YEAR,GETDATE()),'July 4th')
	,(12,25,DATEPART(YEAR,GETDATE()),'Chrismas')
	,(11,08,DATEPART(YEAR,GETDATE()),'DataVarious Brithday')
	,(11,@thanksgiving,DATEPART(YEAR,GETDATE()),'ThanksGiving')
	,(12,31,DATEPART(YEAR,GETDATE()),'New Year''s eve')
SELECT 
	CASE
		WHEN DATEPART(dy, CAST(CAST([day] AS VARCHAR(10))+'-'+CAST([month]AS VARCHAR(10))+'-'+CAST([year] AS VARCHAR(10)) AS DATE)) - DATEPART(dy,GETDATE())  = 0 THEN '!Today!'--visually looks important hacky way of getting it to be first result
		ELSE CAST(DATEPART(dy, CAST(CAST([day] AS VARCHAR(10))+'-'+CAST([month]AS VARCHAR(10))+'-'+CAST([year] AS VARCHAR(10)) AS DATE))- DATEPART(dy,GETDATE()) AS VARCHAR(45))
		END
		AS 'Days until'
	, Holiday  
FROM @Holiday
WHERE DATEPART(dy, CAST(CAST([day] AS VARCHAR(10))+'-'+CAST([month]AS VARCHAR(10))+'-'+CAST([year] AS VARCHAR(10)) AS DATE)) - DATEPART(dy,GETDATE())>-1--Filterout Past holidays
ORDER BY [Days until] ASC;
GO
IF (@@ERROR <> 0 OR @@TRANCOUNT <= 0)
BEGIN
	RAISERROR('SCHEMA CHANGE FAILED!', 18, 0);
	IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
	SET NOEXEC ON;
	RETURN;
END;
GO
--PRINT 'ROLLBACK'; ROLLBACK TRANSACTION;
PRINT 'COMMIT'; COMMIT WORK;
/*

*/