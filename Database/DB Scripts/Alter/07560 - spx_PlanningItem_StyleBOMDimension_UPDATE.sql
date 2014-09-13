IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_StyleBOMDimension_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_StyleBOMDimension_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_StyleBOMDimension_UPDATE]
	@PlanningItemID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	
	UPDATE pPlanningItem SET StyleBOMDimensionID = @StyleBOMDimensionID WHERE PlanningItemID = @PlanningItemID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07560', GetDate())
GO
