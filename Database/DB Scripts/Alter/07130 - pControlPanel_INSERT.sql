DECLARE @ControlPanelTypeID AS UNIQUEIDENTIFIER = (SELECT ControlPanelTypeID FROM pControlPanelType WHERE ControlPanelTypeName = 'Calendar')
DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Milestone Library')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID), 0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder), 0) + 1	FROM pControlPanel
	INSERT INTO pControlPanel (ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, ControlPanelSchema, ControlPanelEditSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelUrl, ControlPanelTypeID, IsDataValidation)
	VALUES (@ControlPanelID, 'Milestone Library', 'Milestone Library', @ControlPanelOrder, 'Control_MilestoneLibrary_Default.xml', 'Control_MilestoneLibrary_Edit.xml', 'Control_MilestoneLibrary_Search.xml', 'pMilestone', 'Control_MilestoneLibrary_List.aspx?CPID=' + CAST(@ControlPanelID AS NVARCHAR(5)), @ControlPanelTypeID, 0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07130', GetDate())
GO
