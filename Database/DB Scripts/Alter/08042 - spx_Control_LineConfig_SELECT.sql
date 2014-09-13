IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_LineConfig_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_LineConfig_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Control_LineConfig_SELECT]
(@DivisionID UNIQUEIDENTIFIER)
AS
BEGIN

	SELECT LineListConfigID, LineListConfigName, PlanningLockColorPalette, PlanningLockMaterialPalette, 0 as IsHeader 
	FROM pControlLineConfig WHERE DivisionID = @DivisionID
	UNION
	SELECT '00000000-0000-0000-0000-000000000000', '', 1, 1, 1 as IsHeader
	ORDER BY IsHeader DESC

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08042', GetDate())
GO
