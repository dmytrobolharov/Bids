DELETE FROM rReportPageItem WHERE ReportPageID = 'B169CFD6-9A8B-4D15-B53E-908AF88E8760'
INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
		ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
VALUES ('B169CFD6-9A8B-4D15-B53E-908AF88E8760', 'A1110000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_ControlPanel_MeasurementPOMTemplate_Header_LLT',
		'Measurement - How To Measure 4 Images', 'Measurement - How To Measure 4 Images', 'SQL', 'v5_ControlPanel_Measurement_HowToMeasure_4ImagesPerPage_Body_LLT', '/MeasurementPomTemplateReport.aspx?RPID=##RPID##&PTID=', 'PomTemplateId', 1, 'PDF')

DELETE FROM rReportPageItem WHERE ReportPageID = '99E52AF7-25F4-4666-A062-BBBD8C95BBF2'
INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
		ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
VALUES ('99E52AF7-25F4-4666-A062-BBBD8C95BBF2', 'A1111000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_Blank_Header_LLT',
		'Measurement - How To Measure 4 Images', 'Measurement - How To Measure 4 Images', 'SQL', 'v5_ControlPanel_Measurement_HowToMeasure_4ImagesPerPage_Body_LLT', '/MeasurementPomTemplateReport.aspx?RPID=##RPID##&PTID=', 'PomTemplateId', 1, 'PDF')
		
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05076', GetDate())
GO
