IF NOT EXISTS (SELECT * FROM pWorkflow WHERE UPPER(WorkflowID) = '40000000-0000-0000-0000-000000000021')
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
			   ('40000000-0000-0000-0000-000000000021'
			   ,'Attribute'
			   ,2
			   ,10
			   ,9
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
VALUES     ('DB_Version', '5.0.0000', '05036', GetDate())
GO