

UPDATE pControlPanel SET ControlPanelName ='Size Range Yunique', ControlPanelDescription ='Style Size Range Yunique', 
	ControlPanelUrl='Control_SizeRange_ListYnique.aspx?CPID=16' 
	WHERE ControlPanelID =16

INSERT INTO pControlPanel
                      (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, 
					 ControlPanelIdSchema, ControlPanelSchema, ControlPanelSearchSchema, 
					ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema, SPXLogicInsert)
VALUES     (15, 'Measurements', 'Measurements Library', 2, NULL, NULL, 
			NULL, NULL, 'Control_Measurement.aspx?CPID=15', NULL, NULL)
GO

INSERT INTO pControlPanel
                      (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, 
					 ControlPanelIdSchema, ControlPanelSchema, ControlPanelSearchSchema, 
					ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema, SPXLogicInsert)
VALUES     (20, 'Size Range', 'Size Range', 2, NULL, 'Control_GRSizeRange_Default.xml', 
			'Control_GRSizeRange_Search.xml', 'pGRSizeRange', 'Control_SizeRange_GR.aspx?CPID=20', NULL, NULL)
GO

INSERT INTO pControlPanel
                      (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, 
					 ControlPanelIdSchema, ControlPanelSchema, ControlPanelSearchSchema, 
					ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema, SPXLogicInsert)
VALUES     (17, 'Size Class', 'Size Class', 3, NULL, NULL, 
			NULL, 'pGRSizeClass', 'Control_SizeClass_List.aspx?CPID=17', NULL, NULL)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '536', GetDate())
GO