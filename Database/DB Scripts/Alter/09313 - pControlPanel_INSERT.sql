DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Tech Packs')

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = N'Predefined Sample Tech Pack')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID), 0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder), 0) + 1 FROM pControlPanel

	INSERT INTO pControlPanel (
		ControlPanelID
		, ControlPanelName
		, ControlPanelDescription
		, ControlPanelOrder
		, ControlPanelIdSchema
		, ControlPanelSchema
		, ControlPanelSearchSchema
		, ControlPanelTableName
		, ControlPanelUrl
		, ControlPanelEditSchema
		, SPXLogicInsert
		, SPXLogicUpdate
		, ControlPanelTypeID
		, ControlPanelRepId
		, IsDataValidation
		, Sort
		)
	VALUES (
		@ControlPanelID
		, N'Predefined Sample Tech Pack'
		, N'Predefined Sample Tech Pack'
		, @ControlPanelOrder
		, NULL
		, N'Control_PredefinedSampleTechPack_Default.xml'
		, N'Control_PredefinedSampleTechPack_Search.xml'
		, N'rReportSampleRequestSubmitFolder'
		, N'Control_PredefinedSampleTechPack_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(5))
		, N'Control_PredefinedSampleTechPack_Edit.xml'
		, N'spx_Control_PredefinedSampleTechPack_Logic_INSERT'
		, NULL
		, @ControlPanelTypeId
		, NEWID()
		, 0
		, NULL
		)	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09313', GetDate())
GO
