/*Report 01 - Style Model - List*/
INSERT INTO rReportStylePageItem
(
	[ReportPageID]
	,[ReportMapID]
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
	,[ReportSrmOn]
)
VALUES
(
	'DCFD6435-E77A-48B5-81C2-E0B5D4275B01'
	,'40000000-0000-0000-0000-000000000037'
	,'00000000-0000-0000-0000-000000000000'
	,'Style_Header_LLT'
	,'Model - List'
	,'Model - List'
	,'SQL'
	,'Style_Model_Body_LLT'
	,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	,'StyleId'
	,1
	,'PDF'
	,1
)


/*Report 02 - Style Model - List Details - Imperial*/
INSERT INTO rReportStylePageItem
(
	[ReportPageID]
	,[ReportMapID]
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
	,[ReportSrmOn]
)
VALUES
(
	'DCFD6435-E77A-48B5-81C2-E0B5D4275B02'
	,'40000000-0000-0000-0000-000000000037'
	,'00000000-0000-0000-0000-000000000000'
	,'Style_Header_LLT'
	,'Model - List Details - Imperial'
	,'Model - List Details - Imperial'
	,'SQL'
	,'Style_Model_Details_Imperial_Body_LLT'
	,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	,'StyleId'
	,1
	,'PDF'
	,1
)


/*Report 03 - Style Model - List Details - Metric*/
INSERT INTO rReportStylePageItem
(
	[ReportPageID]
	,[ReportMapID]
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
	,[ReportSrmOn]
)
VALUES
(
	'DCFD6435-E77A-48B5-81C2-E0B5D4275B03'
	,'40000000-0000-0000-0000-000000000037'
	,'00000000-0000-0000-0000-000000000000'
	,'Style_Header_LLT'
	,'Model - List Details - Metric'
	,'Model - List Details - Metric'
	,'SQL'
	,'Style_Model_Details_Metric_Body_LLT'
	,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	,'StyleId'
	,1
	,'PDF'
	,1
)


/*Report 04 - Style Model - 1 Image per Page*/
INSERT INTO rReportStylePageItem
(
	[ReportPageID]
	,[ReportMapID]
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
	,[ReportSrmOn]
)
VALUES
(
	'DCFD6435-E77A-48B5-81C2-E0B5D4275B04'
	,'40000000-0000-0000-0000-000000000037'
	,'00000000-0000-0000-0000-000000000000'
	,'Style_Header_LLT'
	,'Model - 1 Image per Page'
	,'Model - 1 Image per Page'
	,'SQL'
	,'Style_Model_1x1_Body_LLT'
	,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	,'StyleId'
	,1
	,'PDF'
	,1
)


/*Report 05 - Style Model - 21 Images per Page*/
INSERT INTO rReportStylePageItem
(
	[ReportPageID]
	,[ReportMapID]
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
	,[ReportSrmOn]
)
VALUES
(
	'DCFD6435-E77A-48B5-81C2-E0B5D4275B05'
	,'40000000-0000-0000-0000-000000000037'
	,'00000000-0000-0000-0000-000000000000'
	,'Style_Header_LLT'
	,'Model - 21 Images per Page'
	,'Model - 21 Images per Page'
	,'SQL'
	,'Style_Model_7x3_Body_LLT'
	,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
	,'StyleId'
	,1
	,'PDF'
	,1
)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01312', GetDate())
GO