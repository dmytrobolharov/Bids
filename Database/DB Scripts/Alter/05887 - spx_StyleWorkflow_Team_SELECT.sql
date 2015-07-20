IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_Team_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_Team_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflow_Team_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@TeamID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER = NULL
AS
BEGIN

	SELECT sw.*, MapDetail, MapUrl, MapEditUrl, MapEmlUrl
	FROM pStyleWorkflow sw 
	LEFT JOIN Mapping m ON sw.WorkflowID = m.Map
	LEFT JOIN pStyleSeasonYear ssy ON sw.StyleSeasonYearID = ssy.StyleSeasonYearID
	WHERE sw.StyleID = @StyleID AND sw.StyleSet = @StyleSet 
		AND (m.IsSeasonal = 1 AND ssy.SeasonYearID = @SeasonYearID OR m.IsSeasonal = 0) 	
		AND sw.WorkflowId IN (SELECT WorkflowID FROM pStyleWorkflowTeam WHERE StyleId = @StyleID AND TeamID = @TeamID)
	ORDER BY sw.WorkflowID, sw.WorkSort, sw.WorkDue
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05887', GetDate())
GO
