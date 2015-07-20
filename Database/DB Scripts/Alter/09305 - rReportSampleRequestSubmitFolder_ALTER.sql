IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='ReportTechPackFormName' AND TABLE_NAME='rReportSampleRequestSubmitFolder')
	ALTER TABLE rReportSampleRequestSubmitFolder ADD ReportTechPackFormName nVARCHAR(200) NULL
GO

UPDATE rReportSampleRequestSubmitFolder SET ReportTechPackFormName = 'v5_Style_Coversheet_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09305', GetDate())
GO
