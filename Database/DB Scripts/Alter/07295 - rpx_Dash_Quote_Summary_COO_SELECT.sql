IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Dash_Quote_Summary_COO_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Dash_Quote_Summary_COO_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Dash_Quote_Summary_COO_SELECT]
	@qStatus nvarchar(50) = null,
	@SeasonYearID uniqueidentifier = null,
	@SourcingHeaderID uniqueidentifier = null
AS

--Due to schema change, I have updated this stored procedures references to StyleCostingCustomField19 to StyleQuoteItemCustomField16.  Robbie Pannell 11/30/2012

BEGIN

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	CREATE TABLE #tmpQuoteItems
	(
		COO nvarchar(200),
		StyleID uniqueidentifier,
		StyleQuoteItemID uniqueidentifier,
		Style_Colors int,
		Projected_Units decimal(18,4),
		Extended_FOB decimal(18,4),
		Extended_LDP decimal(18,4),
		Extended_WHSE decimal(18,4),
		Extended_Gross_Margin decimal(18,4)
	)
	
	CREATE TABLE #tmpCountryQuotes
	(
		COO nvarchar(200),
		Styles int,
		Style_Colors int,
		Projected_Units decimal(18,4),
		Extended_FOB decimal(18,4),
		Extended_LDP decimal(18,4),
		Extended_WHSE decimal(18,4),
		Extended_Gross_Margin decimal(18,4),
		Extended_Gross_P decimal(18,4),
		Projected_Units_P decimal(18,4),
		Extended_WHSE_P decimal(18,4)
	)

IF @SourcingHeaderID IS NULL   -- we use report in Sourcing folder
BEGIN	
	insert into #tmpQuoteItems
		select 
			c.CountryName
			, sqi.StyleID
			, sqi.StyleQuoteItemID
			, NULL
			, ISNULL(sqi.StyleQuoteItemCustomField16,0)
			, ISNULL((sqi.StyleCostingCustomField6 * sqi.StyleQuoteItemCustomField16),0) AS Extended_FOB
	--		, ISNULL((sqi.StyleQuoteItemCustomField18 * sqi.StyleQuoteItemCustomField16),0) AS Extended_LDP
			, ISNULL(sqi.StyleQuoteItemCustomField18,0) AS Extended_LDP
			, ISNULL((sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField15),0) + ISNULL((sqi.StyleQuoteItemCustomField6 * sqi.StyleCostingCustomField16),0) AS Extended_WHSE
			, ((ISNULL((sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField15),0) + ISNULL((sqi.StyleQuoteItemCustomField6 * sqi.StyleCostingCustomField16),0)) - ISNULL((sqi.StyleQuoteItemCustomField18),0)) AS Extended_Gross_Margin -- Extended_WHSE - Extended_LDP
		FROM
			pStyleQuoteItem sqi
			INNER JOIN uTradePartner tp ON sqi.TradePartnerID = tp.TradePartnerID
			INNER JOIN uCountry c ON c.CountryCode=tp.Country
			LEFT JOIN pStyleSeasonYear ssy ON sqi.StyleSeasonYearID = ssy.StyleSeasonYearID
			LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			sqi.StyleQuoteItemStatusId IN (select cast(value as int) value from fnx_Split(@qStatus,','))
			AND sy.SeasonYearID = @SeasonYearID
END
ELSE    -- we use report from BI
BEGIN
	insert into #tmpQuoteItems
		select 
			c.CountryName
			, sqi.StyleID
			, sqi.StyleQuoteItemID
			, NULL
			, ISNULL(sqi.StyleQuoteItemCustomField16,0)
			, ISNULL((sqi.StyleCostingCustomField6 * sqi.StyleQuoteItemCustomField16),0) AS Extended_FOB
	--		, ISNULL((sqi.StyleQuoteItemCustomField18 * sqi.StyleQuoteItemCustomField16),0) AS Extended_LDP
			, ISNULL(sqi.StyleQuoteItemCustomField18,0) AS Extended_LDP
			, ISNULL((sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField15),0) + ISNULL((sqi.StyleQuoteItemCustomField6 * sqi.StyleCostingCustomField16),0) AS Extended_WHSE
			, ((ISNULL((sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField15),0) + ISNULL((sqi.StyleQuoteItemCustomField6 * sqi.StyleCostingCustomField16),0)) - ISNULL((sqi.StyleQuoteItemCustomField18),0)) AS Extended_Gross_Margin -- Extended_WHSE - Extended_LDP
		FROM
			pStyleQuoteItem sqi
			INNER JOIN uTradePartner tp ON sqi.TradePartnerID = tp.TradePartnerID
			INNER JOIN uCountry c ON c.CountryCode=tp.Country
			LEFT JOIN pStyleSeasonYear ssy ON sqi.StyleSeasonYearID = ssy.StyleSeasonYearID
			LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			sqi.SourcingHeaderID = @SourcingHeaderID
END

UPDATE #tmpQuoteItems
SET Style_Colors = (
	select 
		COUNT(sc.StyleColorID)
	FROM
		pSourcingQuoteStyleBOM sqbom
		LEFT JOIN pStyleColorway sc ON 
			(sqbom.ItemDim1Id = sc.StyleColorID AND sqbom.ItemDim1Active = 1) OR
			(sqbom.ItemDim2Id = sc.StyleColorID AND sqbom.ItemDim2Active = 1) OR
			(sqbom.ItemDim3Id = sc.StyleColorID AND sqbom.ItemDim3Active = 1)
	WHERE
		#tmpQuoteItems.StyleQuoteItemID = sqbom.StyleQuoteItemID
)

insert into #tmpCountryQuotes 
select
	COO
	, COUNT(DISTINCT(StyleID)) AS Styles
	, SUM(Style_Colors) as Style_Colors
	, SUM(Projected_Units) as Projected_Units
	, SUM(Extended_FOB) as Extended_FOB
	, SUM(Extended_LDP) as Extended_LDP
	, SUM(Extended_WHSE) as Extended_WHSE
	, SUM(Extended_Gross_Margin) as Extended_Gross_Margin
	, CASE WHEN SUM(Extended_WHSE) <> 0 THEN SUM(Extended_Gross_Margin)/SUM(Extended_WHSE) ELSE 0 END
	, NULL
	, NULL
from
	#tmpQuoteItems
GROUP BY 
	COO

UPDATE #tmpCountryQuotes
SET 
	Projected_Units_P = CASE WHEN (SELECT SUM(#tmpQuoteItems.Projected_Units) FROM #tmpQuoteItems) <> 0 THEN Projected_Units/(SELECT SUM(#tmpQuoteItems.Projected_Units) FROM #tmpQuoteItems) ELSE 0 END,
	Extended_WHSE_P = CASE WHEN (SELECT SUM(#tmpQuoteItems.Extended_WHSE) FROM #tmpQuoteItems) <> 0 THEN Extended_WHSE/(SELECT SUM(#tmpQuoteItems.Extended_WHSE) FROM #tmpQuoteItems) ELSE 0 END

select * from #tmpCountryQuotes

drop table #tmpCountryQuotes
drop table #tmpQuoteItems

END	

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07295', GetDate())
GO
