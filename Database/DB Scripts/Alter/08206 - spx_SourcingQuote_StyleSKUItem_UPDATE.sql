IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleSKUItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleSKUItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleSKUItem_UPDATE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@StyleSKUItemID UNIQUEIDENTIFIER,
	@MUser nvarchar(200),
	@MDate datetime
AS
BEGIN
	
	UPDATE pStyleQuoteItem SET StyleSKUItemID = @StyleSKUItemID 
	WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER,
			@SourcingHeaderID UNIQUEIDENTIFIER,
			@SourcingStyleID UNIQUEIDENTIFIER;
	
	SELECT @StyleBOMDimensionId = StyleColorID,
		@SourcingHeaderID = SourcingHeaderID,
		@SourcingStyleID = StyleSourcingID 
	FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	EXEC spx_SourcingQuote_StyleBOMItem_INSERT
		@StyleQuoteItemID = @StyleQuoteItemID,
		@StyleBOMDimensionId = @StyleBOMDimensionId,
		@SourcingHeaderID = @SourcingHeaderID,
		@SourcingStyleID = @SourcingStyleID,
		@StyleSKUItemID = @StyleSKUItemID,
		@MUser = @MUser,
		@MDate = @MDate
		
	IF @StyleSKUItemID IS NOT NULL
		UPDATE pSourcingQuoteStyleBOM SET 
			ItemDim1Active = CASE WHEN ItemDim1Id IS NULL THEN 0 ELSE 1 END,
			ItemDim2Active = CASE WHEN ItemDim2Id IS NULL THEN 0 ELSE 1 END,
			ItemDim3Active = CASE WHEN ItemDim3Id IS NULL THEN 0 ELSE 1 END
		WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	EXEC spx_SourcingQuote_StyleBOMDetailsItem_INSERT
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
VALUES ('DB_Version', '0.5.0000', '08206', GetDate())
GO
