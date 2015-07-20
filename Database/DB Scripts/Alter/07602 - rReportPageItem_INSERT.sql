DELETE FROM rReportPageItem WHERE ReportFormName = 'v5_ControlPanel_MeasurementPOMTemplate_NW_Body_LLT'
INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
		ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
VALUES (NEWID(), 'A1110000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_ControlPanel_MeasurementPOMTemplate_Header_LLT',
		'Measurement POM Template (N/W)', 'Measurement POM Template (N/W)', 'SQL', 'v5_ControlPanel_MeasurementPOMTemplate_NW_Body_LLT', '/MeasurementPomTemplateReport.aspx?RPID=##RPID##&PTID=', 'PomTemplateId', 1, 'PDF')
GO		
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07602', GetDate())
GO
