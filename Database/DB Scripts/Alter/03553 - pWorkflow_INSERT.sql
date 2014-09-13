IF NOT EXISTS (SELECT * FROM pWorkflow WHERE UPPER(Workflow) = 'BILL OF LABOR V.2')
BEGIN
	INSERT INTO [pWorkflow]
			   ([WorkflowID]
			   ,[Workflow]
			   ,[WorkDays]
			   ,[WorkAlert]
			   ,[WorkflowSort]
			   ,[CUser]
			   ,[CDate]
			   ,[MUser]
			   ,[MDate]
			   ,[Active]
			   ,[Body]
			   ,[WorkflowTypeID])
		 VALUES
			   ('40000000-0000-0000-0000-000000000078'
			   ,'Bill Of Labor v.2'
			   ,3
			   ,10
			   ,3
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,1
			   ,0
			   ,'D')
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03553', GetDate())
GO