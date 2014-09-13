IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_ColorReplace_Color_SEL]'))
DROP VIEW [dbo].[vwx_Planning_ColorReplace_Color_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_ColorReplace_Color_SEL]
AS

SELECT TOP 100 PERCENT PlanningID, SeasonYearID, cp.* FROM 
(
	SELECT DISTINCT pli.PlanningID, ssy.SeasonYearID, sc.ColorPaletteID
	FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleBOMDimensionItem sbdi ON pli.StyleBOMDimensionID = sbdi.StyleBOMDimensionItemID
		INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
	UNION
	SELECT DISTINCT vpc.PlanningID, vpc.SeasonYearID, vpc.ColorPaletteID
	FROM vwx_PlanningColor_SEL vpc
) color
	INNER JOIN pColorPalette cp ON color.ColorPaletteID = cp.ColorPaletteID
ORDER BY cp.Sort, cp.ColorCode, cp.ColorName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07850', GetDate())
GO