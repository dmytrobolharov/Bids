IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedSampleTechPack_Add_Availible_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_Availible_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_Availible_SELECT]
(
	@ReportSampleRequestSubmitFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT DISTINCT rsi.ReportFormName, rsi.ReportPageDescription + ' (' + rsi.ReportFormName + ')' AS ReportName
	FROM rReportSampleRequestSubmitItem rsi
	WHERE rsi.ReportFormName NOT IN (
		SELECT DISTINCT ReportFormName FROM rReportSampleRequestSubmitItem
		WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09312', GetDate())
GO
