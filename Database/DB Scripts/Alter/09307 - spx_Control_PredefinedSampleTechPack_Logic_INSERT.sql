IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedSampleTechPack_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Logic_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Logic_INSERT]
(
	@ReportSampleRequestSubmitFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	UPDATE rReportSampleRequestSubmitFolder
	SET ReportTechPackFormName = 'v5_Style_Coversheet_LLT' 
	WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09307', GetDate())
GO
