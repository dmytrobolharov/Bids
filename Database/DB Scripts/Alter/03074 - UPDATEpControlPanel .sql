UPDATE pControlPanel 
SET ControlPanelSchema = 'Control_StyleCategory_Default.xml' ,
	ControlPanelSearchSchema = 'Control_StyleCategory_Search.xml' ,
	ControlPanelTableName='pStyleCategory'
WHERE ControlPanelName='Category' AND
	ControlPanelSchema = 'Control_xCustom2_Default.xml' AND
 	ControlPanelSearchSchema = 'Control_xCustom2_Search.xml' AND
	ControlPanelTableName='xCustom2'

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03074'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03074', GetDate())
END	
GO