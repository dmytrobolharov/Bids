UPDATE pSampleWorkflow set GroupName = '-ProtoType'
WHERE SampleWorkflowID = '90A'
AND SampleWorkflow = 'Proto Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-Pre Production'
WHERE SampleWorkflowID = '91A'
AND SampleWorkflow = 'PP Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-Sales Sample'
WHERE SampleWorkflowID = '92A'
AND SampleWorkflow = 'Ship Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-TOP of Production'
WHERE SampleWorkflowID = '93A'
AND SampleWorkflow = 'Top Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-Fit Sample'
WHERE SampleWorkflowID = '94A'
AND SampleWorkflow = 'Fit Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01470', GetDate())
GO