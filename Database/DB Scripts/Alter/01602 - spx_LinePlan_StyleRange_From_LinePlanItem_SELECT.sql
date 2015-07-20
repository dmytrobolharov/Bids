IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_StyleRange_From_LinePlanItem_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_StyleRange_From_LinePlanItem_SELECT]
GO

CREATE PROCEDURE dbo.spx_LinePlan_StyleRange_From_LinePlanItem_SELECT(
	@LinePlanItemID UNIQUEIDENTIFIER 
)
AS


	SELECT LinePlanRangeID FROM pLinePlanItem WHERE LinePlanItemID = @LinePlanItemID

GO




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01602'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01602', GetDate())
END	

GO
