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
	
	DECLARE @TotalWSUnits INT,
			@TotalRUnits INT,
			@TotalEUnits INT
			
	SELECT @TotalWSUnits = SUM(TotalWSUnits),
		@TotalRUnits = SUM(TotalRUnits),
		@TotalEUnits = SUM(TotalEUnits)
	FROM pStyleSKUItems WHERE StyleSKUItemID = @StyleSKUItemID
	
	UPDATE pStyleQuoteItem SET StyleSKUItemID = @StyleSKUItemID,
		StyleQuoteItemCustomField2 = @TotalWSUnits,
		StyleQuoteItemCustomField6 = @TotalRUnits,
		StyleQuoteItem_EcomUnits = @TotalEUnits
	WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER,
			@SourcingHeaderID UNIQUEIDENTIFIER,
			@SourcingStyleID UNIQUEIDENTIFIER;
	
	SELECT @StyleBOMDimensionId = StyleColorID,
		@SourcingHeaderID = SourcingHeaderID,
		@SourcingStyleID = StyleSourcingID 
	FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	;WITH dims AS (
		SELECT DISTINCT V.DimID, 1 AS Active FROM pStyleSKUItems ssi
		CROSS APPLY	(VALUES (ssi.ItemDim1ID), 
							(ssi.ItemDim2ID), 
							(ssi.ItemDim3ID))
						   V(DimID)
		WHERE V.DimID IS NOT NULL
			AND  ssi.StyleSKUItemID = @StyleSKUItemID)
	UPDATE sqsb SET 
		ItemDim1Active = ISNULL(d1.Active, 0),
		ItemDim2Active = ISNULL(d2.Active, 0),
		ItemDim3Active = ISNULL(d3.Active, 0)
	FROM pSourcingQuoteStyleBOM sqsb
	LEFT JOIN dims d1 ON sqsb.ItemDim1Id = d1.DimID
	LEFT JOIN dims d2 ON sqsb.ItemDim2Id = d2.DimID
	LEFT JOIN dims d3 ON sqsb.ItemDim3Id = d3.DimID	
	WHERE sqsb.StyleQuoteItemID = @StyleQuoteItemID
	
	EXEC spx_SourcingQuote_StyleBOMDetailsItem_Update
		@StyleQuoteItemID = @StyleQuoteItemID,
		@StyleBOMDimensionId = @StyleBOMDimensionId,
		@SourcingHeaderID = @SourcingHeaderID,
		@SourcingStyleID = @SourcingStyleID,
		@MUser = @MUser,
		@MDate = @MDate
	
	UPDATE sqbd SET
		Quantity = skui.TotalUnits 
	FROM pSourcingQuotationBOMDetails sqbd
	INNER JOIN pStyleSKUItems skui ON skui.StyleSKUItemID = @StyleSKUItemID
		AND (skui.ItemDim1ID IN (sqbd.ItemDim1Id, sqbd.ItemDim2Id, sqbd.ItemDim3Id) OR skui.ItemDim1ID IS NULL)
		AND (skui.ItemDim2ID IN (sqbd.ItemDim1Id, sqbd.ItemDim2Id, sqbd.ItemDim3Id) OR skui.ItemDim2ID IS NULL)
		AND (skui.ItemDim3ID IN (sqbd.ItemDim1Id, sqbd.ItemDim2Id, sqbd.ItemDim3Id) OR skui.ItemDim3ID IS NULL)
	WHERE sqbd.StyleQuoteItemID = @StyleQuoteItemID
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08555', GetDate())
GO

