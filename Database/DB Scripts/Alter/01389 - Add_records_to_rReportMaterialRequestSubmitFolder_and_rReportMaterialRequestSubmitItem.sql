/*Delete if records are already there.*/
DELETE
FROM rReportMaterialRequestSubmitFolder
WHERE ReportMaterialRequestSubmitName = 'Material Request Submit'

DELETE
FROM rReportMaterialRequestSubmitItem
WHERE ReportFormName = 'MaterialRequestSubmitComment_Body_LLT'

DELETE
FROM rReportMaterialRequestSubmitItem
WHERE ReportFormName = 'MaterialRequestSubmitItem_Body_LLT'


/*Parent table - Entry 01.*/
INSERT INTO [rReportMaterialRequestSubmitFolder](
	[ReportMaterialRequestSubmitFolderID]
	,[ReportMaterialRequestSubmitName]
	,[ReportMaterialRequestSubmitFormName]
	,[ReportMaterialRequestSubmitGroup]
	,[ReportMaterialRequestSubmitFinal]
	,[CDate]
	,[CUser]
	,[MDate]
	,[MUser]
	,[ReportMaterialRequestSubmitSort]
	,[Active]
	,[srmOn]
)
VALUES(
	'A1000000-0000-0000-0000-000000000001'
	,'Material Request Submit'
	,'Material Submit'
	,0
	,1
	,NULL
	,NULL
	,NULL
	,NULL
	,001
	,1
	,1
)


/*Child table - Entry 01.*/
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
	,'003'
)


/*Child table - Entry 02.*/
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
	,'003'
)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01389', GETDATE())
GO