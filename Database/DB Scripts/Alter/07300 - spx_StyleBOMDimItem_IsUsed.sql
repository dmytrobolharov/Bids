IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimItem_IsUsed]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimItem_IsUsed]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimItem_IsUsed]
(
	@StyleBOMDimensionID UNIQUEIDENTIFIER
	, @DimID UNIQUEIDENTIFIER
)

AS
BEGIN

	DECLARE @DimLevel INT
	
	-- get level for @DimID
	SELECT @DimLevel = V.DimLevel
	FROM pStyleBOMDimensionItem sbdi
	CROSS APPLY (
		VALUES (sbdi.ItemDim1Id, 1), 
			   (sbdi.ItemDim2Id, 2), 
			   (sbdi.ItemDim3Id, 3)
	) V(ItemDimID, DimLevel)
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		AND ItemDimID = @DimID


	IF @DimLevel = 1
	BEGIN
		IF (SELECT COUNT(*) FROM pSampleRequestBOMTrade 
				INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
				INNER JOIN pStyleBOMDimensionItem ON pSampleRequestBOMTrade.ItemDim1Id = pStyleBOMDimensionItem.ItemDim1Id 
							AND pSampleRequestBOMTrade.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim1Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingQuoteStyleBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingQuoteStyleBOM.ItemDim1Id = pStyleBOMDimensionItem.ItemDim1Id 
							AND pSourcingQuoteStyleBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
							AND pSourcingQuoteStyleBOM.ItemDim1Active = 1
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim1Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingCommitmentBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingCommitmentBOM.ItemDim1Id = pStyleBOMDimensionItem.ItemDim1Id 
							AND pSourcingCommitmentBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
							AND pSourcingCommitmentBOM.ItemDim1Active = 1
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim1Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END
	END
	ELSE IF @DimLevel = 2
	BEGIN
		IF (SELECT COUNT(*) FROM pSampleRequestBOMTrade 
				INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
				INNER JOIN pStyleBOMDimensionItem ON pSampleRequestBOMTrade.ItemDim2Id = pStyleBOMDimensionItem.ItemDim2Id 
							AND pSampleRequestBOMTrade.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim2Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingQuoteStyleBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingQuoteStyleBOM.ItemDim2Id = pStyleBOMDimensionItem.ItemDim2Id 
							AND pSourcingQuoteStyleBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
							AND pSourcingQuoteStyleBOM.ItemDim2Active = 1
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim2Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END
		
		IF (SELECT COUNT(*) FROM pSourcingCommitmentBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingCommitmentBOM.ItemDim2Id = pStyleBOMDimensionItem.ItemDim2Id 
							AND pSourcingCommitmentBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
							AND pSourcingCommitmentBOM.ItemDim2Active = 1
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim2Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN	
		END
	END
	ELSE IF @DimLevel = 3
	BEGIN
		IF (SELECT COUNT(*) FROM pSampleRequestBOMTrade 
				INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
				INNER JOIN pStyleBOMDimensionItem ON pSampleRequestBOMTrade.ItemDim3Id = pStyleBOMDimensionItem.ItemDim3Id 
							AND pSampleRequestBOMTrade.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim3Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingQuoteStyleBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingQuoteStyleBOM.ItemDim3Id = pStyleBOMDimensionItem.ItemDim3Id 
							AND pSourcingQuoteStyleBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
							AND pSourcingQuoteStyleBOM.ItemDim3Active = 1
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim3Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingCommitmentBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingCommitmentBOM.ItemDim3Id = pStyleBOMDimensionItem.ItemDim3Id 
							AND pSourcingCommitmentBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
							AND pSourcingCommitmentBOM.ItemDim3Active = 1
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	AND pStyleBOMDimensionItem.ItemDim3Id = @DimID) > 0
		BEGIN
			SELECT 1
			RETURN
		END
	END
	
	SELECT 0
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07300', GetDate())
GO
