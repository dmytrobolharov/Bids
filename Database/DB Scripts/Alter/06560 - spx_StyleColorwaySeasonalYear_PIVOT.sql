IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonalYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_PIVOT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_PIVOT](@StyleId uniqueidentifier, @SeasonYearID NVARCHAR(50)= NULL)    
AS  
-- select colorways added from Colorway bubble
SELECT     a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, a.StyleID, a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, 
                      a.StyleColorDelivery4, a.StyleColorStatus, b.StyleColorNo, b.StyleColorName, b.StyleColorID, a.Sort, a.Units
FROM         pStyleColorwaySeasonYear AS a INNER JOIN
                      pStyleColorway AS b ON a.StyleColorwayID = b.StyleColorID
                      INNER JOIN pStyleSeasonYear c ON a.StyleSeasonYearID = c.StyleSeasonYearID
WHERE     (c.SeasonYearID = @SeasonYearId and b.StyleID=@StyleId) 
UNION
-- select colorways added from DimBOM
SELECT     a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, a.StyleID, a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, 
                      a.StyleColorDelivery4, a.StyleColorStatus, b.ColorCode as StyleColorNo, b.ColorName as StyleColorName, NULL as StyleColorID, a.Sort, a.Units
FROM         pStyleColorwaySeasonYear AS a INNER JOIN
                      pColorPalette AS b ON a.ColorPaletteID = b.ColorPaletteID
                      INNER JOIN pStyleSeasonYear c ON a.StyleSeasonYearID = c.StyleSeasonYearID
WHERE     (c.SeasonYearID = @SeasonYearId and a.StyleID=@StyleId) AND a.ColorPaletteID IS NOT NULL
ORDER BY Sort, StyleColorNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06560', GetDate())
GO



