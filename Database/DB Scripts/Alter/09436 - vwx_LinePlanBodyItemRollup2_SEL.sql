IF OBJECT_ID(N'[dbo].[vwx_LinePlanBodyItemRollup2_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanBodyItemRollup2_SEL]
GO

CREATE VIEW [dbo].[vwx_LinePlanBodyItemRollup2_SEL]
AS
SELECT b.BodyNo, b.Description, b.StyleCategory, b.SizeClass, b.SizeRange, 
	   b.ImageID, b.ImageVersion, b.Season, b.Year, lpbi.LinePlanID, lpbi.BodyID, 
	   lpr.LinePlanAttributeItemID1, lpr.LinePlanAttributeItemID2
FROM pBody b 
INNER JOIN pLinePlanBodyItem lpbi ON b.BodyID = lpbi.BodyID 
INNER JOIN pLinePlanRange lpr ON lpbi.LinePlanRangeID = lpr.LinePlanRangeID
GROUP BY b.BodyNo, b.Description, b.StyleCategory, b.SizeClass, b.SizeRange, b.ImageID, 
         b.ImageVersion, b.Season, b.Year, lpbi.LinePlanID, lpbi.BodyID, 
         lpr.LinePlanAttributeItemID1, lpr.LinePlanAttributeItemID2

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09436', GetDate())
GO
