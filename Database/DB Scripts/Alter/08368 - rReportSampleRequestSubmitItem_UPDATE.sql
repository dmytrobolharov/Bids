UPDATE rReportSampleRequestSubmitItem
SET ReportTemplateName = 'v5_SampleRequestSubmit_SpecImage_Header_LLT'
WHERE ReportFormName IN ('v5_SampleRequestSubmit_AttachedImages_Body_LLT', 'v5_SampleRequestSubmit_Care_Body_LLT', 'v5_SampleRequestSubmit_GradedRules_Body_LLT', 'v5_SampleRequestSubmit_GradedSpec_Body_LLT')
GO

UPDATE rReportSampleRequestSubmitItem
SET ReportFormName = REPLACE(ReportFormName, '_LLT', '_PLT')
WHERE ReportPageName = 'Sample Header'
	OR ReportPageName = 'Sample Comment'
	OR ReportPageName = 'Sample Fit Photos'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08368', GetDate())
GO
