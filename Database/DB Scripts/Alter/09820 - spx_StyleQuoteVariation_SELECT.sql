IF OBJECT_ID(N'[dbo].[spx_StyleQuoteVariation_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteVariation_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteVariation_SELECT]
(
@StyleID uniqueidentifier,
@StyleDevelopmentID uniqueidentifier,
@StyleQuoteID uniqueidentifier,
@StyleVariation nvarchar(3),
@TeamID uniqueidentifier = NULL 
)
AS 

SELECT sh.StyleID, sh.StyleMasterID, sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sh.Description, pStyleDevelopmentItem.Variation, sh.DesignSketchID, sh.DesignSketchVersion, 
       pStyleDevelopmentItem.StyleDevelopmentID, pStyleQuoteVariation.StyleQuoteID, pStyleQuoteVariation.StyleQuoteVariationID, 
       pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleQuoteVariation.TradePartnerID, uTradePartner.CostingTypeID, 
       pStyleQuoteVariation.TeamComment, pStyleQuoteVariation.PartnerComment, pStyleQuoteVariation.PdfFileId, 
       pStyleQuoteVariation.PdfUser, pStyleQuoteVariation.PdfDate
FROM pStyleHeader sh WITH (NOLOCK) INNER JOIN
    pStyleDevelopmentItem WITH (NOLOCK) ON sh.StyleID = pStyleDevelopmentItem.StyleID INNER JOIN
    pStyleQuoteVariation WITH (NOLOCK) ON sh.StyleID = pStyleQuoteVariation.StyleID INNER JOIN
    uTradePartner WITH (NOLOCK) ON pStyleQuoteVariation.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
    fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) quoteAccess ON quoteAccess.ProductTypeId = sh.StyleType
    LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
    LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE     
	(pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID) AND 
	(pStyleQuoteVariation.StyleQuoteID = @StyleQuoteID) AND 
    (sh.StyleID = @StyleID) AND
    (quoteAccess.PermissionRoleId = 3 OR PermissionRoleId = 1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09820', GetDate())
GO
