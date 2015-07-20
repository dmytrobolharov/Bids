
begin

	if not exists (select * from pWorkflow WHERE WorkflowID = '80000000-0000-0000-0000-000000000008')
	
	begin
	
		INSERT INTO pWorkflow (WorkflowID, Workflow, WorkDays, WorkAlert, WorkflowSort, CUser, CDate, MUser, MDate, Active, Body, WorkflowTypeID)
		VALUES     ('80000000-0000-0000-0000-000000000008', 'Construction Details', 5, 10, 8, NULL, NULL, NULL, NULL, 'True', 0, 'D')
	end

end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '550', GetDate())
GO