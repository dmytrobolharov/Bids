
IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportFormName = 'Style_ConstructionDetails_2_Body_LLT')
   BEGIN
        PRINT 'Style_ConstructionDetails_2_Body_LLT already exists'
   END
ELSE
  BEGIN


	Insert into rReportStylePageItem 
		(ReportPageID
		,ReportMapID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportSrmOn)
	values 
		(NEWID()
		,'80000000-0000-0000-0000-000000000008'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Construction Details & 3 User Defined'
		,'Style Construction Details'
		,'SQL'
		,'Style_ConstructionDetails_2_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')
    END
GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01068', GetDate())
GO