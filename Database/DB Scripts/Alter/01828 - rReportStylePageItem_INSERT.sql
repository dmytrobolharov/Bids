IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportFormName = 'Style_BOL_Expanded')
   BEGIN
        PRINT 'Style_BOL_Expanded already exists'
   END
ELSE

BEGIN

	INSERT INTO rReportStylePageItem
	(ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
	VALUES
	( 	NEWID()
		,'40000000-0000-0000-0000-000000000077'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style BOL Details Expanded'
		,'Style BOL Details Expanded'
		,'SQL'
		,'Style_BOL_Expanded'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')
END
GO 

IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportFormName = 'Style_BOL_Collapsed')
   BEGIN
        PRINT 'Style_BOL_Collapsed already exists'
   END
ELSE

BEGIN

	INSERT INTO rReportStylePageItem
	(ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
	VALUES
	( 	NEWID()
		,'40000000-0000-0000-0000-000000000077'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style BOL Details Collapsed'
		,'Style BOL Details Collapsed'
		,'SQL'
		,'Style_BOL_Collapsed'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')
END
GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01828'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01828', GetDate())
END

GO
