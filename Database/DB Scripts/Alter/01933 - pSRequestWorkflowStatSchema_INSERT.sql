IF(NOT EXISTS(SELECT SampleWorkflowID FROM pSampleRequestWorkflowStatusSchema WHERE SampleWorkflowID='95A'))
BEGIN
	INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
		  SummaryXML, EditXML, MaterialXML)
	SELECT a.SampleWorkflowID, b.StatusID, 
	'SampleRequestSubmitItem_Summary_Default.xml' AS SummaryXML,
	'SampleRequestSubmitItem_A_Edit.xml'  AS EditXML,
	'SampleRequestSubmitItem_A_POM.xml' AS MaterialXML
	FROM  dbo.pSampleWorkflow a, dbo.pSampleRequestSubmitStatus b
	where a.groupid='A' 
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01933'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01933', GetDate())
END

GO
