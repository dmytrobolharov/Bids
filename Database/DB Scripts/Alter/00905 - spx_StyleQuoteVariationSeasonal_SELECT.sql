
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleQuoteVariationSeasonal_SELECT')
   DROP PROCEDURE spx_StyleQuoteVariationSeasonal_SELECT
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteVariationSeasonal_SELECT]
(
@StyleID uniqueidentifier,
@StyleDevelopmentID uniqueidentifier,
@StyleQuoteID uniqueidentifier,
@StyleVariation varchar(3),
@SeasonYearID uniqueidentifier,
@TeamID uniqueidentifier = NULL 
)
AS 

SELECT pStyleHeader.StyleID, pStyleHeader.StyleMasterID, pStyleHeader.StyleNo, pStyleHeader.SizeClass, pStyleHeader.SizeRange, 
      pStyleHeader.Description, pStyleDevelopmentItem.Variation, pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, 
      pStyleDevelopmentItem.StyleDevelopmentID, pStyleQuoteVariation.StyleQuoteID, pStyleQuoteVariation.StyleQuoteVariationID, 
      pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleQuoteVariation.TradePartnerID, uTradePartner.CostingTypeID, 
      pStyleQuoteVariation.TeamComment, pStyleQuoteVariation.PartnerComment, pStyleQuoteVariation.PdfFileId, pStyleQuoteVariation.PdfUser, 
      pStyleQuoteVariation.PdfDate, pStyleSeasonYear.StyleSeasonYearID, pStyleSeasonYear.SeasonYearID
FROM  pStyleHeader INNER JOIN
      pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID INNER JOIN
      pStyleQuoteVariation ON pStyleHeader.StyleID = pStyleQuoteVariation.StyleID INNER JOIN
      uTradePartner ON pStyleQuoteVariation.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
      pStyleSeasonYear ON pStyleQuoteVariation.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND   
	(pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID) AND 
	(pStyleQuoteVariation.StyleQuoteID = @StyleQuoteID) AND 
    (pStyleHeader.StyleID = @StyleID)
	AND pStyleHeader.StyleType  IN  (SELECT StyleTypeId FROM sAccessQuotationFolder 
											WHERE  TeamID = @TeamID  AND (AccessRoleId = 3 OR AccessView = 1)  )
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '905', GetDate())
GO