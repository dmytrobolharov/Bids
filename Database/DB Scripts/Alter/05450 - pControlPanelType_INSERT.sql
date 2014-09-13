IF NOT EXISTS(SELECT ControlPanelTypeID FROM pControlPanelType WHERE ControlPanelTypeName='Calendar' AND ControlPanelTypeDescription='Calendar')
BEGIN
	DECLARE @Sort INT
	SELECT @Sort = ISNULL(MAX(CAST(Sort AS Int)), 0) FROM pControlPanelType
	SET @Sort = @Sort+1
	INSERT INTO pControlPanelType (ControlPanelTypeName, ControlPanelTypeDescription, Active, Sort)
	VALUES('Calendar', 'Calendar', 1, RIGHT('0000' + CAST(@Sort AS VARCHAR(4)), 3))
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05450', GetDate())
GO
