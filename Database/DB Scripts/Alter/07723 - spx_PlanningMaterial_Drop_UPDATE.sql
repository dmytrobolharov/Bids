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

	IF (NOT EXISTS (
		SELECT pli.*
		FROM pPlanningItem pli
			INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
			INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			INNER JOIN pPlanningMaterial pm ON pli.PlanningID = pm.PlanningID
				AND ssy.SeasonYearID = pm.SeasonYearID
				AND sb.MaterialID = pm.MaterialID
		WHERE pm.PlanningMaterialID = @PlanningMaterialID) AND @DropStatus = 1) OR @DropStatus = 0
		
		BEGIN
			UPDATE pPlanningMaterial SET
				PlanningMaterialDrop = @DropStatus
				, PlanningMaterialDropDate = @DropDate
				, PlanningMaterialDropUser = @DropBy
			WHERE PlanningMaterialID = @PlanningMaterialID
			
			SELECT 1
		END
	ELSE
		BEGIN
			SELECT 0
		END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07723', GetDate())
GO
