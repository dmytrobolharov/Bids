Declare @ControlPanelOrder int
Declare @ControlPanelID int
Declare @ControlPanelTypeId uniqueidentifier

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Country')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel

	INSERT INTO pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
			 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) VALUES
	(@ControlPanelID,'Country','Country',@ControlPanelOrder,'uCountry','Control_Country_Default.xml',
			'Control_Country_Search.xml', NULL, 'Control_Custom_List.aspx?CPID=' + convert(varchar(10),@ControlPanelID), @ControlPanelTypeId)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06237', GetDate())
GO
