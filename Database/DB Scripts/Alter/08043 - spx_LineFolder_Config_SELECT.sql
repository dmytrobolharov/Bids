IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_Config_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_Config_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_Config_SELECT]
(@LineFolderID UNIQUEIDENTIFIER)
AS
BEGIN

	DECLARE @PlanningID UNIQUEIDENTIFIER
	SELECT @PlanningID = PlanningID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	IF @PlanningID IS NOT NULL
	BEGIN
		SELECT LineListConfigID, LineListConfigName, PlanningLockColorPalette, PlanningLockMaterialPalette 
		FROM pControlLineConfig
		WHERE DivisionID = (SELECT DivisionID FROM pLineFolder WHERE LineFolderID = @LineFolderID)
	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08043', GetDate())
GO
