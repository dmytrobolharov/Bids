/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteVariationSeasonal_SELECT]    Script Date: 06/05/2014 15:30:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteVariationSeasonal_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteVariationSeasonal_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteVariationSeasonal_SELECT]    Script Date: 06/05/2014 15:30:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
      pStyleSeasonYear ON pStyleQuoteVariation.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
      fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = pStyleHeader.StyleType
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND   
	(pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID) AND 
	(pStyleQuoteVariation.StyleQuoteID = @StyleQuoteID) AND 
    (pStyleHeader.StyleID = @StyleID)
	AND access.PermissionRoleId <> 0

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07926', GetDate())
GO