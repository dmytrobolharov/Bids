IF OBJECT_ID(N'[dbo].[spx_StyleQuoteVariationSeasonal_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteVariationSeasonal_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteVariationSeasonal_SELECT]
(
@StyleID uniqueidentifier,
@StyleDevelopmentID uniqueidentifier,
@StyleQuoteID uniqueidentifier,
@StyleVariation nvarchar(3),
@SeasonYearID uniqueidentifier,
@TeamID uniqueidentifier = NULL 
)
AS 

SELECT sh.StyleID, sh.StyleMasterID, sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.Description, pStyleDevelopmentItem.Variation, 
	   sh.DesignSketchID, sh.DesignSketchVersion, pStyleDevelopmentItem.StyleDevelopmentID, pStyleQuoteVariation.StyleQuoteID, 
	   pStyleQuoteVariation.StyleQuoteVariationID, pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleQuoteVariation.TradePartnerID, 
	   uTradePartner.CostingTypeID, pStyleQuoteVariation.TeamComment, pStyleQuoteVariation.PartnerComment, 
	   pStyleQuoteVariation.PdfFileId, pStyleQuoteVariation.PdfUser, pStyleQuoteVariation.PdfDate, 
	   pStyleSeasonYear.StyleSeasonYearID, pStyleSeasonYear.SeasonYearID
FROM  pStyleHeader sh 
INNER JOIN pStyleDevelopmentItem ON sh.StyleID = pStyleDevelopmentItem.StyleID 
INNER JOIN pStyleQuoteVariation ON sh.StyleID = pStyleQuoteVariation.StyleID 
INNER JOIN uTradePartner ON pStyleQuoteVariation.TradePartnerID = uTradePartner.TradePartnerID 
INNER JOIN pStyleSeasonYear ON pStyleQuoteVariation.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID 
INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND   
	(pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID) AND 
	(pStyleQuoteVariation.StyleQuoteID = @StyleQuoteID) AND 
    (sh.StyleID = @StyleID)
	AND access.PermissionRoleId <> 0


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09822', GetDate())
GO
