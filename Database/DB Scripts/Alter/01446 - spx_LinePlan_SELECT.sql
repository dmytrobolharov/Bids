IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_SELECT](
@LinePlanID UNIQUEIDENTIFIER 
)
AS 

DECLARE @SEASON NVARCHAR(200)
DECLARE @YEAR NVARCHAR(200)
DECLARE @SeasonYearID UNIQUEIDENTIFIER 
DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER 
DECLARE @HierarchyLevel INT


SELECT @SEASON = ISNULL(a.Season,''), @YEAR = ISNULL(a.Year,''),
@LinePlanTemplateID = a.LinePlanTemplateID
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


SELECT @HierarchyLevel = COUNT(*) 
FROM pLinePlanTemplateItem WHERE LinePlanTemplateID = @LinePlanTemplateID


SELECT a.*, b.SeasonYearID, @HierarchyLevel AS HierarchyLevel
FROM pLinePlan a
INNER JOIN pSeasonYear b ON a.Season = b.Season AND a.Year = b.Year 
WHERE a.LinePlanID = @LinePlanID 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0.6820', '01446', GetDate())

GO

