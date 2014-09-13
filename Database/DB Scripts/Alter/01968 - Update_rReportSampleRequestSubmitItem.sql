
IF(EXISTS(SELECT ReportSampleRequestSubmitPageID FROM rReportSampleRequestSubmitItem WHERE ReportFormName = 'SampleRequestSubmit_GradedRules_Body_LLT' and ReportpageApproved=1))
	BEGIN		
		UPDATE  rReportSampleRequestSubmitItem
		SET ReportpageApproved=0 
		WHERE ReportFormName='SampleRequestSubmit_GradedRules_Body_LLT'
		and ReportPageName='Graded Rules'
	END

GO

IF(EXISTS(SELECT ReportSampleRequestSubmitPageID FROM rReportSampleRequestSubmitItem WHERE ReportFormName = 'SampleRequestSubmit_GradedSpec_Body_LLT' and ReportpageApproved=1))
	BEGIN		
		UPDATE  rReportSampleRequestSubmitItem
		SET ReportpageApproved=0 
		WHERE ReportFormName='SampleRequestSubmit_GradedSpec_Body_LLT'
		and ReportPageName='Graded Spec'
	END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01968'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01968', GetDate())

END

GO