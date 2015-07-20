INSERT INTO pWorkflow (WorkflowID, Workflow, WorkDays, WorkAlert, WorkflowSort, CUser, CDate, MUser, MDate, Active, Body, WorkflowTypeID)
VALUES     ('40000000-0000-0000-0000-000000000050', 'Measurement Wash', 5, 10, 6, NULL, NULL, NULL, NULL, 'True', 0, 'D')


INSERT INTO pWorkflow (WorkflowID, Workflow, WorkDays, WorkAlert, WorkflowSort, CUser, CDate, MUser, MDate, Active, Body, WorkflowTypeID)
VALUES     ('40000000-0000-0000-0000-000000000051', 'Measurement N/W', 5, 10, 6, NULL, NULL, NULL, NULL, 'True', 0, 'D')



INSERT INTO Mapping(Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder)
VALUES     ('40000000-0000-0000-0000-000000000050', 'Measurement Wash', 'Style_DevelopmentMeas.aspx', 'Style_DevelopmentMeas_Edit.aspx', 'Style_DevelopmentMeas_Eml.aspx', 'StyleFolder')

INSERT INTO Mapping(Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder)
VALUES     ('40000000-0000-0000-0000-000000000051', 'Measurement N/W', 'Style_DevelopmentMeas.aspx', 'Style_DevelopmentMeas_Edit.aspx', 'Style_DevelopmentMeas_Eml.aspx', 'StyleFolder')


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '410', GetDate())

GO