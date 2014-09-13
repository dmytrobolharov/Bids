
/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentCostCalculations_Update]    Script Date: 03/08/2013 11:01:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentCostCalculations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentCostCalculations_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentCostCalculations_Update]    Script Date: 03/08/2013 11:01:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_SourcingCommitmentCostCalculations_Update]
(@SourcingHeaderID UNIQUEIDENTIFIER
,@SourcingCommitmentItemID UNIQUEIDENTIFIER
,@CUser nvarchar(200)
,@CDate datetime)
	
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
DECLARE @TotalPartnerAdditionalCost decimal(18,2)
DECLARE @TotalExtPartnerCost decimal(18,2)
DECLARE @DetailsCnt int

SELECT @StyleBOMDimensionId = COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000') FROM pSourcingCommitmentItem
WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId


select @StyleBOMDimensionId as StyleBOMDimensionId

Select @AdditionalCost= SUM(ISNULL(Amount, '0.00')) from pSourcingCommitmentAdditionalCost
WHERE CommitmentItemID=@SourcingCommitmentItemID 

select @AdditionalCost as AdditionalCost


--set @TotalBomAdditionalCost = @AdditionalCost


If @StyleBOMDimensionId <> '00000000-0000-0000-0000-000000000000'
	
	begin
	
	 Update pSourcingCommitmentBOMDetails set TotalCost = ISNULL(Quantity, '0.00') * ISNULL(Cost, '0.00')
	 where pSourcingCommitmentBOMDetails.StyleBOMDimensionId=@StyleBOMDimensionId
	 and pSourcingCommitmentBOMDetails.SourcingCommitmentItemID=@SourcingCommitmentItemID 
	 and pSourcingCommitmentBOMDetails.SourcingHeaderId=@SourcingHeaderId 
	
	select @DetailsCnt=COUNT(SourcingCommitmentItemID) from pSourcingCommitmentBOMDetails
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
	and   ItemDim3Active=1 
	
	if @DetailsCnt>0
		begin
			Select @TotalBOMQuantity = SUM(ISNULL(Quantity, '0.00')) from pSourcingCommitmentBOMDetails
			WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
			and   ItemDim3Active=1 
		end
	else
		begin
			-- Wholesale Unit + Retail Unit
			Select @TotalBOMQuantity = ISNULL(StyleQuoteItemCustomField2, '0') + ISNULL(StyleQuoteItemCustomField6, '0') from pSourcingCommitmentItem
			WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID  
		end
	
	Select @TotalBOMQuantity as TotalBOMQuantity
	
	if @DetailsCnt>0
		begin
			Select @TotalBOMCost = SUM(ISNULL(TotalCost, '0.00')) from pSourcingCommitmentBOMDetails
			WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
			and   ItemDim3Active=1 
		end
	else
		begin
			Select @TotalBOMCost = 0
		end
	
	Select @TotalBOMCost  as TotalBOMCost
	
	set @TotalBomAdditionalCost = ISNULL(@TotalBOMCost, '0.00') + ISNULL(@AdditionalCost, '0.00')
	
	Select @TotalBomAdditionalCost  as TotalBomAdditionalCost
	
	Select @DutyAmt = (((ISNULL(StyleQuoteItemCustomField7, '0.00'))/100) * @TotalBomAdditionalCost) ,
	@CommAmt = (((ISNULL(StyleQuoteItemCustomField9, '0.00'))/100) * @TotalBomAdditionalCost) ,
	@AgentAmt = (((ISNULL(StyleQuoteItemCustomField11, '0.00'))/100) * @TotalBomAdditionalCost) ,
	@FreightAmt= ISNULL(StyleQuoteItemCustomField13, '0.00') 
	FROM pSourcingCommitmentItem
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
	
	Select @DutyAmt  as DutyAmt
	Select @CommAmt  as CommAmt
	Select @AgentAmt  as AgentAmt
	
	-- update Duty calculation
	UPDATE pSourcingCommitmentItem SET
		StyleQuoteItemCustomField8 = @DutyAmt, 
		StyleQuoteItemCustomField10 = @CommAmt, 
		StyleQuoteItemCustomField12 = @AgentAmt, 
		StyleQuoteItemCustomField13 = @FreightAmt 
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
	
	Set @TotalExtCost=ISNULL(@TotalBomAdditionalCost, '0.00')+ISNULL(@DutyAmt, '0.00')+ISNULL(@CommAmt, '0.00')+ISNULL(@AgentAmt, '0.00')+ISNULL(@FreightAmt, '0.00')
	
	Select @TotalExtCost  as TotalExtCost
	
	
	-- Begin TotalPartnerCost calculations
	 Update pSourcingCommitmentBOMDetails set PartnerTotal = ISNULL(Quantity, '0.00') * ISNULL(PartnerCost, '0.00')
	 where pSourcingCommitmentBOMDetails.StyleBOMDimensionId=@StyleBOMDimensionId
	 and pSourcingCommitmentBOMDetails.SourcingCommitmentItemID=@SourcingCommitmentItemID 
	 and pSourcingCommitmentBOMDetails.SourcingHeaderId=@SourcingHeaderId 

	SELECT @TotalPartnerCost = SUM(ISNULL(PartnerTotal,'0.00')) FROM pSourcingCommitmentBOMDetails WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
	
	SET @TotalPartnerAdditionalCost = ISNULL(@TotalPartnerCost, '0.00') + ISNULL(@AdditionalCost, '0.00')

	Select @DutyAmt = (((ISNULL(StyleQuoteItemCustomField7, '0.00'))/100) * @TotalPartnerAdditionalCost) ,
	@CommAmt = (((ISNULL(StyleQuoteItemCustomField9, '0.00'))/100) * @TotalPartnerAdditionalCost) ,
	@AgentAmt = (((ISNULL(StyleQuoteItemCustomField11, '0.00'))/100) * @TotalPartnerAdditionalCost) ,
	@FreightAmt= ISNULL(StyleQuoteItemCustomField13, '0.00') 
	FROM pSourcingCommitmentItem
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
	
	SELECT @TotalExtPartnerCost = ISNULL(@TotalPartnerAdditionalCost, '0.00')+ISNULL(@DutyAmt, '0.00')+ISNULL(@CommAmt, '0.00')+ISNULL(@AgentAmt, '0.00')+ISNULL(@FreightAmt, '0.00')
	-- End TotalPartnerCost calculations
	
	
	Update pSourcingCommitmentItem set 
	StyleQuoteItemCustomField16 = convert(int,@TotalBOMQuantity),
	StyleQuoteItemCustomField14 = @TotalBomAdditionalCost, 
	StyleQuoteItemCustomField18 = @TotalExtCost, 
	StyleQuoteItemCustomField23 = @TotalPartnerAdditionalCost,
	StyleQuoteItemCustomField24 = @TotalExtPartnerCost
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId

end

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05269', GetDate())
GO
