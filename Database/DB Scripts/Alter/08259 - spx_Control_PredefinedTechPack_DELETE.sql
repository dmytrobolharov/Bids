IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_DELETE]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM rReportTechPackFolder
	WHERE ReportTechPackFolderID = @ReportTechPackFolderID
	
	DELETE FROM rReportTechPackPageItem
	WHERE ReportTechPackFolderID = @ReportTechPackFolderID	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08259', GetDate())
GO                      