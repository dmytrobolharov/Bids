DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = N'Predefined Tech Pack')
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
		, N'Predefined Tech Pack'
		, N'Predefined Tech Pack'
		, @ControlPanelOrder
		, NULL
		, N'Control_PredefinedTechPack_Default.xml'
		, N'Control_PredefinedTechPack_Search.xml'
		, N'rReportTechPackFolder'
		, N'Control_PredefinedTechPack_List.aspx?CPID=586'
		, N'Control_PredefinedTechPack_Edit.xml'
		, N'spx_Control_PredefinedTechPack_Logic_INSERT'
		, NULL
		, @ControlPanelTypeId
		, NEWID()
		, 0
		, NULL
		)	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08366', GetDate())
GO
