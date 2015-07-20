/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]    Script Date: 09/02/2011 17:44:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]    Script Date: 03/17/2010 01:27:59 ******/  
  
  
--  
-- Comments:  
--  
--  #01 - Ryan Cabanas - October 29, 2009  
--   Modified the select to show not only the color name, but also the  
--        color code.  
--  
  
/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColorAvaliable_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
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
Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01812'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01812', GetDate())
END	 
GO