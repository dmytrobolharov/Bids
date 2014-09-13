 Update pControlPanel set ControlPanelSchema = 'Control_pSeason_Default.xml', ControlPanelSearchSchema = 'Control_pSeason_Search.xml', ControlPanelTableName = 'pSeason' Where ControlPanelName = 'Season'

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01771'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01771', GetDate())
	END
GO
 