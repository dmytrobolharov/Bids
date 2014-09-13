IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_SELECT_CarryOver]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_SELECT_CarryOver]
GO


CREATE PROCEDURE [dbo].[spx_LinePlan_SELECT_CarryOver](
@LinePlanID UNIQUEIDENTIFIER 
)
AS 

DECLARE @SEASON NVARCHAR(200)
DECLARE @YEAR NVARCHAR(200)
DECLARE @SeasonYearID UNIQUEIDENTIFIER 

SELECT @SEASON = ISNULL(a.Season,''), @YEAR = ISNULL(a.Year,'')
FROM pLinePlan a
WHERE a.LinePlanID = @LinePlanID 

IF LEN(@SEASON) = 0 
BEGIN
	SET @SEASON = '*N\A'
	UPDATE pLinePlan SET Season = @SEASON WHERE LinePlanID = @LinePlanID
END
	
IF LEN(@YEAR) = 0 
BEGIN 
	SET @YEAR = '*N\A'
	UPDATE pLinePlan SET Year= @YEAR WHERE LinePlanID = @LinePlanID
END 
	
	
SELECT @SeasonYearID = SeasonYearID 
FROM pSeasonYear 
WHERE Season= @SEASON
AND Year = @YEAR 

IF @SeasonYearID IS NULL
BEGIN
	SET @SeasonYearID  = NEWID()	
	INSERT INTO pSeasonYear ( SeasonYearID , Season, Year, Active ) 
	VALUES (@SeasonYearID , @SEASON, @YEAR, 1 ) 
END 

SELECT a.*, b.SeasonYearID
FROM pLinePlan a
INNER JOIN pSeasonYear b ON a.Season = b.Season AND b.Year = b.Year 
WHERE a.LinePlanID = @LinePlanID 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '233', GetDate())

GO