IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedSampleTechPack_Add_Selected_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_Selected_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_Selected_SELECT]
(
	@ReportSampleRequestSubmitFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT rsi.ReportFormName, rsi.ReportPageDescription + ' (' + rsi.ReportFormName + ')' AS ReportName
	FROM rReportSampleRequestSubmitItem rsi
	WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09309', GetDate())
GO
