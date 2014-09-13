BEGIN TRAN

DECLARE @DEBUG INT = 0

/* temp table by all colors of all BOMs */
CREATE TABLE #WorkflowItemColor 
(
	ROW_ID INT IDENTITY(1,1),
	StyleID UNIQUEIDENTIFIER,
	StyleSet INT,
	StyleNo NVARCHAR(20),
	WorkflowItemID UNIQUEIDENTIFIER,
	WorkflowItemName NVARCHAR(200),
	StyleSeasonYearID UNIQUEIDENTIFIER,
	DimLevel INT,
	ColorPaletteID UNIQUEIDENTIFIER,
	ColorCode NVARCHAR(200),
	ColorName NVARCHAR(200)
)

INSERT INTO #WorkflowItemColor
SELECT pStyleHeader.StyleID, pStyleBOMDimensionItem.StyleSet, pStyleHeader.StyleNo, 
	pWorkFlowItem.WorkFlowItemID, pWorkFlowItem.WorkFlowItemName, pStyleSeasonYear.StyleSeasonYearID, 
	CASE 
		WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN 1
		WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN 2
		WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN 3
	ELSE 0
	END AS DimLevel,
	pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName
FROM pStyleBOMDimensionItem
	INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	INNER JOIN pColorPalette ON pColorPalette.ColorPaletteID IN (ItemDim1Id, ItemDim2Id, ItemDim3Id)
	INNER JOIN pStyleHeader ON pStyleBOMDimensionItem.StyleID = pStyleHeader.StyleID
ORDER BY pStyleHeader.StyleNo, pStyleSeasonYear.StyleSeason + ' ' + pStyleSeasonYear.StyleYear, pWorkFlowItem.WorkFlowItemName, 
	pColorPalette.ColorCode, pColorPalette.ColorName

--SELECT * FROM #WorkflowItemColor

DECLARE @StyleID UNIQUEIDENTIFIER  
DECLARE @StyleSet INT
DECLARE @PLMCode NVARCHAR (200) 
DECLARE @StyleNo NVARCHAR(20)
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER  

DECLARE @ColorPaletteID UNIQUEIDENTIFIER
DECLARE @StyleColorID UNIQUEIDENTIFIER  
DECLARE @StyleColorNo NVARCHAR(200)
DECLARE @StyleColorName NVARCHAR(200)

DECLARE @WorkflowItemID UNIQUEIDENTIFIER
DECLARE @WorkflowItemName NVARCHAR(200)
DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
DECLARE @DimLevel INT

DECLARE @iRow INT = 1
DECLARE @iCount INT
SELECT @iCount = COUNT(*) FROM #WorkflowItemColor

WHILE (@iRow <= @iCount) 
BEGIN
	
	/* take ColorCode, ColorName, ColorPaletteID of BOM color and StyleSeasonYearID of BOM */
	SELECT @StyleColorNo = ColorCode, @StyleColorName = ColorName, @ColorPaletteID = ColorPaletteID,
		@StyleID = StyleID, @StyleSet = StyleSet, @StyleNo = StyleNo, @StyleSeasonYearID = StyleSeasonYearID, 
		@WorkflowItemID = WorkflowItemID, @WorkflowItemName = WorkflowItemName, @DimLevel = DimLevel
	FROM #WorkflowItemColor
	WHERE ROW_ID = @iRow
	
	SELECT @StyleBOMDimensionID = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @WorkflowItemID
	
	print REPLICATE('-',125)
	print '---' + CAST(@iRow AS NVARCHAR(10)) + ' of ' + CAST(@iCount AS NVARCHAR(10)) + '---'
	print REPLICATE('-',125)
	print REPLICATE('-',5) + ' ' + 'StyleNo: ' + @StyleNo + ', BOM: ' + @WorkflowItemName + ', ColorCode: ' + @StyleColorNo + ', ColorName: ' + @StyleColorName
	
	--**
	--** Check if a StyleColorway with the same color Name/Code exists already 
	--**
	SET @StyleColorID = NULL
	
	SELECT TOP 1 @StyleColorID = a.StyleColorID
	FROM pStyleColorway a WITH(NOLOCK) 
		INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID 
	AND b.ColorCode = @StyleColorNo
	AND b.ColorName = @StyleColorName 
	
	IF @StyleColorID IS NULL
	BEGIN
		SELECT @PLMCode = StyleNo + @StyleColorNo, @StyleNo = StyleNo 
		FROM pStyleHeader WITH(NOLOCK) 
		WHERE StyleID = @StyleID 
	
		SET @StyleColorID = NEWID()
		INSERT INTO pStyleColorway ( StyleColorID, StyleID, StyleSet, StyleColorStandardID , ColorPaletteID , StyleColorNo, StyleColorName,  MainColor,
					CUser, CDate, MUser, MDate , PLMCode) 
		VALUES ( @StyleColorID,  @StyleID, @StyleSet, NULL, @ColorPaletteID , @StyleColorNo, @StyleColorName,  @StyleColorName ,
					'SYSTEM', GETDATE(), 'SYSTEM', GETDATE() , @PLMCode  ) 
					
		print REPLICATE('-',5) + ' ' + @StyleColorName + '(' + @StyleColorNo + ') was added to style ' + @StyleNo + REPLICATE('-',5)
		
	END
	ELSE
	BEGIN
		print REPLICATE('-',5) + ' ' + @StyleColorName + '(' + @StyleColorNo + ') is already exists in pStyleColorway of style ' + @StyleNo + REPLICATE('-',5)
	END
	
	/* check if current Color was added to pStyleColorwaySeasonYear from DimBOM (StyleColorwayID IS NULL AND ColorPaletteID = @ColorPaletteID) 
		We need to delete this record if we have in pStyleColorwaySeasonYear the same color from pStyleColorway	
		or 
		update this record using new StyleColorID. It preserves Delivery data (Attribute workflow) that is stored in pStyleColorwaySeasonYear table */
	IF EXISTS (SELECT * FROM pStyleColorwaySeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID IS NULL AND ColorPaletteID = @ColorPaletteID)
	BEGIN
		IF EXISTS (SELECT * FROM pStyleColorwaySeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID = @StyleColorID)
		BEGIN
			DELETE FROM pStyleColorwaySeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID AND ColorPaletteID = @ColorPaletteID
			print @StyleColorName + '(' + @StyleColorNo + ') was duplicated in Seasonal Colorway and removed'
		END
		ELSE
		BEGIN
			UPDATE pStyleColorwaySeasonYear SET ColorPaletteID = NULL, StyleColorwayID = @StyleColorID WHERE StyleSeasonYearID = @StyleSeasonYearID AND ColorPaletteID = @ColorPaletteID
			print @StyleColorName + '(' + @StyleColorNo + ') was updated in Seasonal Colorway to use StyleColorID'
		END
	END
	
	print REPLICATE('-',5) + ' starting update BOM, samples, quotes, commitments tables from ColorPaletteID to StyleColorID ' + REPLICATE('-',5)
	
	/* UPDATE BOM tables */
	IF @DimLevel = 1
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim1Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim1Id = @ColorPaletteID
		UPDATE pStyleBOMDimensionItems SET ItemDim1Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim1Id = @ColorPaletteID
		UPDATE pStyleBOMItem SET ItemDim1Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim1Id = @ColorPaletteID
	END
	ELSE IF @DimLevel = 2
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim2Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim2Id = @ColorPaletteID
		UPDATE pStyleBOMDimensionItems SET ItemDim2Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim2Id = @ColorPaletteID
		UPDATE pStyleBOMItem SET ItemDim2Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim2Id = @ColorPaletteID
	END
	ELSE IF @DimLevel = 3
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim3Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim3Id = @ColorPaletteID
		UPDATE pStyleBOMDimensionItems SET ItemDim3Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim3Id = @ColorPaletteID
		UPDATE pStyleBOMItem SET ItemDim3Id = @StyleColorID WHERE WorkFlowItemID = @WorkflowItemID AND ItemDim3Id = @ColorPaletteID
	END
	
	IF @DimLevel = 1
	BEGIN
		/* UPDATE Sample request tables */

		UPDATE pSampleRequestBOMActivity
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestBOMActivity
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestBOMActivity.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestBOMActivity.ItemDim1Id = @ColorPaletteID
			
		UPDATE pSampleRequestMaterialBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestMaterialBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestMaterialBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestMaterialBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSampleRequestQASizeBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestQASizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestQASizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestQASizeBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSampleRequestSpecItemBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestSpecItemBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecItemBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecItemBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSampleRequestSpecSizeBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestSpecSizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecSizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecSizeBOM.ItemDim1Id = @ColorPaletteID
		
		UPDATE pSampleRequestStyleBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestStyleBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestStyleBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSampleRequestStyleBOMColorwayTemp
		SET ItemDim1Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOMColorwayTemp.ItemDim1Id = @ColorPaletteID

		UPDATE pSampleRequestSubmitBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestSubmitBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSubmitBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSubmitBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSampleRequestWorkflowBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestWorkflowBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestWorkflowBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestWorkflowBOM.ItemDim1Id = @ColorPaletteID
			
		UPDATE pSampleRequestBOMTrade
		SET ItemDim1Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @ColorPaletteID
			
		/* UPDATE Quote tables */
		UPDATE pSourcingQuoteStyleBOM
		SET ItemDim1Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuoteStyleBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSourcingQuotationBOMDetails
		SET ItemDim1Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuotationBOMDetails.ItemDim1Id = @ColorPaletteID

		UPDATE pSourcingCostOptionDetail
		SET ItemDim1Id = @StyleColorID
		FROM pSourcingCostOptionDetail
			INNER JOIN pSourcingQuotationBOMDetails ON pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID
		WHERE pSourcingQuotationBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCostOptionDetail.ItemDim1Id = @ColorPaletteID
			
		/* UPDATE Commit tables */
		UPDATE pSourcingCommitmentBOM
		SET ItemDim1Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOM.ItemDim1Id = @ColorPaletteID

		UPDATE pSourcingCommitmentBOMDetails
		SET ItemDim1Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOMDetails.ItemDim1Id = @ColorPaletteID

		UPDATE pSourcingCommitmentCostOptionDetail
		SET ItemDim1Id = @StyleColorID
		FROM pSourcingCommitmentCostOptionDetail
			INNER JOIN pSourcingCommitmentBOMDetails ON pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingCommitmentBOMDetails.SourcingCommitmentBOMDetailsID
		WHERE pSourcingCommitmentBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCommitmentCostOptionDetail.ItemDim1Id = @ColorPaletteID
			
	END
	ELSE IF @DimLevel = 2
	BEGIN
		UPDATE pSampleRequestBOMActivity
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestBOMActivity
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestBOMActivity.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestBOMActivity.ItemDim2Id = @ColorPaletteID
			
		UPDATE pSampleRequestMaterialBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestMaterialBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestMaterialBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestMaterialBOM.ItemDim2Id = @ColorPaletteID
			
		UPDATE pSampleRequestQASizeBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestQASizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestQASizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestQASizeBOM.ItemDim2Id = @ColorPaletteID

		UPDATE pSampleRequestSpecItemBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestSpecItemBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecItemBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecItemBOM.ItemDim2Id = @ColorPaletteID
			
		UPDATE pSampleRequestSpecSizeBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestSpecSizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecSizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecSizeBOM.ItemDim2Id = @ColorPaletteID
			
		UPDATE pSampleRequestStyleBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestStyleBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestStyleBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOM.ItemDim2Id = @ColorPaletteID

		UPDATE pSampleRequestStyleBOMColorwayTemp
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOMColorwayTemp.ItemDim2Id = @ColorPaletteID

		UPDATE pSampleRequestSubmitBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestSubmitBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSubmitBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSubmitBOM.ItemDim2Id = @ColorPaletteID

		UPDATE pSampleRequestWorkflowBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestWorkflowBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestWorkflowBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestWorkflowBOM.ItemDim2Id = @ColorPaletteID
			
		UPDATE pSampleRequestBOMTrade
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @ColorPaletteID
			
		/* UPDATE Quote tables */
		UPDATE pSourcingQuoteStyleBOM
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuoteStyleBOM.ItemDim2Id = @ColorPaletteID

		UPDATE pSourcingQuotationBOMDetails
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuotationBOMDetails.ItemDim2Id = @ColorPaletteID

		UPDATE pSourcingCostOptionDetail
		SET ItemDim2Id = @StyleColorID
		FROM pSourcingCostOptionDetail
			INNER JOIN pSourcingQuotationBOMDetails ON pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID
		WHERE pSourcingQuotationBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCostOptionDetail.ItemDim2Id = @ColorPaletteID
			
		/* UPDATE Commit tables */
		UPDATE pSourcingCommitmentBOM
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOM.ItemDim2Id = @ColorPaletteID

		UPDATE pSourcingCommitmentBOMDetails
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOMDetails.ItemDim2Id = @ColorPaletteID

		UPDATE pSourcingCommitmentCostOptionDetail
		SET ItemDim2Id = @StyleColorID
		FROM pSourcingCommitmentCostOptionDetail
			INNER JOIN pSourcingCommitmentBOMDetails ON pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingCommitmentBOMDetails.SourcingCommitmentBOMDetailsID
		WHERE pSourcingCommitmentBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCommitmentCostOptionDetail.ItemDim2Id = @ColorPaletteID
		
	END
	ELSE IF @DimLevel = 3
	BEGIN
		UPDATE pSampleRequestBOMActivity
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestBOMActivity
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestBOMActivity.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestBOMActivity.ItemDim3Id = @ColorPaletteID
			
		UPDATE pSampleRequestMaterialBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestMaterialBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestMaterialBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestMaterialBOM.ItemDim2Id = @ColorPaletteID
			
		UPDATE pSampleRequestQASizeBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestQASizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestQASizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestQASizeBOM.ItemDim3Id = @ColorPaletteID
			
		UPDATE pSampleRequestSpecItemBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestSpecItemBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecItemBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecItemBOM.ItemDim3Id = @ColorPaletteID
			
		UPDATE pSampleRequestSpecSizeBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestSpecSizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecSizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecSizeBOM.ItemDim3Id = @ColorPaletteID
			
		UPDATE pSampleRequestStyleBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestStyleBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestStyleBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOM.ItemDim3Id = @ColorPaletteID

		UPDATE pSampleRequestStyleBOMColorwayTemp
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOMColorwayTemp.ItemDim3Id = @ColorPaletteID

		UPDATE pSampleRequestSubmitBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestSubmitBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSubmitBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSubmitBOM.ItemDim3Id = @ColorPaletteID

		UPDATE pSampleRequestWorkflowBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestWorkflowBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestWorkflowBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestWorkflowBOM.ItemDim3Id = @ColorPaletteID
			
		UPDATE pSampleRequestBOMTrade
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @ColorPaletteID
			
		/* UPDATE Quote tables */
		UPDATE pSourcingQuoteStyleBOM
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuoteStyleBOM.ItemDim3Id = @ColorPaletteID

		UPDATE pSourcingQuotationBOMDetails
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuotationBOMDetails.ItemDim3Id = @ColorPaletteID

		UPDATE pSourcingCostOptionDetail
		SET ItemDim3Id = @StyleColorID
		FROM pSourcingCostOptionDetail
			INNER JOIN pSourcingQuotationBOMDetails ON pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID
		WHERE pSourcingQuotationBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCostOptionDetail.ItemDim3Id = @ColorPaletteID
			
		/* UPDATE Commit tables */
		UPDATE pSourcingCommitmentBOM
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOM.ItemDim3Id = @ColorPaletteID

		UPDATE pSourcingCommitmentBOMDetails
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOMDetails.ItemDim3Id = @ColorPaletteID

		UPDATE pSourcingCommitmentCostOptionDetail
		SET ItemDim3Id = @StyleColorID
		FROM pSourcingCommitmentCostOptionDetail
			INNER JOIN pSourcingCommitmentBOMDetails ON pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingCommitmentBOMDetails.SourcingCommitmentBOMDetailsID
		WHERE pSourcingCommitmentBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCommitmentCostOptionDetail.ItemDim3Id = @ColorPaletteID
			
	END
	
	print REPLICATE('-',5) + ' finishing update BOM, samples, quotes, commitments tables from ColorPaletteID to StyleColorID ' + REPLICATE('-',5)


	SET @iRow = @iRow + 1
END



DROP TABLE #WorkflowItemColor


IF @DEBUG = 1
	ROLLBACK TRAN
ELSE
	COMMIT TRAN
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07272', GetDate())
GO
