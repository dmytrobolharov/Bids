Declare @ControlPanelOrder int
Declare @ControlPanelID int
Declare @ControlPanelTypeId uniqueidentifier

SELECT @ControlPanelTypeId = ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Calendar')

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE ControlPanelName = 'Milestone Templates')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel

	INSERT INTO pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
			 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) VALUES
	(@ControlPanelID,'Milestone Templates','Milestone Templates',@ControlPanelOrder,'pMilestoneTemplate','Control_MilestoneTemplate_Default.xml',
			'Control_MilestoneTemplate_Search.xml', 'Control_MilestoneTemplate_Edit.xml', 'Control_MilestoneTemplate_List.aspx?CPID=' + convert(varchar(10),@ControlPanelID), @ControlPanelTypeId)
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05451', GetDate())
GO
