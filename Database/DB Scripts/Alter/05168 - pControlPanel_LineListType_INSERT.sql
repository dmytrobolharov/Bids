-- Adding new control panel folder
DECLARE @ControlPanelTypeID UNIQUEIDENTIFIER = NULL

SELECT @ControlPanelTypeID = ControlPanelTypeID 
FROM pControlPanelType 
WHERE ControlPanelTypeName = 'Line List Folder'

IF @ControlPanelTypeID IS NULL
BEGIN

	DECLARE	@ControlPanelTypeSort VARCHAR(4)

	SELECT @ControlPanelTypeID = NEWID(),
			@ControlPanelTypeSort = CAST((CAST(ISNULL(MAX(Sort), '0') AS NUMERIC) + 1) AS VARCHAR(4))
	FROM pControlPanelType

	INSERT INTO pControlPanelType (ControlPanelTypeID, ControlPanelTypeName, ControlPanelTypeDescription, Active, Sort)
	VALUES(@ControlPanelTypeID, 'Line List Folder', 'Line List Folder', 1, @ControlPanelTypeSort)
END

-- Adding new control panel
DECLARE @ControlPanelID INT = NULL
SELECT @ControlPanelID = ControlPanelID FROM pControlPanel
WHERE ControlPanelName = 'Line List Type'

IF @ControlPanelID IS NULL
BEGIN

	DECLARE @ControlPanelSort INT = NULL

	SELECT @ControlPanelID = ISNULL(MAX(ControlPanelID), 0) + 1,
			@ControlPanelSort = ISNULL(MAX(ControlPanelOrder), 0) + 1
	FROM pControlPanel
	
	INSERT INTO pControlPanel(ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder,
	ControlPanelSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema,
	ControlPanelTypeID, ControlPanelRepId)
	VALUES (@ControlPanelID, 'Line List Type', 'Line List Type', @ControlPanelSort,
	'Control_LineListType_Default.xml', 'Control_LineListType_Search.xml', 'pLineListType',
	'Control_LineListType_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(10)), 'Control_LineListType_Edit.xml',
	@ControlPanelTypeID, NEWID())
	
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05168', GetDate())
GO
