IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentCostCalculations_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentCostCalculations_Update]
GO

CREATE PROCEDURE [dbo].[spx_SourcingCommitmentCostCalculations_Update]
(@SourcingHeaderID UNIQUEIDENTIFIER = NULL
,@SourcingCommitmentItemID UNIQUEIDENTIFIER
,@CUser nvarchar(200)
,@CDate datetime)
	
AS

DECLARE	@StyleBOMDimensionId uniqueidentifier
DECLARE	@AdditionalCost decimal(18,2)
DECLARE @TotalBOMCost decimal(18,2)
DECLARE @TotalBOMQuantity decimal(18,2)
DECLARE @TotalCost decimal(18,2)
DECLARE @TotalQuantity decimal(18,2)
DECLARE @DutyAmt decimal(18,2)
DECLARE @CommAmt decimal(18,2)
DECLARE @AgentAmt decimal(18,2)
DECLARE @FreightAmt decimal(18,2)
DECLARE @TotalExtCost decimal(18,2)
DECLARE @TotalPartnerCost decimal(18,2)
DECLARE @TotalPartnerAdditionalCost decimal(18,2)
DECLARE @TotalExtPartnerCost decimal(18,2)
DECLARE @DetailsCnt int

DECLARE @IntExtFOB decimal(18,2)
DECLARE @IntExtLDP decimal(18,2)
DECLARE @PartnerExtFOB decimal(18,2)
DECLARE @PartnerExtLDP decimal(18,2)

IF @SourcingHeaderID IS NULL 
	SELECT @SourcingHeaderID = SourcingHeaderID FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID

SELECT @StyleBOMDimensionId = COALESCE(StyleColorID,'00000000-0000-0000-0000-000000000000') FROM pSourcingCommitmentItem
WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId


select @StyleBOMDimensionId as StyleBOMDimensionId

Select @AdditionalCost= SUM(ISNULL(Amount, '0.00')) from pSourcingCommitmentAdditionalCost
WHERE CommitmentItemID=@SourcingCommitmentItemID 

select @AdditionalCost as AdditionalCost



--If @StyleBOMDimensionId <> '00000000-0000-0000-0000-000000000000'
	
	--begin
	
	 Update pSourcingCommitmentBOMDetails set TotalCost = ISNULL(Quantity, '0.00') * ISNULL(Cost, '0.00')
	 where pSourcingCommitmentBOMDetails.StyleBOMDimensionId=@StyleBOMDimensionId
	 and pSourcingCommitmentBOMDetails.SourcingCommitmentItemID=@SourcingCommitmentItemID 
	 and pSourcingCommitmentBOMDetails.SourcingHeaderId=@SourcingHeaderId 
	
	select @DetailsCnt=COUNT(SourcingCommitmentItemID) from pSourcingCommitmentBOMDetails
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
	and   ItemDim3Active=1 
	
	if @DetailsCnt>0
		begin
			Select @TotalQuantity = SUM(ISNULL(Quantity, '0.00')) from pSourcingCommitmentBOMDetails
			WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
			and   ItemDim3Active=1 
			
			Select @TotalBOMCost = SUM(ISNULL(TotalCost, '0.00')), 
				@TotalPartnerCost = SUM(ISNULL(PartnerTotal, '0.00'))
			from pSourcingCommitmentBOMDetails
			WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID  and  ItemDim1Active=1 and   ItemDim2Active=1 
			and   ItemDim3Active=1 
			
			-- (Sum of all partner totals + Sum of all Additional cost)
			Select @TotalCost = ISNULL(@TotalPartnerCost, '0.00') + ISNULL(@AdditionalCost, '0.00')
		end
	else
		begin
			-- Wholesale Unit + Retail Unit
			Select @TotalQuantity = ISNULL(StyleQuoteItemCustomField2, '0') + ISNULL(StyleQuoteItemCustomField6, '0') from pSourcingCommitmentItem
			WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID  
			
			-- (Partner FOB * Total Units) + Sum of all Additional cost
			Select @TotalCost = ((ISNULL(StyleCostingCustomField6, '0.00')) * @TotalQuantity) + ISNULL(@AdditionalCost, '0.00')
			from pSourcingCommitmentItem where SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
		end
	

	
	Select @CommAmt = ISNULL(StyleQuoteItemCustomField9, '0.00') * @TotalCost
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId

	Select @AgentAmt = ISNULL(StyleQuoteItemCustomField11, '0.00') * (@TotalCost + @CommAmt)
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId

	Select @DutyAmt = (ISNULL(StyleQuoteItemCustomField7, '0.00')) * (@TotalCost + @CommAmt + @AgentAmt) 
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
	
	Select @FreightAmt= ISNULL(StyleQuoteItemCustomField13, '0.00') 
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
	
	
	Set @PartnerExtFOB = @TotalCost + @CommAmt + @AgentAmt
	Set @PartnerExtLDP = @PartnerExtFOB + @DutyAmt + @FreightAmt

	if @DetailsCnt>0 
	begin
		Select @IntExtFOB = (@TotalBOMCost + ISNULL(@AdditionalCost, '0.00')) * (1 + (ISNULL(StyleQuoteItemCustomField9, '0.00')) + (ISNULL(StyleQuoteItemCustomField11, '0.00')) + ((ISNULL(StyleQuoteItemCustomField9, '0.00')) * (ISNULL(StyleQuoteItemCustomField11, '0.00'))))
		FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
		
		Select @IntExtLDP = @IntExtFOB + @FreightAmt + (@IntExtFOB * (ISNULL(StyleQuoteItemCustomField7, '0.00')))
		FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId
	end
	else
	begin
		Set @IntExtFOB = NULL
		Set @IntExtLDP = NULL
	end
	
	
	Update pSourcingCommitmentItem set 
		StyleQuoteItemCustomField8 = @DutyAmt, 
		StyleQuoteItemCustomField10 = @CommAmt, 
		StyleQuoteItemCustomField12 = @AgentAmt, 
		StyleQuoteItemCustomField13 = @FreightAmt, 
		
		StyleQuoteItemCustomField16 = convert(int,@TotalQuantity),
		StyleQuoteItemCustomField14 = @IntExtFOB, 
		StyleQuoteItemCustomField18 = @IntExtLDP, 
		StyleQuoteItemCustomField23 = @PartnerExtFOB, 
		StyleQuoteItemCustomField24 = @PartnerExtLDP 
	WHERE SourcingCommitmentItemID=@SourcingCommitmentItemID and SourcingHeaderId=@SourcingHeaderId

--end


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06862', GetDate())
GO
