INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
      SummaryXML, EditXML, MaterialXML)
SELECT a.SampleWorkflowID, b.StatusID, 
'SampleRequestSubmitItem_Summary_Default.xml' AS SummaryXML,
'SampleRequestSubmitItem_E_Edit.xml'  AS EditXML,
'SampleRequestSubmitItem_E_POM.xml' AS MaterialXML
FROM  dbo.pSampleWorkflow a, dbo.pSampleRequestSubmitStatus b
where a.groupid='E' 
Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '870', GetDate())
GO

