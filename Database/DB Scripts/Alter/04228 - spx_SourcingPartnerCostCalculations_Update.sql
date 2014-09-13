IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingPartnerCostCalculations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingPartnerCostCalculations_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




Create PROCEDURE [dbo].[spx_SourcingPartnerCostCalculations_Update]
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

SELECT @StyleBOMDimensionId = COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000') FROM pStyleQuoteItem
WHERE StyleQuoteItemID=@StyleQuoteItemID and SourcingHeaderId=@SourcingHeaderId

Select @AdditionalCost= SUM(ISNULL(Amount, '0.00')) from pSourcingAdditionalCost
WHERE QuoteItemID=@StyleQuoteItemID 

select @AdditionalCost as AdditionalCost



If @StyleBOMDimensionId <> '00000000-0000-0000-0000-000000000000'
	
	begin
	
	 Update pSourcingQuotationBOMDetails set PartnerTotal = ISNULL(Quantity, '0.00') * ISNULL(PartnerCost, '0.00')
	 where pSourcingQuotationBOMDetails.StyleBOMDimensionId=@StyleBOMDimensionId
	 and pSourcingQuotationBOMDetails.StyleQuoteItemID=@StyleQuoteItemID 
	 and pSourcingQuotationBOMDetails.SourcingHeaderId=@SourcingHeaderId 

end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04228', GetDate())
GO


