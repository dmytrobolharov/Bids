-- Adding new control panel folder
DECLARE @ControlPanelTypeID UNIQUEIDENTIFIER = NULL

SELECT @ControlPanelTypeID = ControlPanelTypeID 
FROM pControlPanelType 
WHERE ControlPanelTypeName = 'Planning Folder'

IF @ControlPanelTypeID IS NULL
BEGIN

	DECLARE	@ControlPanelTypeSort nVARCHAR(4)

	SELECT @ControlPanelTypeID = NEWID(),
			@ControlPanelTypeSort = CAST((CAST(ISNULL(MAX(Sort), '0') AS NUMERIC) + 1) AS nVARCHAR(4))
	FROM pControlPanelType

	INSERT INTO pControlPanelType (ControlPanelTypeID, ControlPanelTypeName, ControlPanelTypeDescription, Active, Sort)
	VALUES(@ControlPanelTypeID, 'Planning Folder', 'Planning Folder', 1, @ControlPanelTypeSort)
END

-- Adding new control panel
DECLARE @ControlPanelID INT = NULL
SELECT @ControlPanelID = ControlPanelID FROM pControlPanel
WHERE ControlPanelName = 'Planning Type'

IF @ControlPanelID IS NULL
BEGIN

	DECLARE @ControlPanelSort INT = NULL

	SELECT @ControlPanelID = ISNULL(MAX(ControlPanelID), 0) + 1,
			@ControlPanelSort = ISNULL(MAX(ControlPanelOrder), 0) + 1
	FROM pControlPanel
	
	INSERT INTO pControlPanel(ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder,
	ControlPanelSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema,
	ControlPanelTypeID, ControlPanelRepId)
	VALUES (@ControlPanelID, 'Planning Type', 'Planning Type', @ControlPanelSort,
	'Control_PlanningType_Default.xml', 'Control_PlanningType_Search.xml', 'pPlanningType',
	'Control_PlanningType_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(10)), 'Control_PlanningType_Edit.xml',
	@ControlPanelTypeID, NEWID())
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07464', GetDate())
GO