/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]    Script Date: 08/08/2014 15:52:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT]    Script Date: 08/08/2014 15:52:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[spx_StyleQuoteItemSourcingTradePartner_INSERT](
	@QuoteItemID UNIQUEIDENTIFIER,
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SourcingStyleID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@SourcingTradePartnerID UNIQUEIDENTIFIER,
	@iCount INT,
	@IsShared INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@InsertedQuoteItemID UNIQUEIDENTIFIER = NULL OUTPUT
)
AS 


Declare
@TradePartnerID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@WorkflowItemID uniqueidentifier,

@StyleDevelopmentID UNIQUEIDENTIFIER,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
@TradePartnerID_toShare UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER

select @StyleBOMDimensionId=COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000'), @StyleDevelopmentID = StyleDevelopmentID from pStyleQuoteItem WHERE StyleQuoteItemID = @QuoteItemID	

SELECT top 1 @WorkflowItemID = b.WorkFlowItemID from pStyleBOMDimension b where b.StyleBOMDimensionID = @StyleBOMDimensionId
         
SELECT @TradePartnerID = TradePartnerID from pSourcingTradePartner WITH (NOLOCK) WHERE SourcingTradePartnerID = @SourcingTradePartnerID
BEGIN
	BEGIN
		IF @iCount = 0 
			BEGIN
			SET @InsertedQuoteItemID = @QuoteItemID
			UPDATE pStyleQuoteItem
			   SET 
				  StyleQuoteTradePartnerID = @SourcingTradePartnerID, 
				  TradePartnerID = @TradePartnerID, 
				  -- TradePartnerVendorID = @TradePartnerVendorID,
				  BOMOptionDefault = @WorkflowItemID,
				  MDate = @MDate, 
				  MUser = @MUser,
				  ActualStart = @MDate
				  WHERE StyleQuoteItemID = @QuoteItemID	
				  
			--Materials
			--EXECUTE spx_SourcingQuote_StyleBOMMaterials_INSERT
			--@QuoteItemID,
			--@SourcingHeaderID,
			--@SourcingStyleID,
			--@StyleBOMDimensionId
			
			--Calculations
			  Execute spx_SourcingCostCalculations_Update
			  @SourcingHeaderID,
			  @QuoteItemID,
			  @MUser,
			  @MDate
			  
			  if @IsShared = 1 
			  begin
				SELECT @TradePartnerID_toShare = (
						SELECT COALESCE(AgentID, VendorID, FactoryID)
						FROM vwx_TradePartnerRelationshipLevels_SEL tpm
							INNER JOIN pSourcingTradePartner stp ON tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
						WHERE stp.SourcingTradePartnerID = @SourcingTradePartnerID)
			  
				INSERT INTO pStyleQuoteItemShare (
					StyleQouteItemID
					, TradePartnerID
					, MUser
					, MDate) 
				VALUES (
					@QuoteItemID
					, @TradePartnerID_toShare
					, @MUser
					, @MDate)
					
				SELECT @TradePartnerRelationshipLevelID = TradePartnerLevelID FROM pSourcingTradePartner WHERE SourcingTradePartnerID = @SourcingTradePartnerID
				SELECT @SeasonYearID = SeasonYearID FROM pStyleQuoteItem
					INNER JOIN pStyleSeasonYear ON pStyleQuoteItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
				WHERE StyleQuoteItemID = @QuoteItemID
				
				IF (SELECT COUNT(*)  FROM pStyleTeam WITH (NOLOCK) WHERE  StyleID = @StyleID AND SeasonYearID = @SeasonYearID AND TeamID = @TradePartnerID_toShare AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
				BEGIN
					INSERT INTO pStyleTeam (TeamID, StyleDevelopmentID, StyleID, TradePartner, RequestStatus, TradePartnerRelationshipLevelID, SeasonYearID)
					VALUES (@TradePartnerID_toShare, @StyleDevelopmentID, @StyleID, 1, 0, @TradePartnerRelationshipLevelID, @SeasonYearID)
				END
				
			  end
			END
				 
	ELSE
		BEGIN
			SELECT @InsertedQuoteItemID = NEWID()
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
			,ActualStart
			)
			SELECT 
			@InsertedQuoteItemID
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
			,@MDate
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
			@InsertedQuoteItemID
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
			@InsertedQuoteItemID
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
           @InsertedQuoteItemID		
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
			--EXECUTE spx_SourcingQuote_StyleBOMMaterials_INSERT
			--@strNewId,
			--@SourcingHeaderID,
			--@SourcingStyleID,
			--@StyleBOMDimensionId
			  
           --Calculations
		  Execute spx_SourcingCostCalculations_Update
		  @SourcingHeaderID,
		  @InsertedQuoteItemID,
		  @MUser,
		  @MDate

			if @IsShared = 1 
			  begin
			  
				SELECT @TradePartnerID_toShare = (
						SELECT COALESCE(AgentID, VendorID, FactoryID)
						FROM vwx_TradePartnerRelationshipLevels_SEL tpm
							INNER JOIN pSourcingTradePartner stp ON tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
						WHERE stp.SourcingTradePartnerID = @SourcingTradePartnerID)
			  
				INSERT INTO pStyleQuoteItemShare (
					StyleQouteItemID
					, TradePartnerID
					, MUser
					, MDate) 
				VALUES (
					@InsertedQuoteItemID
					, @TradePartnerID_toShare
					, @MUser
					, @MDate)
					
				SELECT @TradePartnerRelationshipLevelID = TradePartnerLevelID FROM pSourcingTradePartner WHERE SourcingTradePartnerID = @SourcingTradePartnerID
				SELECT @SeasonYearID = SeasonYearID FROM pStyleQuoteItem
					INNER JOIN pStyleSeasonYear ON pStyleQuoteItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
				WHERE StyleQuoteItemID = @QuoteItemID
				
				IF (SELECT COUNT(*)  FROM pStyleTeam WITH (NOLOCK) WHERE  StyleID = @StyleID AND SeasonYearID = @SeasonYearID AND TeamID = @TradePartnerID_toShare AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
				BEGIN
					INSERT INTO pStyleTeam (TeamID, StyleDevelopmentID, StyleID, TradePartner, RequestStatus, TradePartnerRelationshipLevelID, SeasonYearID)
					VALUES (@TradePartnerID_toShare, @StyleDevelopmentID, @StyleID, 1, 0, @TradePartnerRelationshipLevelID, @SeasonYearID)
				END
				
           end
		END	 
	END
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08653', GetDate())
GO

