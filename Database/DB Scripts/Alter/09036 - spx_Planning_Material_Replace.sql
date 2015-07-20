IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Material_Replace]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Material_Replace]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Material_Replace]
(
	@MaterialToReplace UNIQUEIDENTIFIER
	, @StyleToReplace UNIQUEIDENTIFIER
	, @ReplacementMaterial UNIQUEIDENTIFIER
	, @MUser NVARCHAR(200)
	, @MDate DATETIME
	, @TeamID UNIQUEIDENTIFIER
	, @ChangeTransPageName NVARCHAR(200)
	, @ChangeManagementEnabled INT
)
AS
BEGIN
	
	DECLARE @tmpMaterialToReplace TABLE (RowNum INT IDENTITY(1, 1), StyleBOMDimensionID UNIQUEIDENTIFIER, MaterialID UNIQUEIDENTIFIER)
	DECLARE @NewMaterialID UNIQUEIDENTIFIER = (SELECT MaterialID FROM pPlanningMaterial WHERE PlanningMaterialID = @ReplacementMaterial)

	INSERT INTO @tmpMaterialToReplace
	SELECT sb.StyleBOMDimensionId, sb.StyleMaterialID
	FROM pStyleBOM sb INNER JOIN pPlanningItem pli ON sb.StyleBOMDimensionId = pli.StyleBOMDimensionID
	WHERE pli.PlanningItemID = @StyleToReplace AND sb.MaterialID = @MaterialToReplace

	DECLARE @RowCnt INT = (SELECT COUNT(*) FROM @tmpMaterialToReplace)
	DECLARE @Row INT = 1

	WHILE @Row <= @RowCnt
	BEGIN
		DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER
		DECLARE @StyleMaterialID UNIQUEIDENTIFIER

		SELECT @StyleBOMDimensionId = StyleBOMDimensionID, @StyleMaterialID = MaterialID FROM @tmpMaterialToReplace WHERE RowNum = @Row
		EXEC spx_StyleDBOMMaterial_Replace_UPDATE @StyleBOMDimensionID, @StyleMaterialID, @NewMaterialID, @MUser, @MDate, @TeamID, @ChangeTransPageName, @ChangeManagementEnabled

		SET @Row = @Row + 1
	END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09036', GetDate())
GO
