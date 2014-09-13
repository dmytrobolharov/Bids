UPDATE pControlPanel 
SET ControlPanelTableName = 'xCustom3' 
WHERE ControlPanelID = 319 AND ControlPanelName = 'Product Type' AND ControlPanelTableName = 'HCustmom14'
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03155'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03155', GetDate())

END
GO