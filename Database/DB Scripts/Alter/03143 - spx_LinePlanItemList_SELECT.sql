/****** Object:  StoredProcedure [dbo].[spx_LinePlanItemList_SELECT]    Script Date: 02/22/2012 16:30:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanItemList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanItemList_SELECT]    Script Date: 02/22/2012 16:30:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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


SELECT pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, pStyleHeader.StyleNo, pStyleHeader.SizeClass, pStyleHeader.SizeRange,
      pStyleHeader.Description, pLinePlanItem.LinePlanItemID, pLinePlanItem.LinePlanRangeID, pLinePlanItem.LinePlanRangeTypeID, 
      pLinePlanItem.LinePlanID, pLinePlanItem.StyleID, pLinePlanItem.CUser, pLinePlanItem.CDate, pLinePlanItem.MUser, 
      pLinePlanItem.MDate, pLinePlanItem.CustomField1, pLinePlanItem.CustomField2, pLinePlanItem.CustomField3, 
      pLinePlanItem.CustomField4, pLinePlanItem.CustomField5, pLinePlanItem.CustomField6, pLinePlanItem.CustomField7, 
      pLinePlanItem.CustomField8, pLinePlanItem.CustomField9, pLinePlanItem.CustomField10, pLinePlanItem.CustomField11, 
      pLinePlanItem.CustomField12, pLinePlanItem.CustomField13, pLinePlanItem.CustomField14, pLinePlanItem.CustomField15, 
      pLinePlanItem.CustomField16, pLinePlanItem.CustomField17, pLinePlanItem.CustomField18, pLinePlanItem.CustomField19, 
      pLinePlanItem.CustomField20, pLinePlanItem.CustomField21, pLinePlanItem.CustomField22, pLinePlanItem.CustomField23, 
      pLinePlanItem.CustomField24, pLinePlanItem.CustomField25, pLinePlanItem.CustomField26, pLinePlanItem.CustomField27, 
      pLinePlanItem.CustomField28, pLinePlanItem.CustomField29, pLinePlanItem.CustomField30, @StyleTypeID AS StyleTypeID, 
	  @StyleCategoryID AS StyleCategoryID, pStyleHeader.MaterialName, @SeasonYearID AS SeasonYearID, e.AttributeName
FROM pStyleHeader RIGHT OUTER JOIN
    pLinePlanItem ON pStyleHeader.StyleID = pLinePlanItem.StyleID LEFT OUTER JOIN
    pLinePlanStyleAttributeItem AS e ON e.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID
WHERE pLinePlanItem.LinePlanRangeID = @LinePlanRangeID AND pLinePlanItem.LinePlanRangeTypeID = @LinePlanRangeTypeID AND pLinePlanItem.LinePlanID = @LinePlanID
ORDER BY pStyleHeader.StyleNo

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03143'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03143', GetDate())

END
GO
