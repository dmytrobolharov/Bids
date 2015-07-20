DECLARE @FlashCostingFolderID UNIQUEIDENTIFIER

SELECT @FlashCostingFolderID = ControlPanelTypeID FROM pControlPanelType
WHERE ControlPanelTypeName='Flash Costing' AND ControlPanelTypeDescription='Flash Costing'

IF @FlashCostingFolderID IS NOT NULL
BEGIN
	UPDATE pControlPanel
	SET ControlPanelTypeID = @FlashCostingFolderID
	WHERE ControlPanelName = 'Flash Cost Duty Table'
	OR ControlPanelName = 'Consumption and Labor Tables'
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04627', GetDate())
GO
