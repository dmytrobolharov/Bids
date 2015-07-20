IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName LIKE '%Material Workflow%')
BEGIN
	DECLARE @CPID INT
	SELECT @CPID = MAX(ControlPanelID)+1 FROM pControlPanel
	
	INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId], [IsDataValidation]) VALUES (@CPID, N'Material Workflow', N'Material Workflow', 462, NULL, N'Control_Workflow_Material_Default.xml', N'Control_Workflow_Material_Search.xml', N'pMaterialTemplate', N'Control_Workflow_Material_List.aspx?CPID=' + CAST(@CPID AS VARCHAR(10)), NULL, NULL, NULL, NULL, NEWID(), 0)
END
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03375', GetDate())

GO