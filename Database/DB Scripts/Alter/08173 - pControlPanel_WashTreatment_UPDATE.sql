Declare @ControlPanelTypeId uniqueidentifier
SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Wash Treatment'))
BEGIN
	
	UPDATE pControlPanel
	SET ControlPanelTypeID = @ControlPanelTypeId
	WHERE UPPER(ControlPanelName) = UPPER('Wash Treatment')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08173', GetDate())
GO
