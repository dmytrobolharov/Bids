INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
      SummaryXML, EditXML, MaterialXML)
SELECT a.SampleWorkflowID, b.StatusID, 
'SampleRequestSubmitItem_Summary_Default.xml' AS SummaryXML,
'SampleRequestSubmitItem_M_Edit.xml'  AS EditXML,
'SampleRequestSubmitItem_M_14A_Comment.xml' AS MaterialXML
FROM  dbo.pSampleWorkflow a, dbo.pSampleRequestSubmitStatus b
where a.groupid='I' 
Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01798'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01798', GetDate())

END

GO 

