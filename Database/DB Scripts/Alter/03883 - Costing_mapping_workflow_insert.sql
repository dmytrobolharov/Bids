
if not exists (select * from pWorkflow WHERE WorkflowID = '10000000-0000-0000-0000-000000000010')
	begin
	INSERT INTO pWorkflow (WorkflowID, Workflow, WorkDays, WorkAlert, WorkflowSort, CUser, CDate, MUser, MDate, Active, Body, WorkflowTypeID)
	VALUES     ('10000000-0000-0000-0000-000000000010', 'Costing', 5, 10, 11, NULL, NULL, NULL, NULL, 'True', 0, 'D')
end


Go

if not exists (select * from Mapping WHERE Map = '10000000-0000-0000-0000-000000000010')
	begin
		INSERT INTO Mapping(Map, MapDetail, MapUrl, MapEditUrl, MapFolder)
		VALUES     ('10000000-0000-0000-0000-000000000010', 'Costing', 'Style_CostSheet.aspx', 'Style_CostSheet_Edit.aspx', 'StyleFolder')
	end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03883', GetDate())
GO
