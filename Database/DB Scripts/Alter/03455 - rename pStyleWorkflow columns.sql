if Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowAssignedToName'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	EXEC sp_rename
    @objname = 'pStyleWorkflow.WorkflowAssignedToName',
    @newname = 'WorkAssignedToName',
    @objtype = 'COLUMN'
end
go


if Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowEscalateTo'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	EXEC sp_rename
    @objname = 'pStyleWorkflow.WorkflowEscalateTo',
    @newname = 'WorkEscalateTo',
    @objtype = 'COLUMN'
end
go


if Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowEscalateToName'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	EXEC sp_rename
    @objname = 'pStyleWorkflow.WorkflowEscalateToName',
    @newname = 'WorkEscalateToName',
    @objtype = 'COLUMN'
end
go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03455', GetDate())
	

GO



