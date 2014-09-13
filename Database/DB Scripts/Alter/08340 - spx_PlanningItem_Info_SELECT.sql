IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Info_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Info_SELECT]
	@PlanningItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT pli.*, sbd.WorkFlowItemID, sh.DevelopmentID, sh.StyleType FROM pPlanningItem pli
	LEFT JOIN pStyleBOMDimension sbd ON pli.StyleBOMDimensionID = sbd.StyleBOMDimensionID	
	INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
	WHERE PlanningItemID = @PlanningItemID
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08340', GetDate())
GO