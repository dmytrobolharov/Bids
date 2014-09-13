DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Color Class')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID), 0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder), 0) + 1 FROM pControlPanel

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
		, 'Color Class'
		, 'Color Class'
		, @ControlPanelOrder
		, 'pColorClass'
		, 'Control_ColorClass_Default.xml'
		, 'Control_ColorClass_Search.xml'
		, 'Control_ColorClass_Edit.xml'
		, 'Control_ColorClass_List.aspx?CPID=' + convert(VARCHAR(10), @ControlPanelID)
		, @ControlPanelTypeId
		)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07626', GetDate())
GO