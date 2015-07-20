IF OBJECT_ID(N'[dbo].[spx_QuoteView_QuoteItems_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_QuoteView_QuoteItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_QuoteView_QuoteItems_SELECT]
	@TeamID AS UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER = NULL,
	@SearchCond NVARCHAR(MAX) = '',
	@PartnerManagement INT = 1	
AS
BEGIN

	DECLARE @Query NVARCHAR(MAX)
	
	IF @PartnerManagement = 1
	BEGIN
		
		SELECT * 
		INTO #tmpPartners
		FROM vwx_TradePartnerRelationshipLevels_SEL
	
		SELECT StyleQuoteItemID, SUM(PartnerTotal) AS PartnerCost
		INTO #QuoteBOMDetails
		FROM pSourcingQuotationBOMDetails
		GROUP BY StyleQuoteItemID

		SELECT QuoteItemID, SUM(Amount) AS AdditionalCost
		INTO #AdditionalCost
		FROM pSourcingAdditionalCost
		GROUP BY QuoteItemID			
	
		SET @Query = 
		'SELECT DISTINCT ''<img src="../System/Icons/'' + dbo.pStyleQuoteItemStatus.CustomIcon + ''" />'' AS ImagePath
			, sqi.StyleQuoteItemID
			, sqi.StyleID
			, sqi.StyleQuoteItemNo
			, sqi.StyleQuoteItemShare
			, sqi.StyleQuoteItemStatusId
			, sqi.StyleQuoteVariationId
			, sqi.StyleQuoteID
			, sqi.StyleQuotaDutyID
			, sqi.StyleDevelopmentID
			, sqi.StyleQuoteTradePartnerID
			, sqi.StyleCostingID
			, sqi.StyleCostingType
			, sqi.StyleCostingFreightTypeID
			, sqi.TradePartnerID
			, sqi.TradePartnerVendorID
			, sqi.StyleQuoteItemCustomField1
			, sqi.StyleQuoteItemCustomField2
			, sqi.StyleQuoteItemCustomField3
			, sqi.StyleQuoteItemCustomField4
			, sqi.StyleQuoteItemCustomField5
			, sqi.StyleQuoteItemCustomField6
			, sqi.StyleQuoteItemCustomField8
			, sqi.StyleQuoteItemCustomField9
			, sqi.StyleQuoteItemCustomField10
			, sqi.StyleQuoteItemCustomField11
			, sqi.StyleQuoteItemCustomField12
			, sqi.StyleQuoteItemCustomField13
			, sqi.StyleQuoteItemCustomField14
			, sqi.StyleQuoteItemCustomField15
			, sqi.StyleQuoteItemCustomField16
			, sqi.StyleQuoteItemCustomField17
			, sqi.StyleQuoteItemCustomField18
			, sqi.StyleQuoteItemCustomField19
			, sqi.StyleQuoteItemCustomField7
			, sqi.StyleQuoteItemCustomField20
			, sqi.StyleQuoteItemCustomField21
			, sqi.StyleQuoteItemCustomField22
			, sqi.StyleQuoteItemCustomField23
			, sqi.StyleQuoteItemCustomField24
			, sqi.StyleQuoteItemCustomField25
			, sqi.StyleQuoteItemCustomField26
			, sqi.StyleQuoteItemCustomField27
			, sqi.StyleQuoteItemCustomField28
			, sqi.StyleQuoteItemCustomField29
			, sqi.StyleQuoteItemCustomField30
			, sqi.StyleCostingCustomField1
			, sqi.StyleCostingCustomField2
			, sqi.StyleCostingCustomField3
			, sqi.StyleCostingCustomField4
			, sqi.StyleCostingCustomField5
			, sqi.StyleCostingCustomField6
			, sqi.StyleCostingCustomField7
			, sqi.StyleCostingCustomField8
			, sqi.StyleCostingCustomField9
			, sqi.StyleCostingCustomField10
			, sqi.StyleCostingCustomField11
			, sqi.StyleCostingCustomField12
			, sqi.StyleCostingCustomField13
			, sqi.StyleCostingCustomField14
			, sqi.StyleCostingCustomField15
			, sqi.StyleCostingCustomField16
			, sqi.StyleCostingCustomField17
			, sqi.StyleCostingCustomField18
			, sqi.StyleCostingCustomField19
			, sqi.StyleCostingCustomField20
			, sqi.StyleCostingCustomField21
			, sqi.StyleCostingCustomField22
			, sqi.StyleCostingCustomField23
			, sqi.StyleCostingCustomField24
			, sqi.StyleCostingCustomField25
			, sqi.StyleCostingCustomField26
			, sqi.StyleCostingCustomField27
			, sqi.StyleCostingCustomField28
			, sqi.StyleCostingCustomField29
			, sqi.StyleCostingCustomField30
			, sqi.StyleCostingCustomField31
			, sqi.StyleCostingCustomField32
			, sqi.StyleCostingCustomField33
			, sqi.StyleCostingCustomField34
			, sqi.StyleCostingCustomField35
			, sh.StyleNo
			, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
			, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
			, dbo.pStyleCategory.StyleCategoryID
			, sh.DesignSketchID
			, sh.DesignSketchVersion
			, sh.DevelopmentID
			, dbo.pStyleCategory.StyleCategory
			, sh.MaterialNo
			, sh.Description
			, sqi.StyleQuoteItemDueDate
			, sqi.MDate
			, sqi.StyleColorID
			, dbo.pWorkFlowItem.WorkFlowItemName
			, sqi.StyleSourcingID
			, sqi.SourcingHeaderID
			, sqi.StyleQuoteItemCustomField31
			, sqi.StyleSeasonYearID
			, dbo.pStyleSeasonYear.SeasonYearID
			, dbo.pStyleSeasonYear.StyleSeason + '' '' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear
			, p.AgentID
			, p.AgentName
			, p.VendorID
			, p.VendorName
			, p.FactoryID
			, p.FactoryName
			, ISNULL(QuoteBOMDetails.PartnerCost, 0.00) AS PartnerCost
			, ISNULL(QuoteBOMDetails.PartnerCost, 0.00)
			+ ISNULL(sqi.StyleQuoteItemCustomField8, 0.00) 
			+ ISNULL(sqi.StyleQuoteItemCustomField10, 0.00) 
			+ ISNULL(sqi.StyleQuoteItemCustomField12, 0.00) 
			+ ISNULL(sqi.StyleQuoteItemCustomField13, 0.00) 
			+ ISNULL(AdditionalCost.AdditionalCost, 0.00) AS PartnerExtendedCost
			, ISNULL(AdditionalCost.AdditionalCost, 0.00) AS AdditionalCost
			, ISNULL(dbo.pStyleDevelopmentItem.StyleDevelopmentName, ''Variation '' + CAST(dbo.pStyleDevelopmentItem.Variation AS NVARCHAR(5))) AS VariationName
			, CASE WHEN qis.StyleQouteItemID IS NOT NULL THEN 1 ELSE 0 END AS IsShared
			, dbo.pSourcingHeader.SourcingName
			, dbo.pSourcingHeader.SourcingType						
		FROM pStyleQuoteItem AS sqi
		INNER JOIN dbo.pSourcingHeader ON dbo.pSourcingHeader.SourcingHeaderID = sqi.SourcingHeaderID
		INNER JOIN dbo.pSourcingTradePartner AS stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
		LEFT OUTER JOIN #tmpPartners AS p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
		INNER JOIN dbo.pSourcingStyle ON sqi.StyleSourcingID = dbo.pSourcingStyle.SourcingStyleID
		INNER JOIN dbo.pStyleHeader sh ON sqi.StyleID = sh.StyleID
		LEFT OUTER JOIN dbo.pStyleDevelopmentItem ON sqi.StyleID = dbo.pStyleDevelopmentItem.StyleID
		LEFT OUTER JOIN dbo.pStyleBOMDimension ON sqi.StyleColorID = dbo.pStyleBOMDimension.StyleBOMDimensionID
		LEFT OUTER JOIN dbo.pWorkFlowItem ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pStyleBOMDimension.WorkFlowItemID
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleSeasonYear.StyleSeasonYearID = sqi.StyleSeasonYearID
		LEFT OUTER JOIN dbo.pStyleCategory ON sh.StyleCategory = dbo.pStyleCategory.StyleCategoryId
		LEFT OUTER JOIN pStyleQuoteItemStatus ON sqi.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey
		LEFT OUTER JOIN pStyleQuoteItemShare qis ON sqi.StyleQuoteItemID = qis.StyleQouteItemID AND qis.TradePartnerID IN (p.AgentID, p.VendorID, p.FactoryID)
		LEFT OUTER JOIN #QuoteBOMDetails AS QuoteBOMDetails ON sqi.StyleQuoteItemID = QuoteBOMDetails.StyleQuoteItemID
		LEFT OUTER JOIN #AdditionalCost AS AdditionalCost ON sqi.StyleQuoteItemID = AdditionalCost.QuoteItemID
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeID = sh.StyleType
	    LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	    LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE (@TradePartnerID IS NULL OR @TradePartnerID IN (p.AgentID, p.VendorID, p.FactoryID))
			AND (access.PermissionRoleID = 3 OR access.PermissionView = 1)'
		SET @Query = @Query + ' ' + ISNULL(STUFF(@SearchCond, CHARINDEX('WHERE', @SearchCond), 5, 'AND'), '') + ' ORDER BY StyleQuoteItemNo DESC'
		
		exec sp_executesql @Query, 
			N'@TeamID UNIQUEIDENTIFIER, @TradePartnerID UNIQUEIDENTIFIER',
			@TeamID, @TradePartnerID
		
		DROP TABLE #AdditionalCost
		DROP TABLE #QuoteBOMDetails
		DROP TABLE #tmpPartners
		
	END
	ELSE
	BEGIN
		SET @Query = '
		SELECT * FROM vwx_Style_Quote_Default_SELECT
		WHERE StyleID IN (
			SELECT vsqt.StyleID FROM vwx_Style_QuoteTrade_Default_SELECT vsqt
			INNER JOIN pStyleHeader sh ON vsqt.StyleID = sh.StyleID
			INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeID = sh.StyleType
			WHERE (@TradePartnerID IS NULL OR vsqt.TradePartnerID = @TradePartnerID) 
				AND (access.PermissionRoleID = 3 OR access.PermissionView = 1))'
				
		SET @Query = @Query + ' ' + ISNULL(STUFF(@SearchCond, CHARINDEX('WHERE', @SearchCond), 5, 'AND'), '') + ' ORDER BY StyleQuoteItemNo DESC'
		
		exec sp_executesql @Query, 
			N'@TeamID UNIQUEIDENTIFIER, @TradePartnerID UNIQUEIDENTIFIER',
			@TeamID, @TradePartnerID
	END

	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09676', GetDate())
GO