IF NOT EXISTS (SELECT * FROM pStyleNBOLException WHERE UPPER(ExceptionName) = 'STANDARD')
BEGIN
	INSERT INTO [pStyleNBOLException]
			   ([ExceptionID]
			   ,[StyleID]
			   ,[StyleSet]
			   ,[WorkflowID]
			   ,[WorkflowItemID]
			   ,[ExceptionName]
			   ,[CUser]
			   ,[CDate]
			   ,[MUser]
			   ,[MDate]
			   ,[Active]
			   ,[Sort])
		 VALUES
			   ('00000000-0000-0000-0000-000000000000'
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,'Standard'
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03555', GetDate())
GO