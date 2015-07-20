IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]    Script Date: 09/02/2014 21:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_Availible_SELECT]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		ISNULL(m.MapDetail + ' - ', '') + ISNULL(rspi.ReportPageName, '') AS ReportName
		, rspi.ReportPageID
	FROM
		rReportStylePageItem rspi
		LEFT JOIN Mapping m ON rspi.ReportMapID = m.Map
		LEFT JOIN rReportTechPackPageItem rtpi ON rspi.ReportFormName = rtpi.ReportFormName AND rtpi.ReportTechPackFolderID = @ReportTechPackFolderID
	WHERE rtpi.ReportTechPackPageID IS NULL
	ORDER BY ReportName, m.MapDetail, rtpi.ReportPageName
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09062', GetDate())
GO

