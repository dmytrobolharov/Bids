/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_SELECT]    Script Date: 19.03.2015 15:40:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_TempColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_TempColors_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_SELECT]    Script Date: 19.03.2015 15:40:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOM_TempColors_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@EnableOnlyLinePlannedColors BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @EnableOnlyLinePlannedColors IS NULL
		SET @EnableOnlyLinePlannedColors = 0

	IF @EnableOnlyLinePlannedColors = 0
	BEGIN
		SELECT color.ColorName, color.ColorCode, color.ColorSource, color.ColorPaletteID, color.ColorFolderID, 1 AS EnableStyleColor
		FROM pColorPalette color
		INNER JOIN pStyleBOMDimensionTempColor dimtemp ON dimtemp.ColorPaletteID = color.ColorPaletteID
		WHERE dimtemp.TeamID = @TeamID AND dimtemp.StyleBOMDimensionID = @StyleBOMDimensionID
		ORDER BY color.ColorCode, color.ColorName
    END
	ELSE
	BEGIN
		SELECT color.ColorName, color.ColorCode, color.ColorSource, color.ColorPaletteID, color.ColorFolderID,
		EnableStyleColor = CASE WHEN EXISTS (
				SELECT 1 FROM pPlanning 
				INNER JOIN pPlanningItem ON pPlanningItem.PlanningID = pPlanning.PlanningID 
				INNER JOIN pPlanningColor ON pPlanningColor.PlanningID = pPlanning.PlanningID
				INNER JOIN pColorPalette incolor ON incolor.ColorPaletteID = pPlanningColor.ColorPaletteID
				INNER JOIN pWorkFlowItem ON pWorkflowItem.StyleSeasonYearID = pPlanningItem.StyleSeasonYearID 
				WHERE pWorkFlowItem.WorkFlowItemID = wfi.WorkFlowItemID
				AND ISNULL(incolor.ColorCode, '') = ISNULL(color.ColorCode, '') 
				AND ISNULL(incolor.ColorName, '') = ISNULL(color.ColorName, '')
				)
			THEN 1
			ELSE 0
		  END
		FROM pColorPalette color
		INNER JOIN pStyleBOMDimensionTempColor dimtemp ON dimtemp.ColorPaletteID = color.ColorPaletteID
		INNER JOIN pStyleBOMDimension dim ON dim.StyleBOMDimensionID = dimtemp.StyleBOMDimensionID
		INNER JOIN pWorkflowItem wfi ON wfi.WorkFlowItemID = dim.WorkFlowItemID
		WHERE dimtemp.TeamID = @TeamID AND dimtemp.StyleBOMDimensionID = @StyleBOMDimensionID
		ORDER BY color.ColorCode, color.ColorName
	END
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10207', GetUTCDate())
GO
