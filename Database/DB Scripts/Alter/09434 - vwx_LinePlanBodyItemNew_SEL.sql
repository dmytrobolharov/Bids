IF OBJECT_ID(N'[dbo].[vwx_LinePlanBodyItemNew_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanBodyItemNew_SEL]
GO

CREATE VIEW [dbo].[vwx_LinePlanBodyItemNew_SEL]
AS
SELECT lpbi.LinePlanBodyItemID, lpbi.LinePlanID, lpbi.LinePlanRangeID, lpbi.BodyID, 
       lpbi.CUser, lpbi.CDate, lpbi.MUser, lpbi.MDate, b.BodyNo, b.Description, b.StyleCategory, 
	   b.SizeClass, b.SizeRange, b.ImageID, b.ImageVersion, b.Season, b.Year
FROM pBody b 
INNER JOIN pLinePlanBodyItem lpbi ON b.BodyID = lpbi.BodyID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09434', GetDate())
GO
