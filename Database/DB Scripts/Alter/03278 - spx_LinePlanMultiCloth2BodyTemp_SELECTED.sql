/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2BodyTemp_SELECTED](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS

BEGIN

SELECT TOP (1) dbo.pLinePlanMultiCloth2BodyTemp.LinePlanMultiCloth2BodyTempID, dbo.pLinePlanMultiCloth2BodyTemp.LinePlanColorGroupID, 
      dbo.pLinePlanMultiCloth2BodyTemp.LinePlanBodyItemID, dbo.pLinePlanMultiCloth2BodyTemp.LinePlanRangeID, dbo.pLinePlanMultiCloth2BodyTemp.LinePlanID, 
      dbo.pLinePlanMultiCloth2BodyTemp.CUser, dbo.pLinePlanMultiCloth2BodyTemp.CDate, dbo.pLinePlanMultiCloth2BodyTemp.MUser, 
      dbo.pLinePlanMultiCloth2BodyTemp.MDate, dbo.pBody.BodyNo, dbo.pBody.Description,dbo.pBody.BodyID
FROM  dbo.pLinePlanBodyItem INNER JOIN
      dbo.pLinePlanMultiCloth2BodyTemp ON dbo.pLinePlanBodyItem.LinePlanBodyItemID = dbo.pLinePlanMultiCloth2BodyTemp.LinePlanBodyItemID INNER JOIN
      dbo.pBody ON dbo.pLinePlanBodyItem.BodyID = dbo.pBody.BodyID
WHERE pLinePlanMultiCloth2BodyTemp.LinePlanColorGroupID = @LinePlanColorGroupID 

END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03278'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03278', GetDate())
END	
GO