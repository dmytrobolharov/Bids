/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]    Script Date: 02/01/2013 15:48:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]    Script Date: 02/01/2013 15:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]
(

@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@StyleID uniqueidentifier,
@SourcingTradePartnerID uniqueidentifier,
@iCount int,
@MUser nvarchar(200),
@MDate datetime
)
AS 


Declare
@TradePartnerID uniqueidentifier,
@strNewId uniqueidentifier ,
@StyleBOMDimensionId uniqueidentifier,
@WorkflowItemID uniqueidentifier


set @strNewId = newid()

select @StyleBOMDimensionId=COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000') from pStyleQuoteItem WHERE StyleQuoteItemID = @QuoteItemID	

SELECT top 1 @WorkflowItemID = b.WorkFlowItemID from pStyleBOMDimension b where b.StyleBOMDimensionID = @StyleBOMDimensionId
         
SELECT @TradePartnerID = TradePartnerID from pSourcingTradePartner WITH (NOLOCK) WHERE SourcingTradePartnerID = @SourcingTradePartnerID
BEGIN
	BEGIN
		IF @iCount = 0 
			BEGIN
			UPDATE pStyleQuoteItem
			   SET 
				  StyleQuoteTradePartnerID = @SourcingTradePartnerID, 
				  TradePartnerID = @TradePartnerID, 
				  -- TradePartnerVendorID = @TradePartnerVendorID,
				  BOMOptionDefault = @WorkflowItemID,
				  MDate = @MDate, 
				  MUser = @MUser
				  WHERE StyleQuoteItemID = @QuoteItemID	
				  
			--Materials
			EXECUTE spx_SourcingQuote_StyleBOMMaterials_INSERT
			@QuoteItemID,
			@SourcingHeaderID,
			@SourcingStyleID,
			@StyleBOMDimensionId
			
			--Calculations
			  Execute spx_SourcingCostCalculations_Update
			  @SourcingHeaderID,
			  @QuoteItemID,
			  @MUser,
			  @MDate
			  
			INSERT INTO pStyleQuoteItemShare (
				StyleQouteItemID
				, TradePartnerID
				, MUser
				, MDate) 
			VALUES (
				@QuoteItemID
				, (SELECT COALESCE(AgentID, VendorID, FactoryID)
					FROM vwx_TradePartnerMgmt_SEL tpm
						INNER JOIN pSourcingTradePartner stp ON tpm.RelationshipLevelID = stp.TradePartnerLevelID
					WHERE stp.SourcingTradePartnerID = @SourcingTradePartnerID)
				, @MUser
				, @MDate)
			  
			END
				 
	ELSE
		BEGIN
			INSERT INTO pStyleQuoteItem
			(
			StyleQuoteItemID
			,TradePartnerId
		 -- ,TradePartnerVendorId
			,StyleQuoteTradePartnerID
			,StyleQuoteItemCustomField1
			,StyleID
			,StyleSeasonYearID
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
			,BOMOptionDefault
			)
			SELECT 
			@strNewId
			,@TradePartnerID --TradePartnerId
		 -- ,@TradePartnerVendorId
			,@SourcingTradePartnerID
			,StyleQuoteItemCustomField1
			,StyleID
			,StyleSeasonYearID
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
			,@WorkflowItemID
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
		
			
			INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           (
           [StyleQuoteItemID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingHeaderID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
            select
			@strNewId
			,[StyleBOMDimensionItemID]
           ,[SourcingHeaderID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid]
			from [pSourcingQuoteStyleBOM] where SourcingHeaderID = @SourcingHeaderID and StyleQuoteItemID = @QuoteItemID and
            StyleBOMDimensionId=@StyleBOMDimensionId
           
			INSERT INTO [dbo].[pSourcingQuotationBOMDetails]
           ([StyleQuoteItemID]
           ,[SourcingHeaderId]
           ,[StyleID]
           ,[styleset]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleBOMDimensionId]
           ,[StyleBOMDimensionItemId]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[Quantity]
           ,[Cost]
           ,[TotalCost]
           ,[PartnerCost]
           ,[PartnerTotal]
           ,[CUser]
           ,[MUser]
           ,[CDate]
           ,[MDate])
           select
           @strNewId		
			,[SourcingHeaderId]
           ,[StyleID]
           ,[styleset]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleBOMDimensionId]
           ,[StyleBOMDimensionItemId]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[Quantity]
           ,[Cost]
           ,[TotalCost]
           ,[PartnerCost]
           ,[PartnerTotal]
           ,@MUser
           ,@MUser
           ,@MDate
           ,@MDate
           from [pSourcingQuotationBOMDetails] where SourcingHeaderID = @SourcingHeaderID and StyleQuoteItemID = @QuoteItemID and
           StyleBOMDimensionId=@StyleBOMDimensionId
         
         --Materials
			EXECUTE spx_SourcingQuote_StyleBOMMaterials_INSERT
			@strNewId,
			@SourcingHeaderID,
			@SourcingStyleID,
			@StyleBOMDimensionId
			  
           --Calculations
		  Execute spx_SourcingCostCalculations_Update
		  @SourcingHeaderID,
		  @strNewId,
		  @MUser,
		  @MDate

		INSERT INTO pStyleQuoteItemShare (
			StyleQouteItemID
			, TradePartnerID
			, MUser
			, MDate) 
		VALUES (
			@strNewId
			, (SELECT COALESCE(AgentID, VendorID, FactoryID)
				FROM vwx_TradePartnerMgmt_SEL tpm
					INNER JOIN pSourcingTradePartner stp ON tpm.RelationshipLevelID = stp.TradePartnerLevelID
				WHERE stp.SourcingTradePartnerID = @SourcingTradePartnerID)
			, @MUser
			, @MDate)
           
		END	 
	END
	
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04957', GetDate())
GO