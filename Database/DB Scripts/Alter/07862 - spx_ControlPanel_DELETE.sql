/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_DELETE]    Script Date: 06/04/2014 17:03:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlPanel_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlPanel_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlPanel_DELETE]    Script Date: 06/04/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ControlPanel_DELETE] 
(@ControlPanelID int)
AS 

DELETE FROM pControlPanel
WHERE ControlPanelID = @ControlPanelID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07862', GetDate())
GO