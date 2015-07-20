IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColorSelected_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColorSelected_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColorSelected_SELECT](
@StyleID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER
)
AS


SELECT d.ColorPaletteID
	,d.ColorCode
	,d.ColorName + ' (' + d.ColorCode + ')' AS ColorName 
	,c.PLMCode
	,a.Sort
FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID
INNER JOIN pStyleColorway c ON c.StyleColorID  =  a.StyleColorwayID 
INNER JOIN pColorPalette d ON d.ColorPaletteID = c.ColorPaletteID 
WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID

UNION 

SELECT d.ColorPaletteID
	,d.ColorCode
	,d.ColorName + ' (' + d.ColorCode + ')' AS ColorName 
	,NULL as PLMCode
	,a.Sort
FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID
INNER JOIN pColorPalette d ON d.ColorPaletteID = a.ColorPaletteID 
INNER JOIN pStyleBOMDimensionItem sdi ON a.StyleID = sdi.StyleID
	AND (a.ColorPaletteID = sdi.ItemDim1Id AND sdi.ItemDim1Active = 1) OR (a.ColorPaletteID = sdi.ItemDim2Id AND sdi.ItemDim2Active = 1) OR (a.ColorPaletteID = sdi.ItemDim3Id AND sdi.ItemDim3Active = 1)
INNER JOIN pStyleBOMDimension dbom ON sdi.StyleBOMDimensionID = dbom.StyleBOMDimensionID
INNER JOIN pWorkFlowItem wi ON dbom.WorkFlowItemID = wi.WorkFlowItemID AND a.StyleSeasonYearID = wi.StyleSeasonYearID
WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID

ORDER BY Sort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06662', GetDate())
GO
