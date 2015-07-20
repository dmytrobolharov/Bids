DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Tech Packs')

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = N'Tech Pack Coverpage')
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
		, N'Tech Pack Coverpage'
		, N'Tech Pack Coverpage'
		, @ControlPanelOrder
		, NULL
		, N'Control_TechPackCoverpage_Default.xml'
		, N'Control_TechPackCoverpage_Search.xml'
		, N'pTechPackCoverpage'
		, N'Control_Custom_List.aspx?CPID=' + CAST(@ControlPanelID as nvarchar(20))
		, N'Control_TechPackCoverpage_Edit.xml'
		, NULL
		, NULL
		, @ControlPanelTypeId
		, NEWID()
		, 0
		, NULL
		)	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08874', GetDate())
GO
