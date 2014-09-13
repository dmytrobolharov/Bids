DELETE
FROM pControlPanel
WHERE ControlPanelID = 17
GO

INSERT INTO pControlPanel([ControlPanelID]
                         ,[ControlPanelName]
                         ,[ControlPanelDescription]
                         ,[ControlPanelOrder]
                         ,[ControlPanelIdSchema]
                         ,[ControlPanelSchema]
                         ,[ControlPanelSearchSchema]
                         ,[ControlPanelTableName]
                         ,[ControlPanelUrl]
                         ,[ControlPanelEditSchema]
                         ,[SPXLogicInsert]     )
VALUES(17
       ,'Size Class'
       ,'Size Class'
       ,3
       ,NULL
       ,'Control_GRSizeClass_Library.xml'
       ,'Control_GRSizeClass_SearchLibrary.xml'
       ,'pGRSizeClass'
       ,'Control_SizeClass_GR.aspx?CPID=17'
       ,NULL
       ,NULL)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '841', GetDate())
GO
