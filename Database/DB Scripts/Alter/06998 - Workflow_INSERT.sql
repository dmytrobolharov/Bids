IF NOT EXISTS(SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000090')
BEGIN
	INSERT Mapping (Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder, Sort, MapConceptUrl, MapConceptEditUrl, MapPageUrl, IsSeasonal) 
	VALUES (N'40000000-0000-0000-0000-000000000090', N'Style SKU', N'Style_WorkFlowItems.aspx', N'Style_SKUItem_Edit.aspx', N'Style_SKUItem_Edit.aspx', N'StyleFolder', N'A11', NULL, NULL, N'Style_SKUItem_Edit.aspx', 1)
END		

IF NOT EXISTS(SELECT * FROM pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000090')
BEGIN
	INSERT pWorkflow (WorkflowID, Workflow, WorkDays, WorkAlert, WorkflowSort, CUser, CDate, MUser, MDate, Active, Body, WorkflowTypeID) 
	VALUES (N'40000000-0000-0000-0000-000000000090', N'Style SKU', 3, 10, 3, NULL, NULL, NULL, NULL, 1, 0, N'D')
END

IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = 'd617faae-7acd-df11-af06-005056c00010')
BEGIN
	INSERT pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) 
	VALUES (N'd617faae-7acd-df11-af06-005056c00010', N'pStyleSKU', N'WorkflowItemID', N'StyleSKUID', N'ChangeLogItem_Advanced.xml')
END

IF NOT EXISTS(SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID = '40000000-0000-0000-0000-000000000090')
BEGIN
	INSERT pStyleWorkflowToChangeTable (WorkflowID, ChangeTableID) 
	VALUES (N'40000000-0000-0000-0000-000000000090', N'd617faae-7acd-df11-af06-005056c00010')
END

IF NOT EXISTS(SELECT * FROM pWorkflowItemType WHERE WorkflowItemTypeId = 'BDDC9946-E428-4518-8199-297936D27B7B')
BEGIN
	INSERT INTO pWorkflowItemType(WorkflowItemTypeId, MapId, SchemaFileName, ItemTypeLabel, SchemaFileEditName)
	VALUES ('BDDC9946-E428-4518-8199-297936D27B7B', '40000000-0000-0000-0000-000000000090', NULL, 'Style SKU', NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06998', GetDate())
GO
