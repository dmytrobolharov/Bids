	DECLARE @ControlPanelID INT, @ControlPanelOrder INT, @ControlPanelType UNIQUEIDENTIFIER

IF NOT EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName='Style Remove Reason')
BEGIN

	SELECT @ControlPanelID = MAX(COALESCE(ControlPanelID, 0)) + 1, 
	@ControlPanelOrder = MAX(COALESCE(ControlPanelOrder, 0)) + 1
	FROM pControlPanel

	SELECT @ControlPanelType = ControlPanelTypeID FROM pControlPanelType
	WHERE ControlPanelTypeName = 'Style Drop Downs'

	INSERT INTO pControlPanel (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder,
	ControlPanelSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelTypeId,
	ControlPanelUrl)
	VALUES (@ControlPanelID, N'Style Remove Reason', N'Style Remove Reason', @ControlPanelOrder, N'Control_Custom_StyleRemoveReason_Default.xml',
	 N'Control_Custom_StyleRemoveReason_Search.xml', N'pStyleRemovalReason', @ControlPanelType
	 , N'Control_StyleRemovalReason_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(12))
	  )
		
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04974', GetDate())
GO