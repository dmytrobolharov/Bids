IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningColor_DELETE]
	@PlanningID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER
AS
BEGIN

	DELETE FROM pPlanningColor WHERE PlanningID = @PlanningID AND ColorPaletteID = @ColorPaletteID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06336', GetDate())
GO
