IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedSampleTechPack_Add_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_DELETE]
(
	@ReportSampleRequestSubmitFolderID UNIQUEIDENTIFIER
	, @ReportFormName NVARCHAR(255)
)
AS
BEGIN
	DELETE FROM rReportSampleRequestSubmitItem
	WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID
		AND ReportFormName = @ReportFormName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09311', GetDate())
GO
