/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteVariation_SELECT]    Script Date: 06/02/2014 13:45:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteVariation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteVariation_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteVariation_SELECT]    Script Date: 06/02/2014 13:45:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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

SELECT pStyleHeader.StyleID, pStyleHeader.StyleMasterID, pStyleHeader.StyleNo, pStyleHeader.SizeClass, pStyleHeader.SizeRange, 
    pStyleHeader.Description, pStyleDevelopmentItem.Variation, pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, 
    pStyleDevelopmentItem.StyleDevelopmentID, pStyleQuoteVariation.StyleQuoteID, pStyleQuoteVariation.StyleQuoteVariationID, 
    pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleQuoteVariation.TradePartnerID, uTradePartner.CostingTypeID, 
    pStyleQuoteVariation.TeamComment, pStyleQuoteVariation.PartnerComment, pStyleQuoteVariation.PdfFileId, 
    pStyleQuoteVariation.PdfUser, pStyleQuoteVariation.PdfDate
FROM   pStyleHeader WITH (NOLOCK) INNER JOIN
    pStyleDevelopmentItem WITH (NOLOCK) ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID INNER JOIN
    pStyleQuoteVariation WITH (NOLOCK) ON pStyleHeader.StyleID = pStyleQuoteVariation.StyleID INNER JOIN
    uTradePartner WITH (NOLOCK) ON pStyleQuoteVariation.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
    fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) quoteAccess ON quoteAccess.ProductTypeId = pStyleHeader.StyleType
WHERE     
	(pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID) AND 
	(pStyleQuoteVariation.StyleQuoteID = @StyleQuoteID) AND 
    (pStyleHeader.StyleID = @StyleID) AND
    (quoteAccess.PermissionRoleId = 3 OR PermissionRoleId = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07819', GetDate())
GO
