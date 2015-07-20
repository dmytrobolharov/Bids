IF NOT EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName='Active Actions')
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
	VALUES (@ControlPanelID, 'Active Actions', 'Active Actions', @ControlPanelOrder, 'Control_CalendarActiveActions_Default.xml', 'Control_CalendarActiveActions_Search.xml',
							'pTATaskWorkflow', 'Control_CalendarActiveActions_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(10)), NULL,
							@ControlPanelType, NEWID())
END
go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08477', GetDate())
GO
