DECLARE @ControlPanelID INT, @ControlPanelOrder INT, @ControlPanelType UNIQUEIDENTIFIER

IF NOT EXISTS(SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName)='MATERIAL REQUEST TEMPLATE')
BEGIN

	SELECT @ControlPanelID = MAX(COALESCE(ControlPanelID, 0)) + 1, 
	@ControlPanelOrder = MAX(COALESCE(ControlPanelOrder, 0)) + 1
	FROM pControlPanel

	SELECT @ControlPanelType = ControlPanelTypeID FROM pControlPanelType
	WHERE UPPER(ControlPanelTypeName) = 'TEMPLATES'

	INSERT INTO pControlPanel (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder,
	ControlPanelSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelTypeId,
	ControlPanelUrl)
	VALUES (@ControlPanelID, 'Material Request Template', 'Material Request Template', @ControlPanelOrder, 
	'Material_RequestWorkflow_Default.xml', 'Material_RequestWorkflow_Search.xml', 'pMaterialRequestWorkflow', @ControlPanelType,
	'Control_MaterialRequestWorkflow_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(12)))
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04912', GetDate())
GO
