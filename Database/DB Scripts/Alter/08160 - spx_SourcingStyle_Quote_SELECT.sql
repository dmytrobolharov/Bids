IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingStyle_Quote_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingStyle_Quote_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SourcingStyle_Quote_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT DISTINCT '<img src=''../System/Icons/' + dbo.pStyleQuoteItemStatus.CustomIcon + ''' />' AS ImagePath, 
	dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleQuoteItem.StyleID, dbo.pStyleQuoteItem.StyleQuoteItemNo, dbo.pStyleQuoteItem.StyleQuoteItemShare,
	dbo.pStyleQuoteItem.StyleQuoteItemStatusId, dbo.pStyleQuoteItem.StyleQuoteVariationId, dbo.pStyleQuoteItem.StyleQuoteID, dbo.pStyleQuoteItem.StyleQuotaDutyID, 
	dbo.pStyleQuoteItem.StyleDevelopmentID, dbo.pStyleQuoteItem.StyleQuoteTradePartnerID, dbo.pStyleQuoteItem.StyleCostingID, 
	dbo.pStyleQuoteItem.StyleCostingType, dbo.pStyleQuoteItem.StyleCostingFreightTypeID, dbo.pStyleQuoteItem.TradePartnerID, 
	dbo.pStyleQuoteItem.TradePartnerVendorID, dbo.pStyleQuoteItem.StyleQuoteItemCustomField1, dbo.pStyleQuoteItem.StyleQuoteItemCustomField2, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField3, dbo.pStyleQuoteItem.StyleQuoteItemCustomField4, dbo.pStyleQuoteItem.StyleQuoteItemCustomField5, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField6, dbo.pStyleQuoteItem.StyleQuoteItemCustomField8, dbo.pStyleQuoteItem.StyleQuoteItemCustomField9, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField10, dbo.pStyleQuoteItem.StyleQuoteItemCustomField11, dbo.pStyleQuoteItem.StyleQuoteItemCustomField12, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField13, dbo.pStyleQuoteItem.StyleQuoteItemCustomField14, dbo.pStyleQuoteItem.StyleQuoteItemCustomField15, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField16, dbo.pStyleQuoteItem.StyleQuoteItemCustomField17, dbo.pStyleQuoteItem.StyleQuoteItemCustomField18, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField19, dbo.pStyleQuoteItem.StyleQuoteItemCustomField7, dbo.pStyleQuoteItem.StyleQuoteItemCustomField20, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField21, dbo.pStyleQuoteItem.StyleQuoteItemCustomField22, dbo.pStyleQuoteItem.StyleQuoteItemCustomField23, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField24, dbo.pStyleQuoteItem.StyleQuoteItemCustomField25, dbo.pStyleQuoteItem.StyleQuoteItemCustomField26, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField27, dbo.pStyleQuoteItem.StyleQuoteItemCustomField28, dbo.pStyleQuoteItem.StyleQuoteItemCustomField29, 
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField30, dbo.pStyleQuoteItem.StyleCostingCustomField1, dbo.pStyleQuoteItem.StyleCostingCustomField2, 
	dbo.pStyleQuoteItem.StyleCostingCustomField3, dbo.pStyleQuoteItem.StyleCostingCustomField4, dbo.pStyleQuoteItem.StyleCostingCustomField5, 
	dbo.pStyleQuoteItem.StyleCostingCustomField6, dbo.pStyleQuoteItem.StyleCostingCustomField7, dbo.pStyleQuoteItem.StyleCostingCustomField8, 
	dbo.pStyleQuoteItem.StyleCostingCustomField9, dbo.pStyleQuoteItem.StyleCostingCustomField10, dbo.pStyleQuoteItem.StyleCostingCustomField11, 
	dbo.pStyleQuoteItem.StyleCostingCustomField12, dbo.pStyleQuoteItem.StyleCostingCustomField13, dbo.pStyleQuoteItem.StyleCostingCustomField14, 
	dbo.pStyleQuoteItem.StyleCostingCustomField15, dbo.pStyleQuoteItem.StyleCostingCustomField16, dbo.pStyleQuoteItem.StyleCostingCustomField17, 
	dbo.pStyleQuoteItem.StyleCostingCustomField18, dbo.pStyleQuoteItem.StyleCostingCustomField19, dbo.pStyleQuoteItem.StyleCostingCustomField20, 
	dbo.pStyleQuoteItem.StyleCostingCustomField21, dbo.pStyleQuoteItem.StyleCostingCustomField22, dbo.pStyleQuoteItem.StyleCostingCustomField23, 
	dbo.pStyleQuoteItem.StyleCostingCustomField24, dbo.pStyleQuoteItem.StyleCostingCustomField25, dbo.pStyleQuoteItem.StyleCostingCustomField26, 
	dbo.pStyleQuoteItem.StyleCostingCustomField27, dbo.pStyleQuoteItem.StyleCostingCustomField28, dbo.pStyleQuoteItem.StyleCostingCustomField29, 
	dbo.pStyleQuoteItem.StyleCostingCustomField30, dbo.pStyleQuoteItem.StyleCostingCustomField31, dbo.pStyleQuoteItem.StyleCostingCustomField32, 
	dbo.pStyleQuoteItem.StyleCostingCustomField33, dbo.pStyleQuoteItem.StyleCostingCustomField34, dbo.pStyleQuoteItem.StyleCostingCustomField35, 
	dbo.pStyleQuoteItem.StyleQuoteItem_EcomUnits, dbo.pStyleQuoteItem.StyleQuoteItem_EcomPriceUnit, 
	dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.SizeClass, dbo.pStyleCategory.StyleCategory, dbo.pStyleHeader.MaterialNo, 
	--dbo.pStyleQuoteItemFreightCost.Margin, dbo.pStyleQuoteItemFreightCost.TotalLandCost,
	dbo.pStyleHeader.Description, dbo.pStyleQuoteItem.StyleQuoteItemDueDate, dbo.pStyleQuoteItem.MDate, 
	dbo.pStyleQuoteItem.StyleColorID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pStyleQuoteItem.StyleSourcingID,  pStyleQuoteItem.SourcingHeaderID,
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField31, dbo.pStyleQuoteItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, 
	dbo.pStyleSeasonYear.StyleSeason + ' ' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear, 
	p.AgentId, p.AgentName, p.VendorID, p.VendorName, p.FactoryID, p.FactoryName,
	(SELECT SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingQuotationBOMDetails 
	 WHERE pSourcingQuotationBOMDetails.StyleQuoteItemID = pStyleQuoteItem.StyleQuoteItemID) as PartnerCost, 
	(
		(SELECT SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingQuotationBOMDetails 
		 WHERE pSourcingQuotationBOMDetails.StyleQuoteItemID = pStyleQuoteItem.StyleQuoteItemID) + 
		(ISNULL(StyleQuoteItemCustomField8, '0.00') + ISNULL(StyleQuoteItemCustomField10,'0.00') + 
		 ISNULL(StyleQuoteItemCustomField12,'0.00') + ISNULL(StyleQuoteItemCustomField13,'0.00')) + 
		 ISNULL((
			SELECT SUM(ISNULL(Amount,'0.00')) FROM pSourcingAdditionalCost 
			WHERE pSourcingAdditionalCost.QuoteItemID = pStyleQuoteItem.StyleQuoteItemID
		 ), '0.00')
	) as PartnerExtendedCost,
	ISNULL((
		SELECT SUM(ISNULL(Amount,'0.00')) FROM pSourcingAdditionalCost 
		WHERE pSourcingAdditionalCost.QuoteItemID = pStyleQuoteItem.StyleQuoteItemID
	), '0.00') as AdditionalCost,
	ISNULL(StyleDevelopmentName, 'Variation ' + CAST(Variation as nVARCHAR(5))) as VariationName, 
	dbo.pStyleQuoteItemStatus.Custom as StyleQuoteItemStatus, 
	CASE WHEN EXISTS (SELECT * FROM pStyleQuoteItemShare WHERE pStyleQuoteItemShare.StyleQouteItemID = pStyleQuoteItem.StyleQuoteItemID) THEN 'Yes' ELSE 'No' END as IsShared,
	CASE WHEN EXISTS (SELECT * FROM pSourcingCommitmentItem sci WHERE sci.StyleQuoteItemID = pStyleQuoteItem.StyleQuoteItemID) THEN 1 ELSE 0 END as HasCommitments
	INTO #tmpQuotes
	FROM pStyleQuoteItem
	INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = pStyleQuoteItem.StyleQuoteTradePartnerID AND pStyleQuoteItem.SourcingHeaderID = @SourcingHeaderID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
	INNER JOIN dbo.pSourcingStyle ON dbo.pStyleQuoteItem.StyleSourcingID = dbo.pSourcingStyle.SourcingStyleID
	INNER JOIN dbo.pStyleHeader ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID 
	LEFT OUTER JOIN dbo.pStyleDevelopmentItem ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleDevelopmentItem.StyleID 
	LEFT OUTER JOIN dbo.pStyleBOMDimension ON dbo.pStyleQuoteItem.StyleColorID = dbo.pStyleBOMDimension.StyleBOMDimensionID
	LEFT OUTER JOIN dbo.pWorkFlowItem ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pStyleBOMDimension.WorkFlowItemID
	LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleSeasonYear.StyleSeasonYearID = pStyleQuoteItem.StyleSeasonYearID --dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
	LEFT OUTER JOIN dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId
	LEFT OUTER JOIN dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey
	
	EXEC('SELECT * FROM #tmpQuotes ' + @SearchCond + ' order by StyleQuoteItemNo desc ' )
	
	DROP TABLE #tmpQuotes
   
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08160', GetDate())
GO
