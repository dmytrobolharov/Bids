IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pPlanningTypeSort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pPlanningTypeSort_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_pPlanningTypeSort_UPDATE] (
@PlanningTypeID  uniqueidentifier,
@Sort int
)

AS

	UPDATE pPlanningType SET Sort = @Sort WHERE PlanningTypeID = @PlanningTypeID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07478', GetDate())
GO