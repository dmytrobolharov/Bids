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

	DECLARE @StyleWorkflowID uniqueidentifier;
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID
	
	SELECT 1 As StyleSet, '70000000-0000-0000-0000-000000000001' As WorkflowID, 0 As Sort, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, NULL as WorkflowSort  
	FROM Mapping 
	WHERE Map = '70000000-0000-0000-0000-000000000001' AND Map IN (SELECT WorkflowID FROM pStyleWorkflowTeam WHERE StyleId = @StyleID AND TeamID = @TeamID)
	UNION
	SELECT sw.StyleSet, sw.WorkflowID, 1 as Sort, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, e.WorkflowSort
	FROM pStyleWorkflow sw 	
		LEFT JOIN Mapping m ON sw.WorkflowID = m.Map
		LEFT JOIN pStyleSeasonYear ssy ON sw.StyleSeasonYearID = ssy.StyleSeasonYearID
		LEFT JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = m.Map 
	WHERE sw.StyleID = @StyleID AND sw.StyleSet = @StyleSet 
		AND (m.IsSeasonal = 1 AND ssy.SeasonYearID = @SeasonYearID OR m.IsSeasonal = 0) 	
		AND sw.WorkflowId IN (SELECT WorkflowID FROM pStyleWorkflowTeam WHERE StyleId = @StyleID AND TeamID = @TeamID)
		AND e.WorkflowTemplateID = @StyleWorkflowID
	ORDER BY Sort, WorkflowSort
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06745', GetDate())
GO
