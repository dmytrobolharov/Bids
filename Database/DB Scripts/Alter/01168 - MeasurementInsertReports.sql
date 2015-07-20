IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportMapID='40000000-0000-0000-0000-000000000050')
   BEGIN
        PRINT 'Style Measurement reports already exists'
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
		,'40000000-0000-0000-0000-000000000050'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Measurement Imperial View'
		,'Style Measurement'
		,'SQL'
		,'Style_MeasurementImperial_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')

	
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
		,'40000000-0000-0000-0000-000000000050'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Measurement Metric View'
		,'Style Measurement'
		,'SQL'
		,'Style_MeasurementMetric_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')


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
		,'40000000-0000-0000-0000-000000000050'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Measurement WorkSheet'
		,'Style Measurement'
		,'SQL'
		,'Style_MeasurementWorkSheet_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleId'
		,'1'
		,'PDF'
		,'1')

    END
GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01168', GetDate())
GO