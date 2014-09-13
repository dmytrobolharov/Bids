/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartners_SELECT]    Script Date: 12/25/2012 18:24:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingTradePartners_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingTradePartners_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartners_SELECT]    Script Date: 12/25/2012 18:24:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingTradePartners_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = N''
AS
BEGIN
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
	
	EXEC('SELECT * FROM #tmpPartners ' + @SearchCond)
	
	DROP TABLE #tmpPartners
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04688', GetDate())
GO