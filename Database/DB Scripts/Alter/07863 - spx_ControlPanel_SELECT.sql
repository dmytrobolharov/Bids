/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_SELECT]    Script Date: 06/04/2014 12:44:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlPanel_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlPanel_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_SELECT]    Script Date: 06/04/2014 12:44:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ControlPanel_SELECT]
(@ControlPanelID int = NULL,
@TeamID uniqueidentifier = NULL)
AS 

IF @TeamID IS NULL
BEGIN

    IF @ControlPanelID IS NULL
    BEGIN
	    SELECT * FROM pControlPanel 
	    ORDER BY ControlPanelOrder
    END

    ELSE
    BEGIN
	    SELECT * FROM pControlPanel 
        WHERE ControlPanelId = @ControlPanelID 
	    ORDER BY ControlPanelOrder
    END

END
ELSE
BEGIN

    IF @ControlPanelID IS NULL
    BEGIN
        SELECT * FROM pControlPanel 
        INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 10) access ON access.ProductTypeId = pControlPanel.ControlPanelID
        WHERE PermissionRoleId <> 0
        ORDER BY ControlPanelOrder
    END

    ELSE
    BEGIN
        SELECT * FROM pControlPanel
        INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 10) access ON access.ProductTypeId = pControlPanel.ControlPanelID
        WHERE PermissionRoleId <> 0
        AND ControlPanelId = @ControlPanelID 
        ORDER BY ControlPanelOrder
    END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07863', GetDate())
GO