/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_INSERT]    Script Date: 19.03.2015 16:52:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_TempColors_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_TempColors_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_INSERT]    Script Date: 19.03.2015 16:52:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleBOM_TempColors_INSERT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@EnableOnlyLinePlannedColors BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @IsInserted INT = 0
	DECLARE @EnableStyleColor INT = 0

	IF @EnableOnlyLinePlannedColors IS NULL
		SET @EnableOnlyLinePlannedColors = 0
	
	-- Inserting the color to table of Temporary BOM Colors
	IF NOT EXISTS (SELECT * FROM pStyleBOMDimensionTempColor WHERE StyleBOMDimensionID = @StyleBOMDimensionID 
					AND ColorPaletteID = @ColorPaletteID AND TeamID = @TeamID)
	BEGIN
		INSERT INTO pStyleBOMDimensionTempColor (StyleBOMDimensionID, ColorPaletteID, TeamID)
		VALUES (@StyleBOMDimensionID, @ColorPaletteID, @TeamID)
		
		SET @IsInserted = 1
    END

	-- Checking if the color exists in the style's planning
	IF @EnableOnlyLinePlannedColors = 0
		SET @EnableStyleColor = 1
	ELSE IF EXISTS (SELECT 1 FROM pPlanning 
				INNER JOIN pPlanningItem ON pPlanningItem.PlanningID = pPlanning.PlanningID 
				INNER JOIN pPlanningColor ON pPlanningColor.PlanningID = pPlanning.PlanningID
				INNER JOIN pColorPalette incolor ON incolor.ColorPaletteID = pPlanningColor.ColorPaletteID
				INNER JOIN pWorkFlowItem ON pWorkflowItem.StyleSeasonYearID = pPlanningItem.StyleSeasonYearID
				INNER JOIN pStyleBOMDimension dim ON dim.WorkFlowItemID = pWorkflowItem.WorkFlowItemID
				INNER JOIN pColorPalette outcolor ON ISNULL(incolor.ColorName, '') = ISNULL(outcolor.ColorName, '')
					AND ISNULL(incolor.ColorCode, '') = ISNULL(outcolor.ColorCode, '') 
				WHERE dim.StyleBOMDimensionID = @StyleBOMDimensionID AND outcolor.ColorPaletteID = @ColorPaletteID
				)
		SET @EnableStyleColor = 1
	ELSE
		SET @EnableStyleColor = 0
    
    -- Selecting the inserted color info from pColorPalette
    SELECT ColorCode, ColorName, ColorSource, ColorFolderID, ColorPaletteID, @IsInserted AS WasInserted, @EnableStyleColor AS EnableStyleColor
    FROM pColorPalette
    WHERE ColorPaletteID = @ColorPaletteID
    
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10206', GetUTCDate())
GO
