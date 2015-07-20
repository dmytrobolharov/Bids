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
@SourcingTradePartnerID uniqueidentifier,
@strNewId uniqueidentifier 

set @strNewId = newid()
select @TradePartnerID = TradePartnerID, @SourcingTradePartnerID = SourcingTradePartnerID from vwx_Sourcing_AgentVendor_DEFAULT WITH (NOLOCK)
BEGIN
	BEGIN
		IF @iCount = 0 
			BEGIN
			UPDATE pStyleQuoteItem
			   SET 
				  StyleQuoteTradePartnerID = @SourcingTradePartnerID, 
				  TradePartnerID = @TradePartnerID, 
				  TradePartnerVendorID = @TradePartnerVendorID,
				  MDate = @MDate, 
				  MUser = @MUser
				  WHERE StyleQuoteItemID = @QuoteItemID	

				UPDATE pSourcingAdditionalCost
				   SET 
					  QuoteItemID = @QuoteItemID,
					  MDate = @MDate, 
					  MUser = @MUser
				 WHERE SourcingHeaderID = @SourcingHeaderID and SourcingStyleID = @SourcingStyleID and QuoteItemID = '00000000-0000-0000-0000-000000000000'
			END
				 
	ELSE
		BEGIN
			INSERT INTO pStyleQuoteItem
			(
			StyleQuoteItemID
			,TradePartnerId
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
			@strNewId
			,TradePartnerId
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
			
			INSERT INTO pSourcingAdditionalCost
			(
			QuoteItemID
			,SourcingHeaderID
			,SourcingStyleID
			,[Description]
			,Amount
			,CUser
			,CDate		
			,MUser
			,MDate

			)
			SELECT 
			@strNewId
			,SourcingHeaderID
			,SourcingStyleID
			,[Description]
			,Amount
			,CUser
			,CDate		
			,MUser
			,MDate
			From pSourcingAdditionalCost WITH (NOLOCK) WHERE SourcingHeaderID = @SourcingHeaderID and SourcingStyleID = @SourcingStyleID AND QuoteItemID = @QuoteItemID
		END	 
	END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04201', GetDate())
GO
