IF NOT EXISTS(SELECT * FROM pControlPanel WHERE LOWER(ControlPanelName) = N'image workflow')
BEGIN
	DECLARE @CPID INT,
			@CPOrder INT
	SELECT @CPID = MAX(ControlPanelID) + 1 FROM pControlPanel
	SELECT @CPOrder = MAX(ControlPanelOrder) + 1 FROM pControlPanel
	
	INSERT INTO pControlPanel(ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder,
		ControlPanelSchema, ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelIdSchema,
		ControlPanelTableName, ControlPanelUrl,
		IsDataValidation, SPXLogicInsert, SPXLogicUpdate)
	VALUES (@CPID, N'Image Workflow', N'Image Workflow', @CPOrder,
		N'Control_ImageWorkflow_Default.xml', N'Control_ImageWorkflow_Search.xml', NULL, NULL,
		N'pImageWorkflowTemplate', N'Control_ImageWorkflow_List.aspx?CPID=' + CAST(@CPID AS VARCHAR(MAX)),
		0, NULL, NULL)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03564', GetDate())
GO 