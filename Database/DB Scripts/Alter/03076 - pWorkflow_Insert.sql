
DECLARE @WorkflowSort int
Select @WorkflowSort = WorkflowSort from pWorkflow where WorkflowID = '40000000-0000-0000-0000-000000000080'

IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000081')
	BEGIN
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000081'
				   ,'Colorway Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
	
IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000082')
	BEGIN
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000082'
				   ,'Quantity Per Style Size Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
	
IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000083')
	BEGIN          
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000083'
				   ,'Measure For Style Size Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03076'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03076', GetDate())

END

GO