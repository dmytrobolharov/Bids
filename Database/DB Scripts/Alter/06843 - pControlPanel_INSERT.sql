DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF NOT EXISTS (SELECT *	FROM pControlPanel WHERE ControlPanelName = 'Sub Category')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID), 0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder), 0) + 1	FROM pControlPanel

	INSERT INTO pControlPanel (
		ControlPanelID
		, ControlPanelName
		, ControlPanelDescription
		, ControlPanelOrder
		, ControlPanelTableName
		, ControlPanelSchema
		, ControlPanelSearchSchema
		, ControlPanelEditSchema
		, ControlPanelUrl
		, ControlPanelTypeID
		)
	VALUES (
		@ControlPanelID
		, 'Sub Category'
		, 'Sub Category'
		, @ControlPanelOrder
		, 'pSubCategory'
		, 'Control_SubCategory_Default.xml'
		, 'Control_SubCategory_Search.xml'
		, NULL
		, 'Control_Custom_List.aspx?CPID=' + convert(VARCHAR(10), @ControlPanelID)
		, @ControlPanelTypeId
		)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06843', GetDate())
GO
