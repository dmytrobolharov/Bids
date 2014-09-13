/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_ByControlPanelName_SELECT]    Script Date: 06/05/2014 15:15:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlPanel_ByControlPanelName_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlPanel_ByControlPanelName_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_ByControlPanelName_SELECT]    Script Date: 06/05/2014 15:15:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ControlPanel_ByControlPanelName_SELECT]
(@ControlPanelName NVarChar(50),
 @TeamID uniqueidentifier = NULL)
AS 

IF @TeamID IS NULL
BEGIN

    SELECT * FROM pControlPanel 
    WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName) 
    ORDER BY ControlPanelOrder

END

ELSE
BEGIN

    SELECT * FROM pControlPanel INNER JOIN
    fnx_Permissions_GetIntProductTypePermissions(@TeamID, 10) access ON access.ProductTypeId = pControlPanel.ControlPanelID
    WHERE access.PermissionRoleId <> 0
    AND UPPER(ControlPanelName) = UPPER(@ControlPanelName) 
    ORDER BY ControlPanelOrder

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07903', GetDate())
GO
