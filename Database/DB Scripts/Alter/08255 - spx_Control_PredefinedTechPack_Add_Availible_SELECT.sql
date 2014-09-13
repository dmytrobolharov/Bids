IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		ISNULL(m.MapDetail + ' - ', '') + ISNULL(rspi.ReportPageName, '') AS ReportName
		, rspi.ReportFormName
	FROM
		rReportStylePageItem rspi
		LEFT JOIN Mapping m ON rspi.ReportMapID = m.Map
		LEFT JOIN rReportTechPackPageItem rtpi ON rspi.ReportFormName = rtpi.ReportFormName AND rtpi.ReportTechPackFolderID = @ReportTechPackFolderID
	WHERE rtpi.ReportTechPackPageID IS NULL
	ORDER BY m.MapDetail, rtpi.ReportPageName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08255', GetDate())
GO                      