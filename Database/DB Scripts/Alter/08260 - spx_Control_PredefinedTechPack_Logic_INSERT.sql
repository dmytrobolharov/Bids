IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Logic_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Logic_INSERT]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	UPDATE rReportTechPackFolder
	SET ReportTechPackFormName = 'v5_Style_Coversheet_LLT' 
	WHERE ReportTechPackFolderID = @ReportTechPackFolderID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08260', GetDate())
GO                      