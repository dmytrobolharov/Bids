
DECLARE @CurrentPanelTypeID varchar(50)
DECLARE @UOM_ControlPanelName varchar(50) = UPPER('UOM')

SELECT @CurrentPanelTypeID = ControlPanelTypeID FROM pControlPanel WHERE ControlPanelName = @UOM_ControlPanelName

-- If UOM control panel belongs to no existing folder, we set this folder to 'Validation tables', 
-- or NULL if there's no such folder
IF (SELECT COUNT(*) FROM pControlPanelType WHERE ControlPanelTypeID = @CurrentPanelTypeID) = 0
BEGIN

	DECLARE @ValidationControlPanelTypeID varchar(50)
	SELECT @ValidationControlPanelTypeID = ControlPanelTypeID from pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

	UPDATE pControlPanel SET ControlPanelTypeID = @ValidationControlPanelTypeID WHERE ControlPanelName = @UOM_ControlPanelName

END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03700', GetDate())
GO