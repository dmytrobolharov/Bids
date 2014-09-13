IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningMaterial_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningMaterial_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningMaterial_DELETE]
	@PlanningMaterialID UNIQUEIDENTIFIER
AS
BEGIN

	DELETE FROM pPlanningMaterial WHERE PlanningMaterialID = @PlanningMaterialID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06609', GetDate())
GO
