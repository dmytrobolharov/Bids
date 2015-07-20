IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_Sourcing_QuoteItem_TradePartner_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @SourcingHeaderID UNIQUEIDENTIFIER,
			@SourcingTradePartnerID UNIQUEIDENTIFIER;
			
	SELECT @SourcingHeaderID = SourcingHeaderID, @SourcingTradePartnerID = StyleQuoteTradePartnerID 
	FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

	declare @SearchCond VARCHAR(100) = ' WHERE SourcingTradePartnerID = ''' + CAST(@SourcingTradePartnerID as VARCHAR(40)) + ''''

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

	SELECT * FROM @Partners
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04595', GetDate())
GO
