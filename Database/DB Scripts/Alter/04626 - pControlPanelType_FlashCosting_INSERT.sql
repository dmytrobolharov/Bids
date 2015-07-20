IF NOT EXISTS(SELECT ControlPanelTypeID FROM pControlPanelType WHERE ControlPanelTypeName='Flash Costing' AND ControlPanelTypeDescription='Flash Costing')
BEGIN
	DECLARE @Sort INT
	SELECT @Sort = ISNULL(MAX(CAST(Sort AS Int)), 0) FROM pControlPanelType
	SET @Sort = @Sort+1
	INSERT INTO pControlPanelType (ControlPanelTypeName, ControlPanelTypeDescription, Active, Sort)
	VALUES('Flash Costing', 'Flash Costing', 1, RIGHT('0000' + CAST(@Sort AS VARCHAR(4)), 3))
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04626', GetDate())
GO
