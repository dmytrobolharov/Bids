IF OBJECT_ID(N'[dbo].[spx_TradePartner_Style_Commitment_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_TradePartner_Style_Commitment_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TradePartner_Style_Commitment_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT sta  tements.
	SET NOCOUNT ON;
	
	SELECT DISTINCT '<img src=''../System/Icons/' + dbo.pStyleQuoteItemStatus.CustomIcon + ''' />' AS ImagePath, dbo.pSourcingCommitmentItem.sourcingcommitmentItemid,
	dbo.pSourcingCommitmentItem.StyleQuoteItemID, dbo.pSourcingCommitmentItem.StyleID, dbo.pSourcingCommitmentItem.StyleCommitmentNo, dbo.pSourcingCommitmentItem.StyleQuoteItemShare,
	dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId, dbo.pSourcingCommitmentItem.StyleQuoteVariationId, dbo.pSourcingCommitmentItem.StyleQuoteID, dbo.pSourcingCommitmentItem.StyleQuotaDutyID, 
	dbo.pSourcingCommitmentItem.StyleDevelopmentID, dbo.pSourcingCommitmentItem.StyleQuoteTradePartnerID, dbo.pSourcingCommitmentItem.StyleCostingID, 
	dbo.pSourcingCommitmentItem.StyleCostingType, dbo.pSourcingCommitmentItem.StyleCostingFreightTypeID, dbo.pSourcingCommitmentItem.TradePartnerID, 
	dbo.pSourcingCommitmentItem.TradePartnerVendorID, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField1, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField2, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField3, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField4, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField5, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField6, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField8, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField9, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField10, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField11, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField12, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField13, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField14, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField15, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField16, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField17, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField18, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField19, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField7, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField20, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField21, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField22, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField23, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField24, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField25, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField26, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField27, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField28, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField29, 
	dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField30, dbo.pSourcingCommitmentItem.StyleCostingCustomField1, dbo.pSourcingCommitmentItem.StyleCostingCustomField2, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField3, dbo.pSourcingCommitmentItem.StyleCostingCustomField4, dbo.pSourcingCommitmentItem.StyleCostingCustomField5, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField6, dbo.pSourcingCommitmentItem.StyleCostingCustomField7, dbo.pSourcingCommitmentItem.StyleCostingCustomField8, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField9, dbo.pSourcingCommitmentItem.StyleCostingCustomField10, dbo.pSourcingCommitmentItem.StyleCostingCustomField11, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField12, dbo.pSourcingCommitmentItem.StyleCostingCustomField13, dbo.pSourcingCommitmentItem.StyleCostingCustomField14, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField15, dbo.pSourcingCommitmentItem.StyleCostingCustomField16, dbo.pSourcingCommitmentItem.StyleCostingCustomField17, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField18, dbo.pSourcingCommitmentItem.StyleCostingCustomField19, dbo.pSourcingCommitmentItem.StyleCostingCustomField20, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField21, dbo.pSourcingCommitmentItem.StyleCostingCustomField22, dbo.pSourcingCommitmentItem.StyleCostingCustomField23, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField24, dbo.pSourcingCommitmentItem.StyleCostingCustomField25, dbo.pSourcingCommitmentItem.StyleCostingCustomField26, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField27, dbo.pSourcingCommitmentItem.StyleCostingCustomField28, dbo.pSourcingCommitmentItem.StyleCostingCustomField29, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField30, dbo.pSourcingCommitmentItem.StyleCostingCustomField31, dbo.pSourcingCommitmentItem.StyleCostingCustomField32, 
	dbo.pSourcingCommitmentItem.StyleCostingCustomField33, dbo.pSourcingCommitmentItem.StyleCostingCustomField34, dbo.pSourcingCommitmentItem.StyleCostingCustomField35, 
	sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, dbo.pStyleCategory.StyleCategory, sh.MaterialNo, 
	--dbo.pStyleQuoteItemFreightCost.Margin, dbo.pStyleQuoteItemFreightCost.TotalLandCost,
	sh.Description, dbo.pStyleQuoteItem.StyleQuoteItemDueDate, dbo.pStyleQuoteItem.MDate, 
	dbo.pStyleQuoteItem.StyleColorID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pStyleQuoteItem.StyleSourcingID,  pStyleQuoteItem.SourcingHeaderID,
	dbo.pStyleQuoteItem.StyleQuoteItemCustomField31, dbo.pStyleQuoteItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, 
	dbo.pStyleSeasonYear.StyleSeason + ' ' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear, 
	p.AgentId, p.AgentName, p.VendorID, p.VendorName, p.FactoryID, p.FactoryName,
	(SELECT SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingCommitmentBOMDetails 
	 WHERE pSourcingCommitmentBOMDetails.SourcingCommitmentItemID = pSourcingCommitmentItem.SourcingCommitmentItemID) as PartnerCost, 
	(
		(SELECT SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingCommitmentBOMDetails 
		 WHERE pSourcingCommitmentBOMDetails.SourcingCommitmentItemID = pSourcingCommitmentItem.SourcingCommitmentItemID) + 
		(ISNULL(pSourcingCommitmentItem.StyleQuoteItemCustomField8, '0.00') + ISNULL(pSourcingCommitmentItem.StyleQuoteItemCustomField10,'0.00') + 
		 ISNULL(pSourcingCommitmentItem.StyleQuoteItemCustomField12,'0.00') + ISNULL(pSourcingCommitmentItem.StyleQuoteItemCustomField13,'0.00')) + 
		 ISNULL((
			SELECT SUM(ISNULL(Amount,'0.00')) FROM pSourcingCommitmentAdditionalCost 
			WHERE pSourcingCommitmentAdditionalCost.CommitmentItemID = pSourcingCommitmentItem.SourcingCommitmentItemID
		 ), '0.00')
	) as PartnerExtendedCost,
	ISNULL((
		SELECT SUM(ISNULL(Amount,'0.00')) FROM pSourcingCommitmentAdditionalCost 
		WHERE pSourcingCommitmentAdditionalCost.CommitmentItemID = pSourcingCommitmentItem.SourcingCommitmentItemID
	), '0.00') as AdditionalCost,
	ISNULL(StyleDevelopmentName, 'Variation ' + CAST(Variation as nVARCHAR(5))) as VariationName,
	dbo.pStyleQuoteItemStatus.Custom as StyleQuoteItemStatus
	INTO #tmpQuotes
	FROM pSourcingCommitmentItem 
	inner join pStyleQuoteItem on pSourcingCommitmentItem.StyleQuoteItemID = pStyleQuoteItem.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis ON pSourcingCommitmentItem.StyleQuoteItemID = qis.StyleQouteItemID AND qis.TradePartnerID = @TradePartnerID
	INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = pStyleQuoteItem.StyleQuoteTradePartnerID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
	INNER JOIN dbo.pSourcingStyle ON dbo.pStyleQuoteItem.StyleSourcingID = dbo.pSourcingStyle.SourcingStyleID
	INNER JOIN dbo.pStyleHeader sh ON dbo.pStyleQuoteItem.StyleID = sh.StyleID 
	LEFT OUTER JOIN dbo.pStyleDevelopmentItem ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleDevelopmentItem.StyleID 
	LEFT OUTER JOIN dbo.pStyleBOMDimension ON dbo.pStyleQuoteItem.StyleColorID = dbo.pStyleBOMDimension.StyleBOMDimensionID
	LEFT OUTER JOIN dbo.pWorkFlowItem ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pStyleBOMDimension.WorkFlowItemID
	LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleSeasonYear.StyleSeasonYearID = pStyleQuoteItem.StyleSeasonYearID --sh.StyleID = dbo.pStyleSeasonYear.StyleID
	LEFT OUTER JOIN dbo.pStyleCategory ON sh.StyleCategory = dbo.pStyleCategory.StyleCategoryId
	LEFT OUTER JOIN dbo.pStyleQuoteItemStatus ON dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey	
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE @TradePartnerID IN (p.AgentID, p.VendorID, p.FactoryID) AND pSourcingCommitmentItem.StyleQuoteItemStatusId<>2
	
	EXEC('SELECT * FROM #tmpQuotes ' + @SearchCond + ' order by StyleCommitmentNo desc ' )
	
	DROP TABLE #tmpQuotes
   
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09857', GetDate())
GO
