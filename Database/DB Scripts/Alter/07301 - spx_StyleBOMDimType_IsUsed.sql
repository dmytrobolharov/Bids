IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimType_IsUsed]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimType_IsUsed]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimType_IsUsed]
(
	@StyleBOMDimensionID UNIQUEIDENTIFIER
	, @DimLevel INT
)

AS
BEGIN

	IF @DimLevel = 1
	BEGIN
		IF (SELECT COUNT(*) FROM pSampleRequestBOMTrade 
				INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
				INNER JOIN pStyleBOMDimensionItem ON pSampleRequestBOMTrade.ItemDim1Id = pStyleBOMDimensionItem.ItemDim1Id 
							AND pSampleRequestBOMTrade.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingQuoteStyleBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingQuoteStyleBOM.ItemDim1Id = pStyleBOMDimensionItem.ItemDim1Id 
							AND pSourcingQuoteStyleBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingCommitmentBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingCommitmentBOM.ItemDim1Id = pStyleBOMDimensionItem.ItemDim1Id 
							AND pSourcingCommitmentBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
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
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingQuoteStyleBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingQuoteStyleBOM.ItemDim2Id = pStyleBOMDimensionItem.ItemDim2Id 
							AND pSourcingQuoteStyleBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END
		
		IF (SELECT COUNT(*) FROM pSourcingCommitmentBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingCommitmentBOM.ItemDim2Id = pStyleBOMDimensionItem.ItemDim2Id 
							AND pSourcingCommitmentBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
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
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingQuoteStyleBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingQuoteStyleBOM.ItemDim3Id = pStyleBOMDimensionItem.ItemDim3Id 
							AND pSourcingQuoteStyleBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END

		IF (SELECT COUNT(*) FROM pSourcingCommitmentBOM
				INNER JOIN pStyleBOMDimensionItem ON pSourcingCommitmentBOM.ItemDim3Id = pStyleBOMDimensionItem.ItemDim3Id 
							AND pSourcingCommitmentBOM.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
			WHERE pStyleBOMDimensionItem.StyleBOMDimensionID = @StyleBOMDimensionID	) > 0
		BEGIN
			SELECT 1
			RETURN
		END
	END
	
	SELECT 0
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07301', GetDate())
GO
