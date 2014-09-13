IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostCalculations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostCalculations_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SourcingCostCalculations_Update]
(@SourcingHeaderID UNIQUEIDENTIFIER
,@StyleQuoteItemID UNIQUEIDENTIFIER
,@Cuser nvarchar(200)
,@Cdate datetime)
	
AS

DECLARE	@StyleBOMDimensionId uniqueidentifier
DECLARE	@AdditionalCost decimal(18,2)
DECLARE @TotalBOMCost decimal(18,2)
DECLARE @TotalBOMQuantity decimal(18,2)
DECLARE @TotalBomAdditionalCost decimal(18,2)
DECLARE @DutyAmt decimal(18,2)
DECLARE @CommAmt decimal(18,2)
DECLARE @AgentAmt decimal(18,2)
DECLARE @FreightAmt decimal(18,2)
DECLARE @TotalExtCost decimal(18,2)
DECLARE @TotalPartnerCost decimal(18,2)
DECLARE @TotalExtPartnerCost decimal(18,2)

SELECT @StyleBOMDimensionId = COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000') FROM pStyleQuoteItem
WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId


select @StyleBOMDimensionId as StyleBOMDimensionId

Select @AdditionalCost= SUM(ISNULL(Amount, '0.00')) from pSourcingAdditionalCost
WHERE QuoteItemID=@StyleQuoteItemID 

select @AdditionalCost as AdditionalCost


--set @TotalBomAdditionalCost = @AdditionalCost


If @StyleBOMDimensionId <> '00000000-0000-0000-0000-000000000000'
	
	begin
	
	 Update pSourcingQuotationBOMDetails set TotalCost = ISNULL(Quantity, '0.00') * ISNULL(Cost, '0.00')
	 where pSourcingQuotationBOMDetails.StyleBOMDimensionId=@StyleBOMDimensionId
	 and pSourcingQuotationBOMDetails.StyleQuoteItemID=@StyleQuoteItemID 
	 and pSourcingQuotationBOMDetails.SourcingHeaderId=@SourcingHeaderId 
	
	Select @TotalBOMQuantity = SUM(ISNULL(Quantity, '0.00')) from pSourcingQuotationBOMDetails
	WHERE StyleQuoteItemID=@StyleQuoteItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
	and   ItemDim3Active=1 
	
	Select @TotalBOMQuantity as TotalBOMQuantity
	
	Select @TotalBOMCost = SUM(ISNULL(TotalCost, '0.00')) from pSourcingQuotationBOMDetails
	WHERE StyleQuoteItemID = @StyleQuoteItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
	and   ItemDim3Active=1 
	
	Select @TotalBOMCost  as TotalBOMCost
	
	set @TotalBomAdditionalCost = ISNULL(@TotalBOMCost, '0.00') + ISNULL(@AdditionalCost, '0.00')
	
	Select @TotalBomAdditionalCost  as TotalBomAdditionalCost
	
	Select @DutyAmt = (((ISNULL(StyleQuoteItemCustomField7, '0.00'))/100) * @TotalBomAdditionalCost) ,
	@CommAmt = (((ISNULL(StyleQuoteItemCustomField9, '0.00'))/100) * @TotalBomAdditionalCost) ,
	@AgentAmt = (((ISNULL(StyleQuoteItemCustomField11, '0.00'))/100) * @TotalBomAdditionalCost) ,
	@FreightAmt= ISNULL(StyleQuoteItemCustomField13, '0.00') 
	FROM pStyleQuoteItem
	WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId
	
	Select @DutyAmt  as DutyAmt
	Select @CommAmt  as CommAmt
	Select @AgentAmt  as AgentAmt
	
	
	Set @TotalExtCost=ISNULL(@TotalBomAdditionalCost, '0.00')+ISNULL(@DutyAmt, '0.00')+ISNULL(@CommAmt, '0.00')+ISNULL(@AgentAmt, '0.00')+ISNULL(@FreightAmt, '0.00')
	
	Select @TotalExtCost  as TotalExtCost
	
	
	-- Begin TotalPartnerCost calculations
	SELECT @TotalPartnerCost = SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingQuotationBOMDetails WHERE pSourcingQuotationBOMDetails.StyleQuoteItemID = @StyleQuoteItemID
	
	SELECT @TotalExtPartnerCost = (
		(SELECT SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingQuotationBOMDetails WHERE pSourcingQuotationBOMDetails.StyleQuoteItemID = @StyleQuoteItemID) + 
		ISNULL(StyleQuoteItemCustomField8, '0.00') + 
		ISNULL(StyleQuoteItemCustomField10,'0.00') + 
		ISNULL(StyleQuoteItemCustomField12,'0.00') + 
		ISNULL(StyleQuoteItemCustomField13,'0.00') + 
		ISNULL((SELECT SUM(ISNULL(Amount,'0.00')) FROM pSourcingAdditionalCost WHERE pSourcingAdditionalCost.QuoteItemID = @StyleQuoteItemID), '0.00')
		)
	FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID
	-- End TotalPartnerCost calculations
	
	
	Update pStyleQuoteItem set StyleQuoteItemCustomField8=@DutyAmt,
	StyleQuoteItemCustomField10=@CommAmt,StyleQuoteItemCustomField12=@AgentAmt,
	StyleQuoteItemCustomField13=@FreightAmt, StyleQuoteItemCustomField16=@TotalBOMQuantity,
	StyleQuoteItemCustomField14=@TotalBomAdditionalCost, StyleQuoteItemCustomField18=@TotalExtCost, 
	StyleQuoteItemCustomField23 = @TotalPartnerCost,
	StyleQuoteItemCustomField24 = @TotalExtPartnerCost
	WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId

end


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04473', GetDate())
GO
