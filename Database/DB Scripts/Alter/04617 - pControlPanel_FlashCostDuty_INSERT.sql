DECLARE @ControlPanelOrder INT
DECLARE @ControlPanelID INT
DECLARE @ControlPanelTypeId UNIQUEIDENTIFIER

-- Insert Flash Cost Duty
IF NOT EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName = 'Flash Cost Duty')
BEGIN
	SELECT @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1 FROM pControlPanel
	SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1 FROM pControlPanel WHERE ControlPanelTypeID = '09773e42-5ab8-e011-9f63-544c92f24f0d'
	IF @ControlPanelOrder = 1
		SELECT @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  FROM pControlPanel
	
	INSERT INTO pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
			 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) VALUES
	(@ControlPanelID,'Flash Cost Duty Table','Flash Cost Duty Table',@ControlPanelOrder,'pFlashCostDuty','Control_FlashCost_Duty_Default.xml',
			'Control_FlashCost_Duty_Search.xml', NULL, 'Control_FlashCostDuty_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), NULL)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04617', GetDate())
GO
