IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_DELETE]
	@PlanningItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07562', GetDate())
GO
