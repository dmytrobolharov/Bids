IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedSampleTechPack_Add_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedSampleTechPack_Add_INSERT]
(
	@ReportSampleRequestSubmitFolderID UNIQUEIDENTIFIER
	, @ReportFormName NVARCHAR(MAX)
	, @ReportPageSort INT
)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID AND ReportFormName = @ReportFormName)
		INSERT INTO rReportSampleRequestSubmitItem
		SELECT TOP 1
			NEWID()
			, @ReportSampleRequestSubmitFolderID
			, ReportPageTypeID
			, ReportTemplateName
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportFormName
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive
			, ReportPageFormat
			, 0
			, RIGHT('00' + CAST(@ReportPageSort AS NVARCHAR(3)), 3)
		FROM rReportSampleRequestSubmitItem
		WHERE ReportFormName = @ReportFormName
	ELSE
		UPDATE rReportSampleRequestSubmitItem
		SET ReportPageSort = RIGHT('00' + CAST(@ReportPageSort AS NVARCHAR(3)), 3)
		WHERE ReportSampleRequestSubmitFolderID = @ReportSampleRequestSubmitFolderID
			AND ReportFormName = @ReportFormName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09310', GetDate())
GO
