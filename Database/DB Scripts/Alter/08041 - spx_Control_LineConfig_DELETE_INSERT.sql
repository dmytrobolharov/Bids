IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_LineConfig_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_LineConfig_DELETE_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_Control_LineConfig_DELETE_INSERT]
(@DivisionID UNIQUEIDENTIFIER)
AS
BEGIN

	CREATE TABLE #LineConfig (LineListConfigID UNIQUEIDENTIFIER, LineListConfigName NVARCHAR(200))
	INSERT INTO #LineConfig (LineListConfigID, LineListConfigName)
	SELECT '00000000-0000-0000-0000-000000000001', 'Enable Lock Checkbox' UNION
	SELECT '00000000-0000-0000-0000-000000000002', 'Default Value'
	
	INSERT INTO pControlLineConfig (DivisionID, LineListConfigID, LineListConfigName, PlanningLockColorPalette, PlanningLockMaterialPalette)
	SELECT @DivisionID, LineListConfigID, LineListConfigName, 1, 1 FROM #LineConfig
	WHERE LineListConfigID NOT IN (SELECT LineListConfigID FROM pControlLineConfig WHERE DivisionID = @DivisionID)
	
	DROP TABLE #LineConfig

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08041', GetDate())
GO
