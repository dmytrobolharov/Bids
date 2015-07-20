IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingPartnerCostCalculations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingPartnerCostCalculations_Update]
GO


CREATE PROCEDURE [dbo].[spx_SourcingPartnerCostCalculations_Update]
(@SourcingHeaderID UNIQUEIDENTIFIER
,@StyleQuoteItemID UNIQUEIDENTIFIER
,@Cuser nvarchar(200)
,@Cdate datetime)
	
AS

DECLARE	@StyleBOMDimensionId uniqueidentifier
DECLARE	@AdditionalCost decimal(18,2)
DECLARE @PartnerTotal decimal(18,2)
DECLARE @PartnerAdditionalTotal decimal(18,2)
DECLARE @DutyAmt decimal(18,2)
DECLARE @CommAmt decimal(18,2)
DECLARE @AgentAmt decimal(18,2)
DECLARE @FreightAmt decimal(18,2)
DECLARE @TotalExtCost decimal(18,2)

SELECT @StyleBOMDimensionId = COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000') FROM pStyleQuoteItem
WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId

Select @AdditionalCost= SUM(ISNULL(Amount, '0.00')) from pSourcingAdditionalCost
WHERE QuoteItemID=@StyleQuoteItemID 

--select @AdditionalCost as AdditionalCost

If @StyleBOMDimensionId <> '00000000-0000-0000-0000-000000000000'
	
	begin
	
	 Update pSourcingQuotationBOMDetails set PartnerTotal = ISNULL(Quantity, '0.00') * ISNULL(PartnerCost, '0.00')
	 where pSourcingQuotationBOMDetails.StyleBOMDimensionId=@StyleBOMDimensionId
	 and pSourcingQuotationBOMDetails.StyleQuoteItemID=@StyleQuoteItemID 
	 and pSourcingQuotationBOMDetails.SourcingHeaderId=@SourcingHeaderId 
	 
     Select @PartnerTotal = SUM(ISNULL(PartnerTotal, '0.00')) from pSourcingQuotationBOMDetails
	 WHERE StyleQuoteItemID = @StyleQuoteItemID  
	 
	 SET @PartnerAdditionalTotal = ISNULL(@PartnerTotal,'0.00') + ISNULL (@AdditionalCost,'0.00')
	
	Select @DutyAmt = (((ISNULL(StyleQuoteItemCustomField7, '0.00'))/100) * @PartnerAdditionalTotal) ,
	@CommAmt = (((ISNULL(StyleQuoteItemCustomField9, '0.00'))/100) * @PartnerAdditionalTotal) ,
	@AgentAmt = (((ISNULL(StyleQuoteItemCustomField11, '0.00'))/100) * @PartnerAdditionalTotal) ,
	@FreightAmt= ISNULL(StyleQuoteItemCustomField13, '0.00') 
	FROM pStyleQuoteItem
	WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId
	 

	set @TotalExtCost= ISNULL(@DutyAmt, '0.00') + ISNULL(@CommAmt, '0.00') +
	ISNULL(@AgentAmt, '0.00') + ISNULL(@FreightAmt, '0.00')+
	ISNULL(@PartnerAdditionalTotal, '0.00')
	 
     Update pStyleQuoteItem set
		StyleQuoteItemCustomField23=@PartnerAdditionalTotal, 
		StyleQuoteItemCustomField24=@TotalExtCost
	 WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId
	
end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05198', GetDate())
GO
