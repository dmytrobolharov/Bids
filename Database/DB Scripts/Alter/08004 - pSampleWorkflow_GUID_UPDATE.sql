UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000014' WHERE SampleWorkflowID = '14A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000016' WHERE SampleWorkflowID = '16A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000018' WHERE SampleWorkflowID = '18A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000020' WHERE SampleWorkflowID = '20A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000024' WHERE SampleWorkflowID = '24A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000025' WHERE SampleWorkflowID = '25A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000027' WHERE SampleWorkflowID = '27A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000030' WHERE SampleWorkflowID = '30A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000050' WHERE SampleWorkflowID = '50A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000090' WHERE SampleWorkflowID = '90A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000091' WHERE SampleWorkflowID = '91A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000092' WHERE SampleWorkflowID = '92A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000093' WHERE SampleWorkflowID = '93A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000094' WHERE SampleWorkflowID = '94A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000095' WHERE SampleWorkflowID = '95A'
UPDATE pSampleWorkflow SET SampleWorkflowGUID='A0000000-0000-0000-0000-000000000096' WHERE SampleWorkflowID = '96A'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08004', GetDate())
GO