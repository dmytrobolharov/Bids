
DECLARE @CurrentPanelTypeID uniqueidentifier
DECLARE @SampleGCC_ControlPanelName varchar(100) = UPPER('Sample GCC Template')

SELECT @CurrentPanelTypeID = ControlPanelTypeID FROM pControlPanel WHERE ControlPanelName = @SampleGCC_ControlPanelName

-- If 'Sample GCC Template' control panel belongs to no existing folder, we set this folder to 'Validation tables', 
-- or NULL if there's no such folder
IF (SELECT COUNT(*) FROM pControlPanelType WHERE ControlPanelTypeID = @CurrentPanelTypeID) = 0
BEGIN

	DECLARE @ValidationControlPanelTypeID uniqueidentifier
	SELECT @ValidationControlPanelTypeID = ControlPanelTypeID from pControlPanelType WHERE UPPER(ControlPanelTypeName) = UPPER('Validation tables')

	UPDATE pControlPanel SET ControlPanelTypeID = @ValidationControlPanelTypeID WHERE ControlPanelName = @SampleGCC_ControlPanelName

END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03900', GetDate())
GO
