DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Calendar')

IF NOT EXISTS (SELECT *	FROM pControlPanel WHERE ControlPanelName = 'Calendar Event')
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
		, 'Calendar Event'
		, 'Calendar Event'
		, @ControlPanelOrder
		, 'cCalendarEvent'
		, 'Control_CalendarEvent_Default.xml'
		, 'Control_CalendarEvent_Search.xml'
		, 'Control_CalendarEvent_Edit.xml'
		, 'Control_CalendarEvent_List.aspx?CPID=' + convert(VARCHAR(10), @ControlPanelID)
		, @ControlPanelTypeId
		)
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07043', GetDate())
GO
