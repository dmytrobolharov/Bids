IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedSampleTechPack_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_DELETE]
(
	@ReportSampleRequestSubmitFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM rReportSampleRequestSubmitFolder
	WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID
	
	DELETE FROM rReportSampleRequestSubmitItem
	WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09308', GetDate())
GO
