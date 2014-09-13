IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningHistory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.PlanningID, b.PlanningName
	FROM pPlanningHistory a
				INNER JOIN pPlanning b on a.PlanningID = b.PlanningID
	WHERE a.TeamID = @TeamId
	ORDER BY a.CDate DESC

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06165', GetDate())
GO
