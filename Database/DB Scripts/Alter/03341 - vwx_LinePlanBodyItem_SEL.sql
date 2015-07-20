IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanBodyItem_SEL]'))
DROP VIEW [dbo].[vwx_LinePlanBodyItem_SEL]
GO
CREATE  VIEW [dbo].[vwx_LinePlanBodyItem_SEL]
AS
SELECT     dbo.pLinePlanBodyItem.LinePlanBodyItemID, dbo.pLinePlanBodyItem.LinePlanID, dbo.pLinePlanBodyItem.LinePlanRangeID, dbo.pLinePlanBodyItem.BodyID, 
                      dbo.pLinePlanBodyItem.CUser, dbo.pLinePlanBodyItem.CDate, dbo.pLinePlanBodyItem.MUser, dbo.pLinePlanBodyItem.MDate, dbo.pBody.BodyNo, 
                      dbo.pBody.Description, dbo.pBody.StyleCategory, dbo.pBody.SizeClass, dbo.pBody.SizeRange, dbo.pBody.ImageID, dbo.pBody.ImageVersion, dbo.pBody.Season, 
                      dbo.pBody.Year,dbo.pBody.Active
FROM         dbo.pBody INNER JOIN
                      dbo.pLinePlanBodyItem ON dbo.pBody.BodyID = dbo.pLinePlanBodyItem.BodyID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03341'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03341', GetDate())
END	
GO