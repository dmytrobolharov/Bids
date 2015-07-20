IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteVariationAvailableSeasonal_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteVariationAvailableSeasonal_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[spx_StyleQuoteVariationAvailableSeasonal_SELECT]  
(  
 @TradePartnerID uniqueidentifier,  
 @StyleDevelopmentId uniqueidentifier,  
 @StyleQuoteID uniqueidentifier,  
 @SeasonYearID uniqueidentifier  
)  
AS   
  
SELECT pStyleHeader.StyleID, pStyleHeader.StyleMasterID, pStyleHeader.StyleNo, pStyleHeader.SizeClass, pStyleHeader.SizeRange,   
      pStyleHeader.Description, pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, pStyleDevelopmentItem.Variation,   
      pStyleDevelopmentItem.StyleDevelopmentID, pStyleSeasonYear.StyleSeasonYearID, pStyleSeasonYear.SeasonYearID  
FROM  pStyleHeader INNER JOIN  
      pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID INNER JOIN  
      pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID  
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND  
 (pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentId) AND   
 (pStyleHeader.StyleID NOT IN (SELECT StyleID FROM pStyleQuoteVariation   
 WHERE StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID AND TradePartnerID = @TradePartnerID))  
 AND pStyleSeasonYear.SeasonYearID =   @SeasonYearID   
ORDER BY pStyleDevelopmentItem.Variation, pStyleHeader.SizeClass ASC  

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02312'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02312', GetDate())
END	
GO