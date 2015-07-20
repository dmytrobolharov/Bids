IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleQuoteVariationAvailableSeasonal_SELECT')
   DROP PROCEDURE spx_StyleQuoteVariationAvailableSeasonal_SELECT
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
	WHERE StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID))
ORDER BY pStyleDevelopmentItem.Variation, pStyleHeader.SizeClass ASC
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '903', GetDate())
GO


