IF NOT EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName='Calendar Holidays')
BEGIN
	DECLARE @ControlPanelType UNIQUEIDENTIFIER
	SELECT @ControlPanelType = ControlPanelTypeID FROM pControlPanelType WHERE ControlPanelTypeName='Calendar'

	DECLARE @ControlPanelID INT
	SELECT @ControlPanelID = ISNULL(MAX(ControlPanelID), 0) + 1 FROM pControlPanel

	DECLARE @ControlPanelOrder INT
	SELECT @ControlPanelOrder = ISNULL(MAX(ControlPanelOrder), 0) + 1 FROM pControlPanel

	INSERT INTO pControlPanel (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, ControlPanelSchema, ControlPanelSearchSchema, 
								ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema, 
								ControlPanelTypeID, ControlPanelRepId)
	VALUES (@ControlPanelID, 'Calendar Holidays', 'Calendar Holidays', @ControlPanelOrder, 'Control_CalendarHolidays_Default.xml', 'Control_CalendarHolidays_Search.xml',
							'pTACalHolidays', 'Control_CalendarHolidays_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(10)), 'Control_CalendarHolidays_Edit.xml',
							@ControlPanelType, NEWID())
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08478', GetDate())
GO
