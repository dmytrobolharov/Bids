IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningDivision_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningDivision_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningDivision_INSERT]
	@PlanningID UNIQUEIDENTIFIER, 
	@DivisionIDs VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pPlanningDivision WHERE PlanningID = @PlanningID
	
	INSERT INTO pPlanningDivision (PlanningID, DivisionID)
	SELECT @PlanningID, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@DivisionIDs,',')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06168', GetDate())
GO
