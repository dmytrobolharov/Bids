IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_Add_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_DELETE]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
	, @ReportTechPackPageID NVARCHAR(255)
)
AS
BEGIN
	DELETE FROM rReportTechPackPageItem
	WHERE
		ReportTechPackFolderID = @ReportTechPackFolderID
		AND ReportTechPackPageID = @ReportTechPackPageID
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09145', GetDate())
GO