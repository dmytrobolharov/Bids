IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPack_WorkflowItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPack_WorkflowItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TechPack_WorkflowItems_SELECT]
	@ReportTechPackFolderID NVARCHAR(50),
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@StyleSet INT
AS
BEGIN
	SET NOCOUNT ON;

	IF @WorkflowID = '40000000-0000-0000-0000-000000000050' -- for measurement workflow we also select linked workflowitems
	BEGIN
		SELECT @ReportTechPackFolderID as ReportTechPackFolderID, WorkFlowItemID, WorkFlowItemName, wi.StyleSet, wi.Sort
		FROM pWorkFlowItem wi
		INNER JOIN Mapping m ON m.Map = wi.WorkflowID
		LEFT JOIN pStyleSeasonYear si ON wi.StyleID = si.StyleID AND si.StyleSeasonYearID = wi.StyleSeasonYearID
		WHERE WorkflowID = @WorkflowID AND wi.StyleID = @StyleID AND wi.StyleSet = @StyleSet
		AND (IsSeasonal = 0 OR (IsSeasonal = 1 AND si.SeasonYearID = @SeasonYearID))
		UNION
		SELECT @ReportTechPackFolderID as ReportTechPackFolderID, wi.WorkFlowItemID, WorkFlowItemName, wi.StyleSet, wi.Sort
		FROM pWorkFlowItem wi
		INNER JOIN pWorkFlowItemLinked wfil ON wi.WorkFlowItemID = wfil.WorkFlowItemID
		INNER JOIN Mapping m ON m.Map = wi.WorkflowID
		LEFT JOIN pStyleSeasonYear si ON wi.StyleID = si.StyleID AND si.StyleSeasonYearID = wi.StyleSeasonYearID
		WHERE WorkflowID = @WorkflowID AND wfil.StyleID = @StyleID AND wi.StyleSet = @StyleSet
		AND (IsSeasonal = 0 OR (IsSeasonal = 1 AND si.SeasonYearID = @SeasonYearID))
		ORDER BY StyleSet, Sort
			
	END
	ELSE
	BEGIN
		SELECT @ReportTechPackFolderID as ReportTechPackFolderID, WorkFlowItemID, WorkFlowItemName 
		FROM pWorkFlowItem wi
		INNER JOIN Mapping m ON m.Map = wi.WorkflowID
		LEFT JOIN pStyleSeasonYear si ON wi.StyleID = si.StyleID AND si.StyleSeasonYearID = wi.StyleSeasonYearID
		WHERE WorkflowID = @WorkflowID AND wi.StyleID = @StyleID AND wi.StyleSet = @StyleSet
		AND (IsSeasonal = 0 OR (IsSeasonal = 1 AND si.SeasonYearID = @SeasonYearID))
		AND (wi.WorkflowID != '40000000-0000-0000-0000-000000000080' OR (wi.WorkflowID = '40000000-0000-0000-0000-000000000080' AND wi.WorkStatus != 101))
		ORDER BY StyleSet, wi.Sort
	END
	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09218', GetDate())
GO
