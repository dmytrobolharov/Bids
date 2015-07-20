DECLARE @WorkflowID UNIQUEIDENTIFIER = '40000000-0000-0000-0000-000000000099'
DECLARE @ChangeTableID UNIQUEIDENTIFIER = 'D612FAAE-7ACD-DF11-AF06-005056C00099'

IF NOT EXISTS (SELECT * FROM Mapping WHERE Map = @WorkflowID)
	INSERT INTO Mapping (Map, MapDetail, MapUrl, MapEditUrl, MapEmlUrl, MapFolder, MapPageUrl, IsSeasonal)
	VALUES (@WorkflowID, '3D Files', 'Style_WorkFlowItems.aspx', 'Style_3D_Files.aspx', 'Style_3D_Files.aspx', 'StyleFolder', 'Style_3D_Files.aspx', 1)

IF NOT EXISTS (SELECT * FROM pWorkflow WHERE WorkflowID = @WorkflowID)
	INSERT INTO pWorkflow (WorkflowID, Workflow, Active, Body, WorkflowTypeID)
	VALUES (@WorkflowID, '3D Files', 1, 0, 'D')

IF NOT EXISTS (SELECT * FROM pWorkflowItemType WHERE MapId = @WorkflowID)
	INSERT INTO pWorkflowItemType (WorkflowItemTypeId, MapId, ItemTypeLabel)
	VALUES (NEWID(), @WorkflowID, '3D Files')

IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = @ChangeTableID)
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES (@ChangeTableID, 'pStyle3DFiles', 'WorkFlowItemID', 'Style3DFileID', 'ChangeLogItem_Default.xml')

IF NOT EXISTS (SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID = @WorkflowID)
	INSERT INTO pStyleWorkflowToChangeTable (WorkflowID, ChangeTableID)
	VALUES (@WorkflowID, @ChangeTableID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09662', GetDate())
GO