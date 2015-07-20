/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimItem_REPLACE]    Script Date: 03/18/2014 12:49:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimItem_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimItem_REPLACE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimItem_REPLACE]    Script Date: 03/18/2014 12:49:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimItem_REPLACE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@DimLevel INT,
	@DimID UNIQUEIDENTIFIER,
	@NewDimID UNIQUEIDENTIFIER,
	@NewDimName NVARCHAR(200) = NULL,
	@CUser NVARCHAR(200) = 'System',
	@CDate DATETIME = NULL
AS
BEGIN

BEGIN TRANSACTION

	IF @NewDimName IS NULL
	BEGIN
		DECLARE @DimTypeName NVARCHAR(20) = (SELECT V.ItemDimTypeName FROM pStyleBOMDimension
											 CROSS APPLY (VALUES(ItemDim1TypeName, 1),
																(ItemDim2TypeName, 2),
																(ItemDim3TypeName, 3))
															   V(ItemDimTypeName, DimLevel)
											 WHERE StyleBOMDimensionID = @StyleBOMDimensionID 
												AND V.DimLevel = @DimLevel)
		
		IF @DimTypeName = 'Color'
		BEGIN
			SELECT @NewDimName = ColorName FROM pColorPalette WHERE ColorPaletteID = @NewDimID
		END
	END
	
	IF @CDate IS NULL
		SET @CDate = CURRENT_TIMESTAMP
	
	-- Inserting the color to Style Colorway, if it doesn't already have it
	DECLARE @StyleColorID UNIQUEIDENTIFIER
	DECLARE @StyleID UNIQUEIDENTIFIER
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	DECLARE @ColorCode NVARCHAR(200)
	
	SELECT @StyleID = bom.StyleID, @SeasonYearID = ssy.SeasonYearID FROM pStyleBOMDimension bom 
	INNER JOIN pWorkFlowItem wi ON bom.WorkFlowItemID = wi.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ssy ON ssy.StyleSeasonYearID = wi.StyleSeasonYearID
	WHERE bom.StyleBomDimensionID = @StyleBOMDimensionID
	
	SELECT @ColorCode = ColorCode FROM pColorPalette WHERE ColorPaletteID = @NewDimID
	
	-- Inserting the Color to the Colorway, if it doesn't already have it
	EXEC spx_StyleColorway_Color_INSERT_SELECT @StyleID, 
											@NewDimID, 
											@ColorCode,
											@NewDimName,
											@SeasonYearID, 
											@StyleColorID OUT,
											@CUser, 
											@CDate
											
	IF	(@DimLevel = 1 AND (SELECT COUNT(*) FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @StyleColorID) > 0) OR
		(@DimLevel = 2 AND (SELECT COUNT(*) FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @StyleColorID) > 0) OR
		(@DimLevel = 3 AND (SELECT COUNT(*) FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @StyleColorID) > 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN
	END
			
	DECLARE @ChangeManagement nVARCHAR(5) = (SELECT UPPER(RTRIM(LTRIM(AppSettingValue))) FROM sAppSetting WHERE AppSettingKey = 'ChangeManagementEnabled')	
	DECLARE @BeforeText NVARCHAR(4000) = (SELECT ISNULL(StyleColorNo, '') + ' - ' + ISNULL(StyleColorName, '') FROM pStyleColorway WHERE StyleColorID = @DimID)
	DECLARE @AfterText NVARCHAR(4000) = (SELECT ISNULL(StyleColorNo, '') + ' - ' + ISNULL(StyleColorName, '') FROM pStyleColorway WHERE StyleColorID = @StyleColorID)
	DECLARE @ChangeLog TABLE(
		ChangeTableID UNIQUEIDENTIFIER,
		ChangeTablePKID UNIQUEIDENTIFIER,
		ChangeFieldName NVARCHAR(200),
		ChangeFieldAlias NVARCHAR(200),
		ChangeBeforeValue NVARCHAR(200),
		ChangeAfterValue NVARCHAR(200),
		ChangeBeforeText NVARCHAR(4000),
		ChangeAfterText NVARCHAR(4000),
		ChangeSubject NVARCHAR(400)
	)
	
	IF @DimLevel = 1
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		
		UPDATE pStyleBOMDimensionItems SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		
		UPDATE pStyleBOMItem SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		
		/* UPDATE Sample request tables */
		UPDATE pSampleRequestBOMActivity
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestBOMActivity
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestBOMActivity.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestBOMActivity.ItemDim1Id = @DimID
			
		UPDATE pSampleRequestMaterialBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestMaterialBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestMaterialBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestMaterialBOM.ItemDim1Id = @DimID

		UPDATE pSampleRequestQASizeBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestQASizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestQASizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestQASizeBOM.ItemDim1Id = @DimID

		UPDATE pSampleRequestSpecItemBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestSpecItemBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecItemBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecItemBOM.ItemDim1Id = @DimID

		UPDATE pSampleRequestSpecSizeBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestSpecSizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecSizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecSizeBOM.ItemDim1Id = @DimID
		
		UPDATE pSampleRequestStyleBOM
		SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		FROM pSampleRequestStyleBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestStyleBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOM.ItemDim1Id = @DimID

		UPDATE pSampleRequestSubmitBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestSubmitBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSubmitBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSubmitBOM.ItemDim1Id = @DimID

		UPDATE pSampleRequestWorkflowBOM
		SET ItemDim1Id = @StyleColorID
		FROM pSampleRequestWorkflowBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestWorkflowBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestWorkflowBOM.ItemDim1Id = @DimID
			
		-- save changes to change log table		
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT 'AA16FAAA-7ACD-DF11-AF06-005056C00008', srt.StyleID, 'ItemDim1Id', 
				'Sample (' 
					+ CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
						THEN tprl.TradePartnerFullName 
						ELSE tp.TradePartnerName + '/' + tpv.VendorName
					  END + ' - ' + ssy.StyleSeason + ' ' + ssy.StyleYear + ') Dim1',
				@DimID, @StyleColorID, @BeforeText, @AfterText, 
				'Sample (' 
					+ CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
						THEN tprl.TradePartnerFullName 
						ELSE tp.TradePartnerName + '/' + tpv.VendorName
					  END + ' ' + ssy.StyleSeason + ' ' + ssy.StyleYear + ') Changed'
			FROM pSampleRequestBOMTrade	srt	
			LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
			LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID
			LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID
			INNER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		END
			
		UPDATE pSampleRequestBOMTrade
		SET ItemDim1Id = @StyleColorID						
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
			
		/* UPDATE Quote tables */
		-- save changes to change log table		
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT '8038A3FD-0580-422F-A3A6-895CA0223A81', sqsb.StyleQuoteItemID, 'ItemDim1Id', 'Color', 
				@DimID, @StyleColorID, @BeforeText, @AfterText, N'Quote #' + CAST(sqsb.StyleQuoteItemNo AS nVARCHAR(20)) + ' Changed'
			FROM (SELECT DISTINCT sqsb.StyleQuoteItemID, sqi.StyleQuoteItemNo
				  FROM pSourcingQuoteStyleBOM sqsb
				  INNER JOIN pStyleQuoteItem sqi ON sqsb.StyleQuoteItemID = sqi.StyleQuoteItemID
				  WHERE StyleBOMDimensionID = @StyleBOMDimensionID
				      AND ItemDim1Id = @DimID) sqsb
		END
		
		UPDATE pSourcingQuoteStyleBOM
		SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuoteStyleBOM.ItemDim1Id = @DimID

		UPDATE pSourcingQuotationBOMDetails
		SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuotationBOMDetails.ItemDim1Id = @DimID

		UPDATE pSourcingCostOptionDetail
		SET ItemDim1Id = @StyleColorID
		FROM pSourcingCostOptionDetail
			INNER JOIN pSourcingQuotationBOMDetails ON pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID
		WHERE pSourcingQuotationBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCostOptionDetail.ItemDim1Id = @DimID
			
		/* UPDATE Commit tables */
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT '9038A3FD-0580-422F-A3A6-895CA0223A81', scb.SourcingCommitmentItemID, 'ItemDim1Id', 'Color', 
				@DimID, @StyleColorID, @BeforeText, @AfterText, N'Commitment #' + CAST(scb.StyleCommitmentNo AS nVARCHAR(20)) + ' Changed'
			FROM (SELECT DISTINCT scb.SourcingCommitmentItemID, sci.StyleCommitmentNo
				  FROM pSourcingCommitmentBOM scb
				  INNER JOIN pSourcingCommitmentItem sci ON scb.SourcingCommitmentItemID = sci.SourcingCommitmentItemID
				  WHERE StyleBOMDimensionID = @StyleBOMDimensionID
					  AND scb.ItemDim1Id = @DimID) scb
		END
		
		UPDATE pSourcingCommitmentBOM
		SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOM.ItemDim1Id = @DimID

		UPDATE pSourcingCommitmentBOMDetails
		SET ItemDim1Id = @StyleColorID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOMDetails.ItemDim1Id = @DimID

		UPDATE pSourcingCommitmentCostOptionDetail
		SET ItemDim1Id = @StyleColorID
		FROM pSourcingCommitmentCostOptionDetail
			INNER JOIN pSourcingCommitmentBOMDetails ON pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingCommitmentBOMDetails.SourcingCommitmentBOMDetailsID
		WHERE pSourcingCommitmentBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCommitmentCostOptionDetail.ItemDim1Id = @DimID
		
	END
	ELSE IF @DimLevel = 2
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		
		UPDATE pStyleBOMDimensionItems SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		
		UPDATE pStyleBOMItem SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		
		/* UPDATE Sample request tables */
		UPDATE pSampleRequestBOMActivity
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestBOMActivity
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestBOMActivity.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestBOMActivity.ItemDim2Id = @DimID
			
		UPDATE pSampleRequestMaterialBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestMaterialBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestMaterialBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestMaterialBOM.ItemDim2Id = @DimID

		UPDATE pSampleRequestQASizeBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestQASizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestQASizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestQASizeBOM.ItemDim2Id = @DimID

		UPDATE pSampleRequestSpecItemBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestSpecItemBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecItemBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecItemBOM.ItemDim2Id = @DimID

		UPDATE pSampleRequestSpecSizeBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestSpecSizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecSizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecSizeBOM.ItemDim2Id = @DimID
		
		UPDATE pSampleRequestStyleBOM
		SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		FROM pSampleRequestStyleBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestStyleBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOM.ItemDim2Id = @DimID

		UPDATE pSampleRequestSubmitBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestSubmitBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSubmitBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSubmitBOM.ItemDim2Id = @DimID

		UPDATE pSampleRequestWorkflowBOM
		SET ItemDim2Id = @StyleColorID
		FROM pSampleRequestWorkflowBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestWorkflowBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestWorkflowBOM.ItemDim2Id = @DimID
			
		-- save changes to change log table		
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT 'AA16FAAA-7ACD-DF11-AF06-005056C00008', srt.StyleID, 'ItemDim2Id', 
				'Sample (' 
					+ CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
						THEN tprl.TradePartnerFullName 
						ELSE tp.TradePartnerName + '/' + tpv.VendorName
					  END + ' - ' + ssy.StyleSeason + ' ' + ssy.StyleYear + ') Dim2',
				@DimID, @StyleColorID, @BeforeText, @AfterText, 
				'Sample (' 
					+ CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
						THEN tprl.TradePartnerFullName 
						ELSE tp.TradePartnerName + '/' + tpv.VendorName
					  END + ' ' + ssy.StyleSeason + ' ' + ssy.StyleYear + ') Changed'
			FROM pSampleRequestBOMTrade	srt	
			LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
			LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID
			LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID
			INNER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		END
			
		UPDATE pSampleRequestBOMTrade
		SET ItemDim2Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
			
		/* UPDATE Quote tables */
		-- save changes to change log table		
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT '8038A3FD-0580-422F-A3A6-895CA0223A81', sqsb.StyleQuoteItemID, 'ItemDim2Id', 'Color', 
				@DimID, @StyleColorID, @BeforeText, @AfterText, N'Quote #' + CAST(sqsb.StyleQuoteItemNo AS nVARCHAR(20)) + ' Changed'
			FROM (SELECT DISTINCT sqsb.StyleQuoteItemID, sqi.StyleQuoteItemNo
				  FROM pSourcingQuoteStyleBOM sqsb
				  INNER JOIN pStyleQuoteItem sqi ON sqsb.StyleQuoteItemID = sqi.StyleQuoteItemID
				  WHERE StyleBOMDimensionID = @StyleBOMDimensionID
				      AND ItemDim2Id = @DimID) sqsb
		END
		
		UPDATE pSourcingQuoteStyleBOM
		SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuoteStyleBOM.ItemDim2Id = @DimID

		UPDATE pSourcingQuotationBOMDetails
		SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuotationBOMDetails.ItemDim2Id = @DimID

		UPDATE pSourcingCostOptionDetail
		SET ItemDim2Id = @StyleColorID
		FROM pSourcingCostOptionDetail
			INNER JOIN pSourcingQuotationBOMDetails ON pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID
		WHERE pSourcingQuotationBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCostOptionDetail.ItemDim2Id = @DimID
			
		/* UPDATE Commit tables */
		/* UPDATE Commit tables */
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT '9038A3FD-0580-422F-A3A6-895CA0223A81', scb.SourcingCommitmentItemID, 'ItemDim2Id', 'Color', 
				@DimID, @StyleColorID, @BeforeText, @AfterText, N'Commitment #' + CAST(scb.StyleCommitmentNo AS nVARCHAR(20)) + ' Changed'
			FROM (SELECT DISTINCT scb.SourcingCommitmentItemID, sci.StyleCommitmentNo
				  FROM pSourcingCommitmentBOM scb
				  INNER JOIN pSourcingCommitmentItem sci ON scb.SourcingCommitmentItemID = sci.SourcingCommitmentItemID
				  WHERE StyleBOMDimensionID = @StyleBOMDimensionID
					  AND scb.ItemDim2Id = @DimID) scb
		END
		
		UPDATE pSourcingCommitmentBOM
		SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOM.ItemDim2Id = @DimID

		UPDATE pSourcingCommitmentBOMDetails
		SET ItemDim2Id = @StyleColorID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOMDetails.ItemDim2Id = @DimID

		UPDATE pSourcingCommitmentCostOptionDetail
		SET ItemDim2Id = @StyleColorID
		FROM pSourcingCommitmentCostOptionDetail
			INNER JOIN pSourcingCommitmentBOMDetails ON pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingCommitmentBOMDetails.SourcingCommitmentBOMDetailsID
		WHERE pSourcingCommitmentBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCommitmentCostOptionDetail.ItemDim2Id = @DimID
		
	END
	ELSE IF @DimLevel = 3
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		
		UPDATE pStyleBOMDimensionItems SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		
		UPDATE pStyleBOMItem SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		
		/* UPDATE Sample request tables */
		UPDATE pSampleRequestBOMActivity
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestBOMActivity
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestBOMActivity.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestBOMActivity.ItemDim3Id = @DimID
			
		UPDATE pSampleRequestMaterialBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestMaterialBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestMaterialBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestMaterialBOM.ItemDim3Id = @DimID

		UPDATE pSampleRequestQASizeBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestQASizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestQASizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestQASizeBOM.ItemDim3Id = @DimID

		UPDATE pSampleRequestSpecItemBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestSpecItemBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecItemBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecItemBOM.ItemDim3Id = @DimID

		UPDATE pSampleRequestSpecSizeBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestSpecSizeBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSpecSizeBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSpecSizeBOM.ItemDim3Id = @DimID
		
		UPDATE pSampleRequestStyleBOM
		SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		FROM pSampleRequestStyleBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestStyleBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestStyleBOM.ItemDim3Id = @DimID

		UPDATE pSampleRequestSubmitBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestSubmitBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestSubmitBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestSubmitBOM.ItemDim3Id = @DimID

		UPDATE pSampleRequestWorkflowBOM
		SET ItemDim3Id = @StyleColorID
		FROM pSampleRequestWorkflowBOM
			INNER JOIN pSampleRequestBOMTrade ON pSampleRequestWorkflowBOM.SampleRequestTradeId = pSampleRequestBOMTrade.SampleRequestTradeID
		WHERE pSampleRequestBOMTrade.StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSampleRequestWorkflowBOM.ItemDim3Id = @DimID
			
		-- save changes to change log table		
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT 'AA16FAAA-7ACD-DF11-AF06-005056C00008', srt.StyleID, 'ItemDim3Id', 
				'Sample (' 
					+ CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
						THEN tprl.TradePartnerFullName 
						ELSE tp.TradePartnerName + '/' + tpv.VendorName
					  END + ' - ' + ssy.StyleSeason + ' ' + ssy.StyleYear + ') Dim3',
				@DimID, @StyleColorID, @BeforeText, @AfterText, 
				'Sample (' 
					+ CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
						THEN tprl.TradePartnerFullName 
						ELSE tp.TradePartnerName + '/' + tpv.VendorName
					  END + ' ' + ssy.StyleSeason + ' ' + ssy.StyleYear + ') Changed'
			FROM pSampleRequestBOMTrade	srt	
			LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
			LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID
			LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID
			INNER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
			WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		END
		
		UPDATE pSampleRequestBOMTrade
		SET ItemDim3Id = @StyleColorID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
			
		/* UPDATE Quote tables */
		-- save changes to change log table		
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT '8038A3FD-0580-422F-A3A6-895CA0223A81', sqsb.StyleQuoteItemID, 'ItemDim3Id', 'Color', 
				@DimID, @StyleColorID, @BeforeText, @AfterText, N'Quote #' + CAST(sqsb.StyleQuoteItemNo AS nVARCHAR(20)) + ' Changed'
			FROM (SELECT DISTINCT sqsb.StyleQuoteItemID, sqi.StyleQuoteItemNo
				  FROM pSourcingQuoteStyleBOM sqsb
				  INNER JOIN pStyleQuoteItem sqi ON sqsb.StyleQuoteItemID = sqi.StyleQuoteItemID
				  WHERE StyleBOMDimensionID = @StyleBOMDimensionID
				      AND ItemDim3Id = @DimID) sqsb
		END
		
		UPDATE pSourcingQuoteStyleBOM
		SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuoteStyleBOM.ItemDim3Id = @DimID

		UPDATE pSourcingQuotationBOMDetails
		SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingQuotationBOMDetails.ItemDim3Id = @DimID

		UPDATE pSourcingCostOptionDetail
		SET ItemDim3Id = @StyleColorID
		FROM pSourcingCostOptionDetail
			INNER JOIN pSourcingQuotationBOMDetails ON pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID
		WHERE pSourcingQuotationBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCostOptionDetail.ItemDim3Id = @DimID
			
		/* UPDATE Commit tables */
		/* UPDATE Commit tables */
		IF @ChangeManagement = 'TRUE'
		BEGIN
			INSERT INTO @ChangeLog(
				ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSubject)
			SELECT '9038A3FD-0580-422F-A3A6-895CA0223A81', scb.SourcingCommitmentItemID, 'ItemDim3Id', 'Color', 
				@DimID, @StyleColorID, @BeforeText, @AfterText, N'Commitment #' + CAST(scb.StyleCommitmentNo AS nVARCHAR(20)) + ' Changed'
			FROM (SELECT DISTINCT scb.SourcingCommitmentItemID, sci.StyleCommitmentNo
				  FROM pSourcingCommitmentBOM scb
				  INNER JOIN pSourcingCommitmentItem sci ON scb.SourcingCommitmentItemID = sci.SourcingCommitmentItemID
				  WHERE StyleBOMDimensionID = @StyleBOMDimensionID
					  AND scb.ItemDim3Id = @DimID) scb
		END
		
		UPDATE pSourcingCommitmentBOM
		SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOM.ItemDim3Id = @DimID

		UPDATE pSourcingCommitmentBOMDetails
		SET ItemDim3Id = @StyleColorID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND pSourcingCommitmentBOMDetails.ItemDim3Id = @DimID

		UPDATE pSourcingCommitmentCostOptionDetail
		SET ItemDim3Id = @StyleColorID
		FROM pSourcingCommitmentCostOptionDetail
			INNER JOIN pSourcingCommitmentBOMDetails ON pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID = pSourcingCommitmentBOMDetails.SourcingCommitmentBOMDetailsID
		WHERE pSourcingCommitmentBOMDetails.StyleBOMDimensionId = @StyleBOMDimensionID
			AND pSourcingCommitmentCostOptionDetail.ItemDim3Id = @DimID
					
	END
	
	-- if color is deleted from DimBOM it should be deleted from SeasonalColorway page
	IF EXISTS (SELECT * FROM pStyleColorway WHERE StyleColorID = @DimID)
	BEGIN
		DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
		
		SELECT @StyleID = pStyleBOMDimension.StyleID, @StyleSeasonYearID = pWorkFlowItem.StyleSeasonYearID 
		FROM pStyleBOMDimension 
			INNER JOIN pWorkFlowItem ON pStyleBOMDimension.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		
		-- if the same color doesn't exist on other dimBOM pages with the same season year
		IF (SELECT COUNT(*) FROM pStyleBOMDimensionItem
				INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
			WHERE pStyleBOMDimensionItem.StyleID = @StyleID 
			AND pWorkFlowItem.StyleSeasonYearID = @StyleSeasonYearID
			AND (ItemDim1Id = @DimID OR ItemDim2Id = @DimID OR ItemDim3Id = @DimID)
			) = 0
		BEGIN
			DELETE pStyleColorwaySeasonYear 
			FROM pStyleColorwaySeasonYear INNER JOIN pStyleColorway ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID
			WHERE pStyleColorwaySeasonYear.StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
			AND StyleColorID = @DimID
		END
	END
	
	SELECT * FROM @ChangeLog
	
IF @@ERROR <> 0
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION

	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07251', GetDate())
GO
