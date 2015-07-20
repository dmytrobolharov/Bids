IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_StyleSKUItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_StyleSKUItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SourcingCommitment_StyleSKUItem_UPDATE]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER,
	@StyleSKUItemID UNIQUEIDENTIFIER,
	@MUser nvarchar(200),
	@MDate datetime
AS
BEGIN
	
	UPDATE pSourcingCommitmentItem SET StyleSKUItemID = @StyleSKUItemID 
	WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
	
	DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER,
			@SourcingHeaderID UNIQUEIDENTIFIER,
			@SourcingStyleID UNIQUEIDENTIFIER,
			@StyleQuoteItemID UNIQUEIDENTIFIER;
	
	SELECT @StyleBOMDimensionId = StyleColorID,
		@SourcingHeaderID = SourcingHeaderID,
		@SourcingStyleID = StyleSourcingID,
		@StyleQuoteItemID = StyleQuoteItemID
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
	
	EXEC spx_SourcingCommitment_StyleBOMItem_UPDATE
		@StyleCommitmentItemID = @SourcingCommitmentItemID,
		@StyleBOMDimensionId = @StyleBOMDimensionId,
		@SourcingHeaderID = @SourcingHeaderID,
		@SourcingStyleID = @SourcingStyleID,
		@StyleSKUItemID = @StyleSKUItemID,
		@MUser = @MUser,
		@MDate = @MDate
		
	IF @StyleSKUItemID IS NOT NULL
		UPDATE pSourcingCommitmentBOM SET 
			ItemDim1Active = CASE WHEN ItemDim1Id IS NULL THEN 0 ELSE 1 END,
			ItemDim2Active = CASE WHEN ItemDim2Id IS NULL THEN 0 ELSE 1 END,
			ItemDim3Active = CASE WHEN ItemDim3Id IS NULL THEN 0 ELSE 1 END
		WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
	
	EXEC spx_SourcingCommitment_StyleBOMDetailsItem_Update
		@StyleCommitmentItemID = @SourcingCommitmentItemID,
		@StyleQuoteItemID = @StyleQuoteItemID,
		@StyleBOMDimensionId = @StyleBOMDimensionId,
		@SourcingHeaderID = @SourcingHeaderID,
		@SourcingStyleID = @SourcingStyleID,
		@StyleSKUItemID = @StyleSKUItemID,
		@MUser = @MUser,
		@MDate = @MDate
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08226', GetDate())
GO
