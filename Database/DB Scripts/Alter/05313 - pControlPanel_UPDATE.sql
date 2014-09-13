Declare @ControlPanelOrder int
Declare @ControlPanelID int
Declare @ControlPanelTypeId uniqueidentifier

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

IF EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Division')
BEGIN
	SELECT @ControlPanelId = ControlPanelID FROM pControlPanel WHERE ControlPanelName = 'Division'
	UPDATE pControlPanel 
	SET 
		ControlPanelSchema = 'Control_Division_Default.xml',
		ControlPanelSearchSchema = 'Control_Division_Search.xml',
		ControlPanelEditSchema = 'Control_Division_Edit_Default.xml',
		ControlPanelUrl = 'Control_Division_List.aspx?CPID=' + CONVERT(VARCHAR(10), @ControlPanelId)
	WHERE ControlPanelID = @ControlPanelId
END
ELSE
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel

	INSERT INTO pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
			 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) VALUES
	(@ControlPanelID,'Division','Division',@ControlPanelOrder,'iCustom1','Control_Division_Default.xml',
			'Control_Division_Search.xml', 'Control_Division_Edit_Default.xml', 'Control_Division_List.aspx?CPID=' + convert(varchar(10),@ControlPanelID), @ControlPanelTypeId)
END


IF EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Style Category')
BEGIN
	SELECT @ControlPanelId = ControlPanelID FROM pControlPanel WHERE ControlPanelName = 'Style Category'
	UPDATE pControlPanel 
	SET 
		ControlPanelEditSchema = 'Control_StyleCategory_Edit_Default.xml',
		ControlPanelUrl = 'Control_StyleCategory_List.aspx?CPID=' + CONVERT(VARCHAR(10), @ControlPanelId)
	WHERE ControlPanelID = @ControlPanelId
END
ELSE
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel

	INSERT INTO pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
			 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) VALUES
	(@ControlPanelID,'Style Category','Style Category',@ControlPanelOrder,'pStyleCategory','Control_StyleCategory_Default.xml',
			'Control_StyleCategory_Search.xml', 'Control_StyleCategory_Edit_Default.xml', 'Control_StyleCategory_List.aspx?CPID=' + convert(varchar(10),@ControlPanelID), @ControlPanelTypeId)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05313', GetDate())
GO
