IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Dash_Quote_Summary_TradePartner_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Dash_Quote_Summary_TradePartner_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_Dash_Quote_Summary_TradePartner_SEL]
	@qStatus nvarchar(50),
	@SeasonYearID uniqueidentifier,
	@COO nvarchar(MAX)
AS

BEGIN
	CREATE TABLE #tmpQuoteItems
	(
		TradePartnerName nvarchar(200),
		StyleID uniqueidentifier,
		StyleQuoteItemID uniqueidentifier,
		TradePartnerID uniqueidentifier,
		Style_Colors int,
		Projected_Units decimal(18,4),
		Extended_FOB decimal(18,4),
		Extended_LDP decimal(18,4),
		Extended_WHSE decimal(18,4),
		Extended_Gross_Margin decimal(18,4)
	)
	
	CREATE TABLE #tmpCountryQuotes
	(
		TradePartnerName nvarchar(200),
		TradePartnerID uniqueidentifier,
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
	
insert into #tmpQuoteItems
	select 
		tp.TradePartnerName
		, sqi.StyleID
		, sqi.StyleQuoteItemID
		, sqi.TradePartnerID
		, NULL
		, ISNULL(sqi.StyleQuoteItemCustomField16,0)
		, ISNULL((sqi.StyleCostingCustomField6 * sqi.StyleQuoteItemCustomField16),0) AS Extended_FOB
		, ISNULL(sqi.StyleQuoteItemCustomField18 * sqi.StyleQuoteItemCustomField16,0) AS Extended_LDP
		, ISNULL((sqi.StyleCostingCustomField15 * sqi.StyleQuoteItemCustomField2),0) AS Extended_WHSE
		, (ISNULL((sqi.StyleCostingCustomField15 * sqi.StyleQuoteItemCustomField2),0) - ISNULL((sqi.StyleQuoteItemCustomField18 * sqi.StyleQuoteItemCustomField16),0)) AS Extended_Gross_Margin -- Extended_WHSE - Extended_LDP
	FROM
		pStyleQuoteItem sqi
		INNER JOIN uTradePartner tp ON sqi.TradePartnerID = tp.TradePartnerID
		INNER JOIN uCountry c ON c.CountryCode=tp.Country
		LEFT JOIN pStyleSeasonYear ssy ON sqi.StyleSeasonYearID = ssy.StyleSeasonYearID
		LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
	WHERE
		sqi.StyleQuoteItemStatusId IN (select cast(value as int) value from fnx_Split(@qStatus,','))
		AND c.CountryCode IN (select cast(value as nvarchar(5)) value from fnx_Split(@COO,','))
		AND sy.SeasonYearID = @SeasonYearID


UPDATE #tmpQuoteItems
SET Style_Colors = (
	select 
		COUNT(cp.ColorPaletteID)
	FROM
		pSourcingQuoteStyleBOM sqbom
		LEFT JOIN pColorPalette cp ON 
			(sqbom.ItemDim1Id = cp.ColorPaletteID AND sqbom.ItemDim1Active = 1) OR
			(sqbom.ItemDim2Id = cp.ColorPaletteID AND sqbom.ItemDim2Active = 1) OR
			(sqbom.ItemDim3Id = cp.ColorPaletteID AND sqbom.ItemDim3Active = 1)
	WHERE
		#tmpQuoteItems.StyleQuoteItemID = sqbom.StyleQuoteItemID
)

insert into #tmpCountryQuotes 
select
	TradePartnerName
	, TradePartnerID
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
	TradePartnerID, TradePartnerName

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
VALUES ('DB_Version', '5.0.0000', '04641', GetDate())
GO
