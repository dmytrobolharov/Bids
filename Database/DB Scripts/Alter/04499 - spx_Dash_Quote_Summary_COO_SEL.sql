IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Dash_Quote_Summary_COO_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Dash_Quote_Summary_COO_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Dash_Quote_Summary_COO_SEL]
	@qStatus nvarchar(50),
	@SeasonYearID uniqueidentifier
AS
BEGIN
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
	
insert into #tmpQuoteItems
	select 
		c.CountryName
		, sqi.StyleID
		, sqi.StyleQuoteItemID
		, NULL
		, ISNULL(sqi.StyleCostingCustomField19,0)
		, ISNULL((sqi.StyleQuoteItemCustomField14 * sqi.StyleCostingCustomField19),0) AS Extended_FOB
		, ISNULL((sqi.StyleQuoteItemCustomField18 * sqi.StyleCostingCustomField19),0) AS Extended_LDP
		, ISNULL((sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField19),0) AS Extended_WHSE
		, (ISNULL((sqi.StyleQuoteItemCustomField2 * sqi.StyleCostingCustomField19),0) - ISNULL((sqi.StyleQuoteItemCustomField18 * sqi.StyleCostingCustomField19),0)) AS Extended_Gross_Margin -- Extended_WHSE - Extended_LDP
	FROM
		pStyleQuoteItem sqi
		INNER JOIN uTradePartner tp ON sqi.TradePartnerID = tp.TradePartnerID
		INNER JOIN uCountry c ON c.CountryCode=tp.Country
		LEFT JOIN pStyleSeasonYear ssy ON sqi.StyleSeasonYearID = ssy.StyleSeasonYearID
		LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
	WHERE
		sqi.StyleQuoteItemStatusId IN (select cast(value as int) value from fnx_Split(@qStatus,','))
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
VALUES     ('DB_Version', '5.0.0000', '04499', GetDate())
GO
