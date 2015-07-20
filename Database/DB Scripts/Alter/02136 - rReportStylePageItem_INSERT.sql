IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportFormName = 'Style_Sourcing_BOL_Collapsed')
   BEGIN
        PRINT 'Style_Sourcing_BOL_Collapsed already exists'
   END
ELSE

BEGIN

	INSERT INTO rReportStylePageItem
	(ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
	VALUES
	( 	NEWID()
		,'10000000-0000-0000-0000-000000000000'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style Sourcing BOL Collapsed'
		,'Style Sourcing BOL Collapsed'
		,'SQL'
		,'Style_Sourcing_BOL_Collapsed'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')
END
GO 

IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportFormName = 'Style_Sourcing_BOL_Expanded')
   BEGIN
        PRINT 'Style_Sourcing_BOL_Expanded already exists'
   END
ELSE

BEGIN

	INSERT INTO rReportStylePageItem
	(ReportPageID,ReportMapID,ReportPageTypeID,ReportTemplateName,ReportPageName,ReportPageDescription,ReportServerType,ReportFormName,ReportPageURL,ReportPKIField,ReportPageActive,ReportPageFormat,ReportSrmOn)
	VALUES
	( 	NEWID()
		,'10000000-0000-0000-0000-000000000000'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style Sourcing BOL Expanded'
		,'Style Sourcing BOL Expanded'
		,'SQL'
		,'Style_Sourcing_BOL_Expanded'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')
END
GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02136'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02136', GetDate())
END

GO
