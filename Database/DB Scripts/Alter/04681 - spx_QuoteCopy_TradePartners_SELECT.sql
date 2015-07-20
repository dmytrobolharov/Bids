/****** Object:  StoredProcedure [dbo].[spx_QuoteCopy_TradePartners_SELECT]    Script Date: 12/24/2012 17:51:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_QuoteCopy_TradePartners_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_QuoteCopy_TradePartners_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_QuoteCopy_TradePartners_SELECT]    Script Date: 12/24/2012 17:51:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_QuoteCopy_TradePartners_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX)
AS
BEGIN
	DECLARE @SourcingHeaderID UNIQUEIDENTIFIER,
			@StyleID UNIQUEIDENTIFIER;
			
	SELECT @SourcingHeaderID = SourcingHeaderID, @StyleID = StyleID FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID	

    DECLARE @Partners as TABLE(
			TradePartnerID UNIQUEIDENTIFIER,
			SourcingTradePartnerID UNIQUEIDENTIFIER, 
			AgentID UNIQUEIDENTIFIER, 
			VendorID UNIQUEIDENTIFIER, 
			FactoryID UNIQUEIDENTIFIER, 
			Lvl INT,
			CountryCode VARCHAR(5),
			AgentName NVARCHAR(400),
			VendorName NVARCHAR(400),
			FactoryName NVARCHAR(400),
			AgentCountry NVARCHAR(400),
			VendorCountry NVARCHAR(400),
			FactoryCountry NVARCHAR(400),
			VendorCStatus NVARCHAR(400),
			FactoryCStatus NVARCHAR(400)			
		)

	INSERT INTO @Partners
	EXECUTE spx_SourcingTradePartner_SELECT @SourcingHeaderID, @SearchCond
	
	SELECT p.*, 
	tpa.TradePartnerCode as AgentCode, tpv.TradePartnerCode as VendorCode, tpf.TradePartnerCode as FactoryCode,
	tpa.Active as AgentActive, tpv.Active as VendorActive, tpf.Active as FactoryActive,
	stuff ((SELECT DISTINCT ', ' + sc.StyleCategory
			FROM uTradePartnerProductType tppt INNER JOIN pStyleCategory sc ON tppt.StyleCategoryId = sc.StyleCategoryId
			WHERE tppt.TradePartnerId = p.TradePartnerID FOR xml path('')), 1, 2, ''
	) as ProductType
	INTO #tmpPartners
	FROM @Partners p
	LEFT JOIN uTradePartner tpa ON p.AgentID = tpa.TradePartnerID
	LEFT JOIN uTradePartner tpv ON p.VendorID = tpv.TradePartnerID
	LEFT JOIN uTradePartner tpf ON p.FactoryID = tpf.TradePartnerID
	WHERE p.SourcingTradePartnerID NOT IN (
		SELECT StyleQuoteTradePartnerID FROM pStyleQuoteItem WHERE SourcingHeaderID = @SourcingHeaderID AND StyleID = @StyleID
	)
	
	EXEC('SELECT * FROM #tmpPartners ' + @SearchCond)
	
	DROP TABLE #tmpPartners
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04681', GetDate())
GO