IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT](  
@StyleID UNIQUEIDENTIFIER,  
@SeasonYearID UNIQUEIDENTIFIER  
)  
AS  
  
SELECT b.ColorPaletteID  
 ,b.ColorCode  
 ,b.ColorName + ' (' + b.ColorCode + ')' AS ColorName
 ,0 as SortOrder
FROM pStyleColorway a  
INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID   
WHERE a.StyleID = @StyleID  
AND StyleColorID NOT IN (  
 SELECT StyleColorwayID   
 FROM pStyleColorwaySeasonYear a  
 INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID  
 WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID
 AND StyleColorwayID IS NOT NULL -- colors from Colorway bubble
)

UNION

SELECT DISTINCT cp.ColorPaletteID
	,ColorCode 
	,ColorName + ' (' + ColorCode + ')' AS ColorName
	,1 as SortOrder
FROM pStyleBOMDimensionItem sdi
	INNER JOIN pColorPalette cp ON (ItemDim1Id = ColorPaletteID AND ItemDim1Active = 1) OR (ItemDim2Id = ColorPaletteID AND ItemDim2Active = 1) OR (ItemDim3Id = ColorPaletteID AND ItemDim3Active = 1)
	INNER JOIN pStyleBOMDimension dbom ON sdi.StyleBOMDimensionID = dbom.StyleBOMDimensionID
	INNER JOIN pWorkFlowItem wi ON dbom.WorkFlowItemID = wi.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID
WHERE sdi.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID
	AND cp.ColorPaletteID NOT IN (
		SELECT ColorPaletteID
		FROM pStyleColorwaySeasonYear a  
		INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID  
		WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID
		AND a.ColorPaletteID IS NOT NULL -- colorway from dim bom
	)
	AND cp.ColorPaletteID NOT IN (
		SELECT a.ColorPaletteID	FROM pStyleColorway a  
		WHERE a.StyleID = @StyleID -- not use the same colors as Colorway bubble
	)

ORDER BY SortOrder

/**  
** Colorways avaliable for a NON LinePlan style always going to be EMPTY !!!   
**/  
  
--SELECT ColorPaletteID, ColorCode, ColorName    
--FROM pColorPalette WHERE 1 = 2

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06661', GetDate())
GO
