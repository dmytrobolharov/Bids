IF OBJECT_ID(N'[dbo].[spx_LinePlanItemList_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanItemList_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemList_SELECT](
@LinePlanRangeTypeID UNIQUEIDENTIFIER,
@LinePlanRangeID UNIQUEIDENTIFIER,
@LinePlanID UNIQUEIDENTIFIER
)
AS

DECLARE @StyleTypeID INT
SELECT @StyleTypeID = StyleTypeID FROM fnx_LinePlanStyleType(@LinePlanRangeID)

DECLARE @StyleCategoryID UNIQUEIDENTIFIER
SELECT @StyleCategoryID = StyleCategoryID FROM fnx_LinePlanStyleCategory(@LinePlanRangeID)

DECLARE @SeasonYearID UNIQUEIDENTIFIER
DECLARE @Season NVARCHAR (200)
DECLARE @Year NVARCHAR (200)

SELECT @Season = Season, @Year = Year FROM pLineplan WHERE LinePlanID = @LinePlanID 
SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear  WHERE Season = @Season AND Year = @Year 


SELECT sh.DesignSketchID, sh.DesignSketchVersion, sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.Description, pLinePlanItem.LinePlanItemID, 
	   pLinePlanItem.LinePlanRangeID, pLinePlanItem.LinePlanRangeTypeID, 
      pLinePlanItem.LinePlanID, pLinePlanItem.StyleID, pLinePlanItem.CUser, pLinePlanItem.CDate, pLinePlanItem.MUser, 
      pLinePlanItem.MDate, pLinePlanItem.CustomField1, pLinePlanItem.CustomField2, pLinePlanItem.CustomField3, 
      pLinePlanItem.CustomField4, pLinePlanItem.CustomField5, pLinePlanItem.CustomField6, pLinePlanItem.CustomField7, 
      pLinePlanItem.CustomField8, pLinePlanItem.CustomField9, pLinePlanItem.CustomField10, pLinePlanItem.CustomField11, 
      pLinePlanItem.CustomField12, pLinePlanItem.CustomField13, pLinePlanItem.CustomField14, pLinePlanItem.CustomField15, 
      pLinePlanItem.CustomField16, pLinePlanItem.CustomField17, pLinePlanItem.CustomField18, pLinePlanItem.CustomField19, 
      pLinePlanItem.CustomField20, pLinePlanItem.CustomField21, pLinePlanItem.CustomField22, pLinePlanItem.CustomField23, 
      pLinePlanItem.CustomField24, pLinePlanItem.CustomField25, pLinePlanItem.CustomField26, pLinePlanItem.CustomField27, 
      pLinePlanItem.CustomField28, pLinePlanItem.CustomField29, pLinePlanItem.CustomField30, @StyleTypeID AS StyleTypeID, 
	  @StyleCategoryID AS StyleCategoryID, sh.MaterialName, @SeasonYearID AS SeasonYearID, e.AttributeName
FROM pStyleHeader sh
RIGHT OUTER JOIN pLinePlanItem ON sh.StyleID = pLinePlanItem.StyleID 
LEFT OUTER JOIN pLinePlanStyleAttributeItem AS e ON e.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE pLinePlanItem.LinePlanRangeID = @LinePlanRangeID AND pLinePlanItem.LinePlanRangeTypeID = @LinePlanRangeTypeID AND pLinePlanItem.LinePlanID = @LinePlanID
ORDER BY sh.StyleNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09631', GetDate())
GO
