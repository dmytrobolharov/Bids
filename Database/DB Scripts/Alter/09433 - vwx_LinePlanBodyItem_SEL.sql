IF OBJECT_ID(N'[dbo].[vwx_LinePlanBodyItem_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanBodyItem_SEL]
GO

CREATE  VIEW [dbo].[vwx_LinePlanBodyItem_SEL]
AS
SELECT lpbi.LinePlanBodyItemID, lpbi.LinePlanID, lpbi.LinePlanRangeID, lpbi.BodyID, 
       lpbi.CUser, lpbi.CDate, lpbi.MUser, lpbi.MDate, b.BodyNo, b.Description, b.StyleCategory, 
	   b.SizeClass, b.SizeRange, b.ImageID, b.ImageVersion, b.Season, b.Year,b.Active
FROM dbo.pBody b
INNER JOIN pLinePlanBodyItem lpbi ON b.BodyID = lpbi.BodyID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09433', GetDate())
GO
