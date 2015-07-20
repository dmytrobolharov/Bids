IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningMaterialSort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningMaterialSort_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningMaterialSort_UPDATE]
(
	@Sort INT
	, @PlanningMaterialID UNIQUEIDENTIFIER
)
AS
BEGIN
	UPDATE pPlanningMaterial SET Sort = @Sort WHERE PlanningMaterialID = @PlanningMaterialID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.1.0000', '09141', GetDate())
GO