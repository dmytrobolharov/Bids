
/****** Object:  View [dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]    Script Date: 06/14/2010 11:21:49 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]'))
DROP VIEW [dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]
GO


/****** Object:  View [dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]    Script Date: 06/14/2010 11:21:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LinePlanItemMultiCloth2Body_SEL]
AS
SELECT     dbo.pLinePlanBodyItem.LinePlanBodyItemID, dbo.pLinePlanBodyItem.LinePlanID, dbo.pLinePlanBodyItem.LinePlanRangeID, dbo.pLinePlanBodyItem.BodyID, 
                      dbo.pLinePlanBodyItem.CUser, dbo.pLinePlanBodyItem.CDate, dbo.pLinePlanBodyItem.MUser, dbo.pLinePlanBodyItem.MDate, dbo.pBody.BodyNo, 
                      dbo.pBody.Description, dbo.pBody.StyleCategory, dbo.pBody.SizeClass, dbo.pBody.SizeRange, dbo.pBody.ImageID, dbo.pBody.ImageVersion, dbo.pBody.Season, 
                      dbo.pBody.Year, dbo.pBody.BodyID AS Expr1, dbo.pBody.BodyWorkflowID, dbo.pBody.DevelopmentID, dbo.pBody.BodyTypeID, dbo.pBody.BodySet, 
                      '<img src=''../System/Control/ImageStream.ashx?S=50&V=' + CAST(ISNULL(dbo.pBody.ImageVersion, 0) AS NVARCHAR(5)) 
                      + '&IID=' + CAST(ISNULL(dbo.pBody.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS BodyImage
FROM         dbo.pBody INNER JOIN
                      dbo.pLinePlanBodyItem ON dbo.pBody.BodyID = dbo.pLinePlanBodyItem.BodyID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '160', GetDate())
GO