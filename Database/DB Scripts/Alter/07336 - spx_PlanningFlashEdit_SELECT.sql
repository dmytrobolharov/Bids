IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningFlashEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningFlashEdit_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningFlashEdit_SELECT]
	@PlanningFlashEditID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	SELECT * FROM pPlanningFlashEdit
	WHERE PlanningFlashEditActive = 1
		AND PlanningFlashEditID = @PlanningFlashEditID OR @PlanningFlashEditID IS NULL
	ORDER BY PlanningFlashEditSort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07336', GetDate())
GO
