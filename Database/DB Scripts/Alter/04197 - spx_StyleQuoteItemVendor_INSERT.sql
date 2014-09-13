IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemVendor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemVendor_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItemVendor_INSERT]
(

@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@StyleID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier,

@iCount int,
@MUser nvarchar(200),
@MDate datetime
)
AS 


Declare
@TradePartnerID uniqueidentifier,
@SourcingTradePartnerID uniqueidentifier
select @TradePartnerID = TradePartnerID, @SourcingTradePartnerID = SourcingTradePartnerID from vwx_Sourcing_AgentVendor_DEFAULT WITH (NOLOCK)
BEGIN
	BEGIN
		IF @iCount = 0 
		
			UPDATE pStyleQuoteItem
			   SET 
				  StyleQuoteTradePartnerID = @SourcingTradePartnerID, 
				  TradePartnerID = @TradePartnerID, 
				  TradePartnerVendorID = @TradePartnerVendorID,
				  MDate = @MDate, 
				  MUser = @MUser
				WHERE StyleQuoteItemID = @QuoteItemID		 
	ELSE
			INSERT INTO pStyleQuoteItem
			(
			TradePartnerId
			,TradePartnerVendorId
			,StyleQuoteTradePartnerID
			,StyleQuoteItemCustomField1
			,StyleID
			,StyleDevelopmentID
			,SourcingHeaderID
			,StyleSourcingID		
			,StyleColorID
			,StyleCostingType
			,StyleQuoteItemApprovedBy	
			,StyleQuoteItemApprovedDate
			,StyleCostingFreightTypeID
			,StyleQuoteItemCustomField2
			,StyleQuoteItemCustomField6
			,StyleQuoteItemCustomField3
			,StyleQuoteItemCustomField4
			,StyleQuoteItemCustomField5
			,StyleQuoteItemCustomField21
			,StyleQuoteItemCustomField7
			,StyleQuoteItemCustomField8
			,StyleQuoteItemCustomField9
			,StyleQuoteItemCustomField10
			,StyleQuoteItemCustomField11
			,StyleQuoteItemCustomField12
			,StyleQuoteItemCustomField13	
			,StyleQuoteItemCustomField16
			,StyleQuoteItemCustomField14
			,StyleQuoteItemShare
			,StyleQuoteItemStatusId
			,StyleQuoteItemDueDate
			,StyleQuoteItemCustomField15
			,StyleQuoteItemCustomField17
			,StyleQuoteItemCustomField18
			,StyleQuoteItemCustomField19
			,StyleQuoteItemCustomField20
			)
			SELECT 
			TradePartnerId
			,@TradePartnerVendorId
			,@SourcingTradePartnerID
			,StyleQuoteItemCustomField1
			,StyleID
			,StyleDevelopmentID
			,SourcingHeaderID
			,StyleSourcingID		
			,StyleColorID
			,StyleCostingType
			,StyleQuoteItemApprovedBy	
			,StyleQuoteItemApprovedDate
			,StyleCostingFreightTypeID
			,StyleQuoteItemCustomField2
			,StyleQuoteItemCustomField6
			,StyleQuoteItemCustomField3
			,StyleQuoteItemCustomField4
			,StyleQuoteItemCustomField5
			,StyleQuoteItemCustomField21
			,StyleQuoteItemCustomField7
			,StyleQuoteItemCustomField8
			,StyleQuoteItemCustomField9
			,StyleQuoteItemCustomField10
			,StyleQuoteItemCustomField11
			,StyleQuoteItemCustomField12
			,StyleQuoteItemCustomField13	
			,StyleQuoteItemCustomField16
			,StyleQuoteItemCustomField14
			,StyleQuoteItemShare
			,StyleQuoteItemStatusId
			,StyleQuoteItemDueDate
			,StyleQuoteItemCustomField15
			,StyleQuoteItemCustomField17
			,StyleQuoteItemCustomField18
			,StyleQuoteItemCustomField19
			,StyleQuoteItemCustomField20
			From pStyleQuoteItem WITH (NOLOCK) WHERE StyleQuoteItemID = @QuoteItemID 
			 
	END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04197', GetDate())
GO
