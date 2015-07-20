IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingDropDownSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingDropDownSourcing_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingDropDownSourcing_SELECT] 
	@StyleID nvarchar(50),
	@StyleSeasonYearID nvarchar(50)
AS
BEGIN
	IF @StyleSeasonYearID IS NULL
	BEGIN
		SELECT tp.TradePartnerName + ' (' + tpv.VendorName + ')' as StyleSourcingName, ss.StyleSourcingID FROM pStyleSourcing ss
			INNER JOIN uTradePartner tp ON ss.TradePartnerID = tp.TradePartnerID
			INNER JOIN uTradePartnerVendor tpv ON ss.TradePartnerVendorID = tpv.TradePartnerVendorID
		WHERE ss.StyleID = @StyleID
			AND tp.TradePartnerType = 3 AND ss.Active = 1
		ORDER BY ss.CDate
	END
	ELSE
	BEGIN
		SELECT tp.TradePartnerName + ' (' + tpv.VendorName + ')' as StyleSourcingName, ss.StyleSourcingID FROM pStyleSourcing ss
			INNER JOIN uTradePartner tp ON ss.TradePartnerID = tp.TradePartnerID
			INNER JOIN uTradePartnerVendor tpv ON ss.TradePartnerVendorID = tpv.TradePartnerVendorID
		WHERE ss.StyleID = @StyleID
			AND ss.StyleSeasonYearID = @StyleSeasonYearID
			AND tp.TradePartnerType = 3 AND ss.Active = 1
		ORDER BY ss.CDate
	END

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02230'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02230', GetDate())
END
GO