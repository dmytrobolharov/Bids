IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPack_MultiWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPack_MultiWorkflow_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TechPack_MultiWorkflow_SELECT]
(
	@StyleID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@ReportTechPackFolderID uniqueidentifier
)
AS
BEGIN

	DECLARE @StyleWorkflowID uniqueidentifier
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WHERE StyleID = @StyleID
	
	IF @StyleWorkflowID IS NOT NULL
	BEGIN
		SELECT DISTINCT ReportTechPackFolderID, ReportMapID, Mapping.MapDetail, pStyleWorkflow.WorkSort FROM rReportTechPackPageItem
			INNER JOIN Mapping ON rReportTechPackPageItem.ReportMapID = Mapping.Map 
			INNER JOIN pStyleWorkflow ON rReportTechPackPageItem.ReportMapID = pStyleWorkflow.WorkflowID AND StyleID = @StyleID
			INNER JOIN pWorkflowTemplateItem ON pStyleWorkflow.WorkflowID = pWorkflowTemplateItem.WorkflowID 
				AND pWorkflowTemplateItem.WorkflowTemplateID = @StyleWorkflowID
			LEFT JOIN pStyleSeasonYear ON pStyleWorkflow.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			WHERE ReportTechPackFolderID = @ReportTechPackFolderID AND ReportMapID IS NOT NULL
			AND (Mapping.IsSeasonal = 0 OR (Mapping.IsSeasonal = 1 AND pStyleSeasonYear.SeasonYearID = @SeasonYearID))
		ORDER BY pStyleWorkflow.WorkSort
	END	
	ELSE
	BEGIN
		SELECT DISTINCT ReportTechPackFolderID, ReportMapID, Mapping.MapDetail, pStyleWorkflow.WorkSort FROM rReportTechPackPageItem
			INNER JOIN Mapping ON rReportTechPackPageItem.ReportMapID = Mapping.Map 
			INNER JOIN pStyleWorkflow ON rReportTechPackPageItem.ReportMapID = pStyleWorkflow.WorkflowID AND StyleID = @StyleID
			LEFT JOIN pStyleSeasonYear ON pStyleWorkflow.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			WHERE ReportTechPackFolderID = @ReportTechPackFolderID AND ReportMapID IS NOT NULL
			AND (Mapping.IsSeasonal = 0 OR (Mapping.IsSeasonal = 1 AND pStyleSeasonYear.SeasonYearID = @SeasonYearID))
		ORDER BY pStyleWorkflow.WorkSort
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07620', GetDate())
GO
