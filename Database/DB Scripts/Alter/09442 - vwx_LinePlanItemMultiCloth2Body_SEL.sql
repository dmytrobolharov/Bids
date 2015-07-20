IF OBJECT_ID(N'[dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]
GO

CREATE VIEW [dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]
AS
SELECT lpbi.LinePlanBodyItemID, lpbi.LinePlanID, lpbi.LinePlanRangeID, lpbi.BodyID, 
       lpbi.CUser, lpbi.CDate, lpbi.MUser, lpbi.MDate, b.BodyNo, b.Description, b.StyleCategory, 
	   b.SizeClass, b.SizeRange, b.ImageID, b.ImageVersion, b.Season, b.Year, b.BodyID AS Expr1, 
	   b.BodyWorkflowID, b.DevelopmentID, b.BodyTypeID, b.BodySet, 
       '<img src=''../System/Control/ImageStream.ashx?S=50&V=' + CAST(ISNULL(b.ImageVersion, 0) AS NVARCHAR(5)) 
       + '&IID=' + CAST(ISNULL(b.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS BodyImage
FROM pBody b
INNER JOIN pLinePlanBodyItem lpbi ON b.BodyID = lpbi.BodyID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09442', GetDate())
GO
