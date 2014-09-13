IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT](  
@StyleID UNIQUEIDENTIFIER,  
@SeasonYearID UNIQUEIDENTIFIER  
)  
AS  
  
 
SELECT b.ColorPaletteID  
 ,b.ColorCode  
 ,b.ColorName + ' (' + b.ColorCode + ')' AS ColorName  --Comment #01 
FROM pStyleColorway a  
INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID   
WHERE a.StyleID = @StyleID  
AND StyleColorID NOT IN (  
 SELECT StyleColorwayID   
 FROM pStyleColorwaySeasonYear a  
 INNER JOIN pStyleSeasonYear b ON  a.StyleSeasonYearID = b.StyleSeasonYearID  
 WHERE b.StyleID = @StyleID AND b.SeasonYearID = @SeasonYearID
)

/**  
** Colorways avaliable for a NON LinePlan style always going to be EMPTY !!!   
**/  
  
--SELECT ColorPaletteID, ColorCode, ColorName    
--FROM pColorPalette WHERE 1 = 2


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04117', GetDate())
GO

