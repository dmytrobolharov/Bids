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
	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @MaterialID UNIQUEIDENTIFIER
	DECLARE @NewMaterialID UNIQUEIDENTIFIER

	SELECT @NewMaterialID = MaterialID FROM pPlanningMaterial WHERE PlanningMaterialID = @ReplacementMaterial
	SELECT @StyleBOMDimensionID = sb.StyleBOMDimensionId, @MaterialID = sb.StyleMaterialID FROM pStyleBOM sb
		INNER JOIN pPlanningMaterial pm ON sb.MaterialID = pm.MaterialID
		INNER JOIN pPlanningItem pli ON sb.StyleBOMDimensionId = pli.StyleBOMDimensionID AND pm.PlanningID = pli.PlanningID
	WHERE pli.PlanningItemID = @StyleToReplace AND pm.PlanningMaterialID = @MaterialToReplace

	EXEC spx_StyleDBOMMaterial_Replace_UPDATE @StyleBOMDimensionID, @MaterialID, @NewMaterialID, @MUser, @MDate, @TeamID, @ChangeTransPageName, @ChangeManagementEnabled

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07704', GetDate())
GO
