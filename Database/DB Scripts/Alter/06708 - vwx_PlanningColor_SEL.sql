IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningColor_SEL]'))
DROP VIEW [dbo].[vwx_PlanningColor_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningColor_SEL]
AS
WITH BOMColorsUsed AS (
	SELECT cp.ColorPaletteID, pli.PlanningID, ssy.SeasonYearID, 
		CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS UsedInBOM
	FROM pPlanningItem pli
	INNER JOIN pStyleBOMDimensionItem sbdi ON pli.StyleBOMDimensionID = sbdi.StyleBOMDimensionID
	INNER JOIN pColorPalette cp ON cp.ColorPaletteID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	WHERE (sbdi.ItemDim1Id IS NOT NULL AND sbdi.ItemDim1Active = 1)
		OR (sbdi.ItemDim2Id IS NOT NULL AND sbdi.ItemDim2Active = 1)
		OR (sbdi.ItemDim3Id IS NOT NULL AND sbdi.ItemDim3Active = 1)
	GROUP BY cp.ColorPaletteID, pli.PlanningID, ssy.SeasonYearID
), BOMMaterialColorsUsed AS (
	SELECT mc.ColorPaletteID, pli.PlanningID, ssy.SeasonYearID,
		CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS UsedInBOMMaterial
	FROM pPlanningItem pli
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleBOMItem sbi ON pli.StyleBOMDimensionID = sbi.StyleBOMDimensionID
	INNER JOIN pStyleBOMDimensionItem sbdi 
		INNER JOIN pColorPalette cp ON cp.ColorPaletteID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id) 
		ON sbi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID 
			AND (sbi.ItemDim1Id = sbdi.ItemDim1Id OR sbi.ItemDim2Id = sbdi.ItemDim2Id OR sbi.ItemDim3Id = sbdi.ItemDim3Id)
	INNER JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
	WHERE (sbdi.ItemDim1Id IS NOT NULL AND sbdi.ItemDim1Active = 1)
		OR (sbdi.ItemDim2Id IS NOT NULL AND sbdi.ItemDim2Active = 1)
		OR (sbdi.ItemDim3Id IS NOT NULL AND sbdi.ItemDim3Active = 1)
	GROUP BY mc.ColorPaletteID, pli.PlanningID, ssy.SeasonYearID)	
SELECT TOP (100) PERCENT dbo.pPlanningColor.PlanningColorID
	, dbo.pPlanningColor.PlanningID
	, dbo.pPlanningColor.CUser
	, dbo.pPlanningColor.CDate
	, dbo.pPlanningColor.MUser
	, dbo.pPlanningColor.MDate
	, dbo.pColorPalette.ColorPaletteID
	, dbo.pColorPalette.ColorFolderID
	, '<a href=''../Color/Color_Folder.aspx?CT=1&CFID=' + CAST(dbo.pColorPalette.ColorFolderID AS nVARCHAR(50)) + ''' target=''_blank''>' + dbo.pColorFolder.ColorFolderDescription + '</a>' AS ColorPalette	
	, '<a href=''../Color/Color_Folder.aspx?CT=1&CFID=' + CAST(dbo.pColorPalette.ColorFolderID AS nVARCHAR(50)) + '&CPID=' + CAST(dbo.pColorPalette.ColorPaletteID AS nVARCHAR(50)) + ''' target=''_blank''>' + dbo.pColorPalette.ColorCode + '</a>' AS ColorCode	
	, dbo.pColorPalette.ColorName
	, dbo.pColorPalette.ColorSource
	, dbo.pColorPalette.ColorNotes
	, dbo.pColorPalette.Hex
	, dbo.pColorPalette.ColorImage
	, dbo.pColorPalette.ColorImageType
	, dbo.pColorPalette.CopyColorPaletteID
	, dbo.pColorPalette.Active
	, dbo.pColorPalette.Sort
	, dbo.pColorFolder.ColorTypeID
	, dbo.pPlanningColor.PlanningColorDrop
	, dbo.pPlanningColor.PlanningColorDropUser
	, dbo.pPlanningColor.PlanningColorDropDate
	, '../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pPlanningColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pPlanningColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImageUrl
	, '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pPlanningColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(dbo.pPlanningColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath
	, dbo.pPlanningColor.SeasonYearID
	, dbo.pColorFolder.ColorFolderDescription
	, dbo.pColorType.ColorTypeDescription
	, (
		SELECT COUNT(*)
		FROM dbo.pStyleColorwaySeasonYear
		INNER JOIN dbo.pStyleSeasonYear ON dbo.pStyleColorwaySeasonYear.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
		WHERE dbo.pColorPalette.ColorPaletteID = dbo.pStyleColorwaySeasonYear.ColorPaletteID
			AND dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID
		) AS IsBOMUsed
	, ISNULL(bcu.UsedInBOM, 0) AS UsedInBOM
	, ISNULL(bmcu.UsedInBOMMaterial, 0) AS UsedInBOMMaterial
FROM dbo.pColorPalette
	INNER JOIN dbo.pPlanningColor ON dbo.pColorPalette.ColorPaletteID = dbo.pPlanningColor.ColorPaletteID
	LEFT JOIN BOMColorsUsed bcu ON dbo.pPlanningColor.ColorPaletteID = bcu.ColorPaletteID 
		AND dbo.pPlanningColor.PlanningID = bcu.PlanningID 
		AND dbo.pPlanningColor.SeasonYearID = bcu.SeasonYearID
	LEFT JOIN BOMMaterialColorsUsed bmcu ON dbo.pPlanningColor.ColorPaletteID = bmcu.ColorPaletteID 
		AND dbo.pPlanningColor.PlanningID = bmcu.PlanningID 
		AND dbo.pPlanningColor.SeasonYearID = bmcu.SeasonYearID
	INNER JOIN dbo.pColorFolder ON dbo.pColorPalette.ColorFolderID = dbo.pColorFolder.ColorFolderID
	LEFT JOIN dbo.pColorType ON dbo.pColorFolder.ColorTypeID = dbo.pColorType.ColorTypeID
ORDER BY dbo.pColorPalette.ColorName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06708', GetDate())
GO
