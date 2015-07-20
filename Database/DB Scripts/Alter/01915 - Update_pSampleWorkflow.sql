update pSampleWorkflow set Active = 'Yes' where SampleWorkflowID = '20A'

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01915'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01915', GetDate())

END
GO