IF EXISTS(SELECT SampleWorkflow FROM psampleworkflow WHERE SampleWorkflow='QA Meas Worksheet')
   BEGIN
        PRINT 'QA Meas Worksheet bubble already exists'
   END
ELSE
  BEGIN
	Insert into psampleworkflow values('95A', 'QA Meas Worksheet',    '40000000-0000-0000-0000-000000000050',    'A'   ,'QA Meas Worksheet',     '21', 'Yes',      NULL, NULL  ,NULL,      NULL      ,'015',     0, NEWID())
  END
  
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01478', GetDate())
GO