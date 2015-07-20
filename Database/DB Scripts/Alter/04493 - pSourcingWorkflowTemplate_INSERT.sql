IF NOT EXISTS (SELECT * FROM pSourcingWorkflowTemplate WHERE TemplateName = 'Apparel')
BEGIN
	INSERT INTO [pSourcingWorkflowTemplate]
			   ([SourcingWorkflowTemplateID]
			   ,[TemplateName]
			   ,[TemplateDescription]
			   ,[Active]
			   ,[EnforceDependency]
			   ,[StartDate]
			   ,[DueDate]
			   ,[ScheduleBy]
			   ,[CUser]
			   ,[CDate]
			   ,[MUser]
			   ,[MDate])
		 VALUES
			   ('8E45BB0A-9F1E-4D0B-A44E-861A1BF8B8EC'
			   ,'Apparel'
			   ,'Apparel'
			   ,1
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04493', GetDate())
GO
