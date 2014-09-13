DECLARE @ControlPanelTypeID AS UNIQUEIDENTIFIER = (SELECT ControlPanelTypeID FROM pControlPanelType WHERE ControlPanelTypeName = 'Calendar')
DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Task')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID), 0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder), 0) + 1	FROM pControlPanel
	INSERT INTO pControlPanel (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, ControlPanelSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelUrl, ControlPanelTypeID, IsDataValidation)
	VALUES (@ControlPanelID, 'Task', 'Task', @ControlPanelOrder, 'Control_CalendarTask_Default.xml', 'Control_CalendarTask_Search.xml', 'cCalendarTask', 'Control_Task_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(5)), @ControlPanelTypeID, 0)
END
GO

	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07098', GetDate())
GO
