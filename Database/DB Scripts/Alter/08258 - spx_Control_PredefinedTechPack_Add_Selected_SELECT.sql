IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_Add_Selected_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_Selected_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_Selected_SELECT]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		ISNULL(m.MapDetail + ' - ', '') + ISNULL(rtpi.ReportPageName, '') AS ReportName
		, rtpi.ReportFormName
	FROM
		rReportTechPackPageItem rtpi
		LEFT JOIN Mapping m ON rtpi.WorkflowID = m.Map
	WHERE rtpi.ReportTechPackFolderID = @ReportTechPackFolderID
	ORDER BY rtpi.ReportPageSort, m.MapDetail, rtpi.ReportPageName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08258', GetDate())
GO                      