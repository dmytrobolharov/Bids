/****** Object:  StoredProcedure [dbo].[spx_Sourcing_TradePartner_INSERT]    Script Date: 10/07/2012 15:24:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_TradePartner_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_TradePartner_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_TradePartner_INSERT]    Script Date: 10/07/2012 15:24:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_TradePartner_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER,	
	@TradePartnerRelationshipID UNIQUEIDENTIFIER = NULL	
AS
BEGIN
	
	if NOT EXISTS (SELECT * FROM pSourcingTradePartner WHERE SourcingHeaderID = @SourcingHeaderID AND TradePartnerID = @TradePartnerID)
	begin
		DECLARE @ProductTypes NVARCHAR(400)
		SELECT @ProductTypes = COALESCE(@ProductTypes + ', ', '') + CategoryName 
		FROM vwx_VendorProduct_SEL
		WHERE TradePartnerId = @TradePartnerID
		ORDER BY CategoryName
	
		INSERT INTO pSourcingTradePartner(SourcingHeaderID, TradePartnerID, ProductTypes, TradePartnerLevelID)
		VALUES							 (@SourcingHeaderID, @TradePartnerID, @ProductTypes, @TradePartnerRelationshipID)
	end
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04131', GetDate())
GO
