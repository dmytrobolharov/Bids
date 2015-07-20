IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_DatetimeToString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_DatetimeToString]
GO

CREATE FUNCTION [dbo].[fnx_DatetimeToString]
(
	@Date DATETIME,
	@PrefLanguage NVARCHAR (50)
)
RETURNS nvarchar(50)
AS
BEGIN

	IF @Date IS NULL 
		RETURN NULL
	
	DECLARE @Result NVARCHAR(50)	

	SET @Result = 
	CASE UPPER(@PrefLanguage)
		WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), @Date , 111)
		WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), @Date , 111)
		WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), @Date , 105)
		WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), @Date , 111)
		WHEN  'FR-CA'  THEN cast( YEAR(@Date) AS nvarchar(4) ) + '-' +cast( MONTH(@Date) AS nvarchar(4) ) + '-' +cast( DAY(@Date) AS nvarchar(4) )
		WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), @Date , 104)
		WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), @Date , 105)
		WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), @Date , 111)
		WHEN  'KO-KR'  THEN cast( YEAR(@Date) AS nvarchar(4) ) + '-' +cast( MONTH(@Date) AS nvarchar(4) ) + '-' +cast( DAY(@Date) AS nvarchar(4) )
		WHEN  'PL-PL'  THEN cast( YEAR(@Date) AS nvarchar(4) ) + '-' +cast( MONTH(@Date) AS nvarchar(4) ) + '-' +cast( DAY(@Date) AS nvarchar(4) )
		WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), @Date , 105)
		WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), @Date , 104)
		WHEN  'SV-SE'  THEN cast( YEAR(@Date) AS nvarchar(4) ) + '-' +cast( MONTH(@Date) AS nvarchar(4) ) + '-' +cast( DAY(@Date) AS nvarchar(4) )
		WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), @Date , 105)
		WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), @Date , 104)
		WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), @Date , 101)
		ELSE CONVERT ( NVARCHAR(50), @Date , 103)
	END
	
	RETURN @Result
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07039', GetDate())
GO
