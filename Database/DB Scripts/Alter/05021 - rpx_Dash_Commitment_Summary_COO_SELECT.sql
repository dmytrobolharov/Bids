IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Dash_Commitment_Summary_COO_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Dash_Commitment_Summary_COO_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Dash_Commitment_Summary_COO_SELECT]
	@qStatus nvarchar(50) = null,
	@SeasonYearID uniqueidentifier = null,
	@SourcingHeaderID uniqueidentifier = null
AS

BEGIN
	CREATE TABLE #tmpCommitmentItems
	(
		COO nvarchar(200),
		StyleID uniqueidentifier,
		StyleCommitmentItemID uniqueidentifier,
		Style_Colors int,
		Projected_Units decimal(18,4),
		Extended_FOB decimal(18,4),
		Extended_LDP decimal(18,4),
		Extended_WHSE decimal(18,4),
		Extended_Gross_Margin decimal(18,4)
	)
	
	CREATE TABLE #tmpCountryCommitment
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
	
IF @SourcingHeaderID IS NULL
BEGIN
	insert into #tmpCommitmentItems
		select 
			c.CountryName
			, sci.StyleID
			, sci.SourcingCommitmentItemID
			, NULL
			, ISNULL(sci.StyleQuoteItemCustomField16,0)
			, ISNULL((sci.StyleCostingCustomField6 * sci.StyleQuoteItemCustomField16),0) AS Extended_FOB
			, ISNULL(sci.StyleQuoteItemCustomField18,0) AS Extended_LDP
			, ISNULL((sci.StyleQuoteItemCustomField2 * sci.StyleCostingCustomField15),0) + ISNULL((sci.StyleQuoteItemCustomField6 * sci.StyleCostingCustomField16),0) AS Extended_WHSE
			, ((ISNULL((sci.StyleQuoteItemCustomField2 * sci.StyleCostingCustomField15),0) + ISNULL((sci.StyleQuoteItemCustomField6 * sci.StyleCostingCustomField16),0)) - ISNULL((sci.StyleQuoteItemCustomField18),0)) AS Extended_Gross_Margin -- Extended_WHSE - Extended_LDP
		FROM
			pSourcingCommitmentItem sci
			INNER JOIN uTradePartner tp ON sci.TradePartnerID = tp.TradePartnerID
			INNER JOIN uCountry c ON c.CountryCode=tp.Country
			LEFT JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			sci.StyleQuoteItemStatusId IN (select cast(value as int) value from fnx_Split(@qStatus,','))
			AND sy.SeasonYearID = @SeasonYearID
END
ELSE
BEGIN
	insert into #tmpCommitmentItems
		select 
			c.CountryName
			, sci.StyleID
			, sci.SourcingCommitmentItemID
			, NULL
			, ISNULL(sci.StyleQuoteItemCustomField16,0)
			, ISNULL((sci.StyleCostingCustomField6 * sci.StyleQuoteItemCustomField16),0) AS Extended_FOB
			, ISNULL(sci.StyleQuoteItemCustomField18,0) AS Extended_LDP
			, ISNULL((sci.StyleQuoteItemCustomField2 * sci.StyleCostingCustomField15),0) + ISNULL((sci.StyleQuoteItemCustomField6 * sci.StyleCostingCustomField16),0) AS Extended_WHSE
			, ((ISNULL((sci.StyleQuoteItemCustomField2 * sci.StyleCostingCustomField15),0) + ISNULL((sci.StyleQuoteItemCustomField6 * sci.StyleCostingCustomField16),0)) - ISNULL((sci.StyleQuoteItemCustomField18),0)) AS Extended_Gross_Margin -- Extended_WHSE - Extended_LDP
		FROM
			pSourcingCommitmentItem sci
			INNER JOIN uTradePartner tp ON sci.TradePartnerID = tp.TradePartnerID
			INNER JOIN uCountry c ON c.CountryCode=tp.Country
			LEFT JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
			LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			sci.SourcingHeaderID = @SourcingHeaderID
END

UPDATE #tmpCommitmentItems
SET Style_Colors = (
	select 
		COUNT(cp.ColorPaletteID)
	FROM
		pSourcingCommitmentBOM sqbom
		LEFT JOIN pColorPalette cp ON 
			(sqbom.ItemDim1Id = cp.ColorPaletteID AND sqbom.ItemDim1Active = 1) OR
			(sqbom.ItemDim2Id = cp.ColorPaletteID AND sqbom.ItemDim2Active = 1) OR
			(sqbom.ItemDim3Id = cp.ColorPaletteID AND sqbom.ItemDim3Active = 1)
	WHERE
		#tmpCommitmentItems.StyleCommitmentItemID = sqbom.SourcingCommitmentItemID
)

insert into #tmpCountryCommitment 
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
	#tmpCommitmentItems
GROUP BY 
	COO

UPDATE #tmpCountryCommitment
SET 
	Projected_Units_P = CASE WHEN (SELECT SUM(#tmpCommitmentItems.Projected_Units) FROM #tmpCommitmentItems) <> 0 THEN Projected_Units/(SELECT SUM(#tmpCommitmentItems.Projected_Units) FROM #tmpCommitmentItems) ELSE 0 END,
	Extended_WHSE_P = CASE WHEN (SELECT SUM(#tmpCommitmentItems.Extended_WHSE) FROM #tmpCommitmentItems) <> 0 THEN Extended_WHSE/(SELECT SUM(#tmpCommitmentItems.Extended_WHSE) FROM #tmpCommitmentItems) ELSE 0 END

select * from #tmpCountryCommitment

drop table #tmpCountryCommitment
drop table #tmpCommitmentItems

END	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05021', GetDate())
GO
