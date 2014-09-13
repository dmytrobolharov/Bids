
DECLARE @WorkflowSort int
Select @WorkflowSort = WorkflowSort from pWorkflow where WorkflowID = '40000000-0000-0000-0000-000000000050'

IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000051')
	BEGIN
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000051'
				   ,'Sample Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
	
IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000052')
	BEGIN
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000052'
				   ,'Worksheet Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
	
IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000053')
	BEGIN          
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000053'
				   ,'Imperial Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
	
IF NOT EXISTS (select * from  pWorkflow  where WorkflowID = '40000000-0000-0000-0000-000000000054')
	BEGIN          
		INSERT INTO pWorkflow
				   (WorkflowID
				   ,Workflow
				   ,WorkflowSort
				   ,Active
				   ,Body
				   ,WorkflowTypeID)
			 VALUES
				   ('40000000-0000-0000-0000-000000000054'
				   ,'Metric Tab'
				   ,@WorkflowSort
				   ,'False'
				   ,0
				   ,0)
	END
GO	
	
	

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03162'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '03162', GetDate())

END

GO