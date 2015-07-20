IF NOT EXISTS (SELECT * FROM pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000085')
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
			   ('40000000-0000-0000-0000-000000000085'
			   ,'Wardrobe'
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
VALUES     ('DB_Version', '0.5.0000', '05703', GetDate())
GO