IF NOT EXISTS(SELECT * FROM rReportSampleRequestSubmitItem WHERE ReportFormName = 'SampleRequestSubmit_CombinedFullSubmitSummary_Body_LLT')
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
	, N'SampleRequestSubmit_CombinedFullSubmitSummary_Header_LLT'
	, N'Combined Full Submit Summary'
	, N'Combined Full Submit Summary'
	, N'SQL'
	, N'SampleRequestSubmit_CombinedFullSubmitSummary_Body_LLT'
	, N'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	, N'StyleID'
	, 1
	, N'PDF'
	, 0
	, N'101'
	)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09875', GetDate())
GO
