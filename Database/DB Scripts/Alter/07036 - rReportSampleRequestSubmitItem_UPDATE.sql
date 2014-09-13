UPDATE rReportSampleRequestSubmitItem SET ReportFormName = REPLACE(ReportFormName, 'v5_SampleRequestSubmit_Material_VendorComments_Body_LLT', 'v5_SampleRequestSubmit_Material_VendorComments_Body_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportFormName = REPLACE(ReportFormName, 'v5_SampleRequestSubmit_FitPhotos_LLT', 'v5_SampleRequestSubmit_FitPhotos_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportFormName = REPLACE(ReportFormName, 'v5_SampleRequestSubmit_Measurement_Body_LLT', 'v5_SampleRequestSubmit_Measurement_Body_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportFormName = REPLACE(ReportFormName, 'v5_SampleRequestSubmit_QAMeasurement_Body_LLT', 'v5_SampleRequestSubmit_QAMeasurement_Body_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportFormName = REPLACE(ReportFormName, 'v5_SampleRequestSubmit_SpecImage_VendorComments_Body_LLT', 'v5_SampleRequestSubmit_SpecImage_VendorComments_Body_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportTemplateName = REPLACE(ReportTemplateName, 'v5_SampleRequestSubmit_Material_Header_LLT', 'v5_SampleRequestSubmit_Material_Header_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportTemplateName = REPLACE(ReportTemplateName, 'v5_SampleRequestSubmit_QAImage_Header_LLT', 'v5_SampleRequestSubmit_QAImage_Header_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportTemplateName = REPLACE(ReportTemplateName, 'v5_SampleRequestSubmit_SpecImage_Header_LLT', 'v5_SampleRequestSubmit_SpecImage_Header_PLT')
GO

UPDATE rReportSampleRequestSubmitItem SET ReportTemplateName = REPLACE(ReportTemplateName, 'v5_SampleRequestSubmit_SpecImage_VendorComments_Header_LLT', 'v5_SampleRequestSubmit_SpecImage_VendorComments_Header_PLT')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07036', GetDate())
GO
