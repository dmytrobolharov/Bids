IF NOT EXISTS(SELECT * FROM rReportSampleRequestSubmitItem WHERE ReportFormName = 'SampleRequestSubmit_MultiSubmit_Body_LLT')
	INSERT rReportSampleRequestSubmitItem (
	ReportSampleRequestSubmitPageID
	, ReportSampleRequestSubmitFolderID
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
	, ReportPageApproved
	, ReportPageSort
	)
VALUES (
	NEWID()
	, NULL
	, N'00000000-0000-0000-0000-000000000000'
	, N'SampleRequestSubmit_MultiSubmit_Header_LLT'
	, N'Sample Request Submit Summary'
	, N'Sample Request Submit Summary'
	, N'SQL'
	, N'SampleRequestSubmit_MultiSubmit_Body_LLT'
	, N'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	, N'StyleID'
	, 1
	, N'PDF'
	, 0
	, N'101'
	)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09888', GetDate())
GO
