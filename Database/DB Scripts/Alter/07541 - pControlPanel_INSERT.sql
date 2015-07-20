IF  NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Wash Treatment' AND ControlPanelID = 584)
BEGIN
	INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId], [IsDataValidation], [Sort]) 
	VALUES (584, N'Wash Treatment', N'Wash Treatment', 583, N'Control_Custom_xCustom5_ID.xml', N'Control_Custom_xCustom5_Default.xml', N'Control_Custom_xCustom5_Search.xml', N'xCustom5', N'Control_Custom_List.aspx?CPID=584', NULL, NULL, NULL, NULL, N'caeb0aab-3305-4272-b29c-a8e69849e23a', 0, 11)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07541', GetDate())
GO