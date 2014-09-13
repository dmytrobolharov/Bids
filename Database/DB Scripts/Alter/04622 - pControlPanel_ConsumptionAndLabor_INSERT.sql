Declare @ControlPanelOrder int
Declare @ControlPanelID int
Declare @ControlPanelTypeId uniqueidentifier

IF NOT EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName = 'Consumption and Labor Tables')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel WHERE ControlPanelTypeID = '09773e42-5ab8-e011-9f63-544c92f24f0d'
	IF @ControlPanelOrder = 1
		SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  FROM pControlPanel
	
	INSERT INTO
		pControlPanel
		(ControlPanelID
		, ControlPanelName
		, ControlPanelDescription
		, ControlPanelOrder
		, ControlPanelTableName
		, ControlPanelSchema
		, ControlPanelSearchSchema
		, ControlPanelEditSchema
		, ControlPanelUrl
		, ControlPanelTypeID)
	VALUES
		(@ControlPanelID
		, 'Consumption and Labor Tables'
		, 'Consumption and Labor Tables'
		, @ControlPanelOrder
		, 'sConsumptionLabor'
		, 'Control_Consumption_Labor_Default.xml'
		, 'Control_Consumption_Labor_Search.xml'
		, 'Control_Consumption_Labor_Edit.xml'
		, 'Control_Consumption_Labor_Tables_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID)
		, NULL)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04622', GetDate())
GO
