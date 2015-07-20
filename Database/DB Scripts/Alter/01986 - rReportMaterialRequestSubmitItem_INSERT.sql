if (select COUNT(*) from rReportMaterialRequestSubmitItem where ReportFormName = 'MaterialRequestSubmitComment_Body_LLT') = 0
INSERT INTO [rReportMaterialRequestSubmitItem](
	[ReportMaterialRequestSubmitPageID]
	,[ReportMaterialRequestSubmitFolderID]
	,[ReportPageTypeID]
	,[ReportTemplateName]
	,[ReportPageName]
	,[ReportPageDescription]
	,[ReportServerType]
	,[ReportFormName]
	,[ReportPageURL]
	,[ReportPKIField]
	,[ReportPageActive]
	,[ReportPageFormat]
	,[ReportPageApproved]
	,[ReportPageSort]
)
VALUES(
	'1CB4EA80-C34C-4BBD-8F35-E1DBCAA76E18'
	,'A1000000-0000-0000-0000-000000000001'
	,'00000000-0000-0000-0000-000000000000'
	,'MaterialRequestSubmit_Header_LLT'
	,'Material Header'
	,'Material Request Header'
	,'SQL'
	,'MaterialRequestSubmitComment_Body_LLT'
	,'MaterialRequestSubmit.aspx?RPID=##RPID##&SID='
	,'StyleID'
	,1
	,'PDF'
	,0
	,'001'
)
GO

if (select COUNT(*) from rReportMaterialRequestSubmitItem where ReportFormName = 'MaterialRequestSubmitItem_Body_LLT') = 0
INSERT INTO [rReportMaterialRequestSubmitItem](
	[ReportMaterialRequestSubmitPageID]
	,[ReportMaterialRequestSubmitFolderID]
	,[ReportPageTypeID]
	,[ReportTemplateName]
	,[ReportPageName]
	,[ReportPageDescription]
	,[ReportServerType]
	,[ReportFormName]
	,[ReportPageURL]
	,[ReportPKIField]
	,[ReportPageActive]
	,[ReportPageFormat]
	,[ReportPageApproved]
	,[ReportPageSort]
)
VALUES(
	'1CB4EA80-C34C-4BBD-8F35-E1DBCAA76E17'
	,'A1000000-0000-0000-0000-000000000001'
	,'00000000-0000-0000-0000-000000000000'
	,'MaterialRequestSubmit_Header_LLT'
	,'Material Header'
	,'Material Request Header'
	,'SQL'
	,'MaterialRequestSubmitItem_Body_LLT'
	,'MaterialRequestSubmit.aspx?RPID=##RPID##&SID='
	,'StyleID'
	,1
	,'PDF'
	,0
	,'002'
)
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01986'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01986', GetDate())

END

GO

