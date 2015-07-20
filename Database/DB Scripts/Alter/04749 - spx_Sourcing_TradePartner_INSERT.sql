/****** Object:  StoredProcedure [dbo].[spx_Sourcing_TradePartner_INSERT]    Script Date: 01/10/2013 13:35:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_TradePartner_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_TradePartner_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_TradePartner_INSERT]    Script Date: 01/10/2013 13:35:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_TradePartner_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER,	
	@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL,
	@TradePartnerIDChain VARCHAR(MAX) = NULL /* separated by commas */
AS
BEGIN

	if @TradePartnerRelationshipLevelID IS NULL
	begin
		exec spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT
	end

	if @TradePartnerRelationshipLevelID IS NOT NULL
	begin
		DECLARE @ProductTypes NVARCHAR(400);
		SELECT @ProductTypes = COALESCE(@ProductTypes + ', ', '') + CategoryName 
		FROM vwx_VendorProduct_SEL
		WHERE TradePartnerId = @TradePartnerID
		ORDER BY CategoryName

		INSERT INTO pSourcingTradePartner(
			SourcingHeaderID, TradePartnerID, 
			ProductTypes, TradePartnerLevelID)
		VALUES(
			@SourcingHeaderID, @TradePartnerID, 
			@ProductTypes, @TradePartnerRelationshipLevelID)		
	end
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04749', GetDate())
GO
