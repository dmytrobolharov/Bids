IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Drop]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Drop]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Drop] 
	@PlanningItemID UNIQUEIDENTIFIER,
	@PlanningItemDrop NVARCHAR(10),
	@PlanningItemDropUser NVARCHAR(200),
	@PlanningItemDropDate DATETIME
AS
BEGIN

	UPDATE pPlanningItem SET
		PlanningItemDrop = @PlanningItemDrop,
		PlanningItemDropUser = @PlanningItemDropUser,
		PlanningItemDropDate = @PlanningItemDropDate
	WHERE PlanningItemID = @PlanningItemID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06364', GetDate())
GO
