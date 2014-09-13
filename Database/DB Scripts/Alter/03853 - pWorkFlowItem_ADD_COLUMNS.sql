IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pWorkFlowItem' 
    AND  COLUMN_NAME = 'WorkStart')
	ALTER TABLE pWorkFlowItem ADD WorkStart datetime NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pWorkFlowItem' 
    AND  COLUMN_NAME = 'WorkDue')
	ALTER TABLE pWorkFlowItem ADD WorkDue datetime NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pWorkFlowItem' 
    AND  COLUMN_NAME = 'WorkAssignedTo')
	ALTER TABLE pWorkFlowItem ADD WorkAssignedTo int NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pWorkFlowItem' 
    AND  COLUMN_NAME = 'WorkStatus')
	ALTER TABLE pWorkFlowItem ADD WorkStatus int NULL
	
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pWorkFlowItem' 
    AND  COLUMN_NAME = 'WorkEscalateTo')
	ALTER TABLE pWorkFlowItem ADD WorkEscalateTo int NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03853', GetDate())
GO