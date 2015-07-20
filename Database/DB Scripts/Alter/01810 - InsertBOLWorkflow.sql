INSERT INTO pWorkflow (WorkflowID, Workflow, WorkDays, WorkAlert, WorkflowSort, CUser, CDate, MUser, MDate, Active, Body, WorkflowTypeID)
VALUES     ('40000000-0000-0000-0000-000000000077', 'BOL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'True', 0, 'D')

INSERT INTO Mapping(Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder)
VALUES     ('40000000-0000-0000-0000-000000000077', 'Bill Of Labor', 'Style_BOL_List.aspx', 'Style_BOL_Edit.aspx', NULL, 'StyleFolder')

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01810'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01810', GetDate())
END

GO
