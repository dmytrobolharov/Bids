IF OBJECT_ID(N'[dbo].[spx_StyleQuoteVariationAvailableSeasonal_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteVariationAvailableSeasonal_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteVariationAvailableSeasonal_SELECT]  
(  
 @TradePartnerID uniqueidentifier,  
 @StyleDevelopmentId uniqueidentifier,  
 @StyleQuoteID uniqueidentifier,  
 @SeasonYearID uniqueidentifier  
)  
AS   
  
SELECT sh.StyleID, sh.StyleMasterID, sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,   sh.Description, sh.DesignSketchID, 
	   sh.DesignSketchVersion, pStyleDevelopmentItem.StyleDevelopmentName, pStyleDevelopmentItem.Variation,
       pStyleDevelopmentItem.StyleDevelopmentID, pStyleSeasonYear.StyleSeasonYearID, pStyleSeasonYear.SeasonYearID  
FROM pStyleHeader sh 
INNER JOIN pStyleDevelopmentItem ON sh.StyleID = pStyleDevelopmentItem.StyleID 
INNER JOIN pStyleSeasonYear ON sh.StyleID = pStyleSeasonYear.StyleID 
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND  
 (pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentId) AND   
 (sh.StyleID NOT IN (SELECT StyleID FROM pStyleQuoteVariation   
 WHERE StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID AND TradePartnerID = @TradePartnerID))  
 AND pStyleSeasonYear.SeasonYearID =   @SeasonYearID   
ORDER BY pStyleDevelopmentItem.Variation, sh.SizeClass ASC  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09821', GetDate())
GO
