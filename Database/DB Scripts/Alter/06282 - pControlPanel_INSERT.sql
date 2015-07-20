DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF NOT EXISTS (SELECT *	FROM pControlPanel WHERE ControlPanelName = 'Delivery')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID), 0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder), 0) + 1	FROM pControlPanel

	INSERT INTO pControlPanel (
		ControlPanelID
		, ControlPanelName
		, ControlPanelDescription
		, ControlPanelOrder
		, ControlPanelTableName
		, ControlPanelSchema
		, ControlPanelSearchSchema
		, ControlPanelEditSchema
		, ControlPanelUrl
		, ControlPanelTypeID
		)
	VALUES (
		@ControlPanelID
		, 'Delivery'
		, 'Delivery'
		, @ControlPanelOrder
		, 'pDelivery'
		, 'Control_Delivery_Default.xml'
		, 'Control_Delivery_Search.xml'
		, 'Control_Delivery_Edit.xml'
		, 'Control_Delivery_List.aspx?CPID=' + convert(VARCHAR(10), @ControlPanelID)
		, @ControlPanelTypeId
		)
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06282', GetDate())
GO
