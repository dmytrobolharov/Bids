IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningMaterial_Drop_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningMaterial_Drop_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningMaterial_Drop_UPDATE] (
	@PlanningMaterialID UNIQUEIDENTIFIER
	, @DropStatus INT
	, @DropBy NVARCHAR(200)
	, @DropDate DATETIME
	)
AS
BEGIN
	UPDATE pPlanningMaterial SET
	PlanningMaterialDrop = @DropStatus
	, PlanningMaterialDropDate = @DropDate
	, PlanningMaterialDropUser = @DropBy
	WHERE PlanningMaterialID = @PlanningMaterialID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06610', GetDate())
GO
